#include "wrtebdevice.h"
#include <simple-eb.h>
#include <wrttts.h>
#include <QDebug>
#include <QMutexLocker>
extern "C" {
    #include "fdelay_lib.h"
}

const double wrtEbDevice::DIOAdjustDelayRx[5] = {-117.0, -117.0, -117.0, -117.0, -117.0};
const double wrtEbDevice::DIOAdjustDelayTx[5] = {0,0,0,0,0};

const double wrtEbDevice::FDAdjustDelayTx[1] = {69.0};
const double wrtEbDevice::FDAdjustDelayRx[1] = {0};


#define DIO_FW  0
#define FD_FW   1

wrtEbDevice::wrtEbDevice():
    mValid(false)
{
}

double wrtEbDevice::adjustRxDelay(int device)
{
    if (mDeviceType == DIO)
    {
        if ((device >= 0) && (device < 5))
        {
            return DIOAdjustDelayRx[device];
        }
    }
    if (mDeviceType == FD)
    {
        if (device == 0)
        {
            return FDAdjustDelayRx[0];
        }
    }
    return 0;
}

double wrtEbDevice::adjustTxDelay(int device)
{
    if (mDeviceType == DIO)
    {
    		return 54.0;
/*        if ((device >= 0) && (device < 5))
        {
            return DIOAdjustDelayTx[device];
        }*/
    }
    if (mDeviceType == FD)
    {
        if (device == 0)
        {
        		fprintf(stderr,"FDDelay : %.1f\n", FDAdjustDelayTx[0]);
            return FDAdjustDelayTx[0];
        }
    }
    return 0;
}


wrtEbDevice::~wrtEbDevice()
{
    if (!mValid)
        return;
    eb_status_t status;
    eb_socket_t socket = eb_device_socket(mEbDevice);

    status = eb_device_close(mEbDevice);
    if (status != EB_OK)
        return;

    eb_socket_close(socket);

    while (!txCores.isEmpty())
        delete txCores.takeFirst();

    while (!rxCores.isEmpty())
        delete rxCores.takeFirst();
}

QString wrtEbDevice::toString()
{
    QString result;
    switch (mDeviceType)
    {
        case DIO:
            result = "DIO";
            break;
        case FD:
            result = "FD";
            break;
    }
    result += " - " + mAddress;
    return result;
}

eb_status_t wrtEbDevice::openDevice(QString address)
{
    mAddress = address;

    eb_status_t result;

    result = ebs_open(&mEbDevice, address.toAscii().constData());

    if (result  != EB_OK)
    {
        qDebug() << "ebs_open() failed..." << result;

        return result;
    }

    sharedCore.setDevAddress(mEbDevice, 0x80000, &mEbSocketMutex);

    mDeviceType = (deviceType_e)sharedCore.fwId;

    //qDebug() << "Type: " << mDeviceType;

    //create objects for managing cores
    if (mDeviceType == DIO_FW)      //set up DIO (5xTX, 5xRX)
    {
        for (int i = 0; i < 5; i++)     //set up new txCores
        {
            wrtttx* txCore = new wrtttx;
            txCore->setDevAddress(mEbDevice, 0x81000 + (i * 0x1000), &mEbSocketMutex);
            txCores.append(txCore);

            wrttrx* rxCore = new wrttrx;
            rxCore->setDevAddress(mEbDevice, 0x86000 + (i * 0x1000), &mEbSocketMutex);
            rxCores.append(rxCore);
        }
    }

    if (mDeviceType == FD_FW)       //set up FD (1xRX, 1xTX)
    {



        //generic config
        wrtttx* txCore = new wrtttx;
        txCore->setDevAddress(mEbDevice, 0x81000, &mEbSocketMutex);
        txCores.append(txCore);


        wrttrx* rxCore = new wrttrx;
        rxCore->setDevAddress(mEbDevice, 0x82000, &mEbSocketMutex);
        rxCores.append(rxCore);
    }

    //configure all cores
    if (!sharedCore.isConfigured())
    {
        qDebug() << "Device @ " << mAddress << " not configured!";
        setUpDevice();
    }
    else
        qDebug() << "Device @ " << mAddress << " already configured!";



    mValid = true;
    return EB_OK;
}

void wrtEbDevice::setUpDevice()
{
    if (mDeviceType == FD)
    {
        //initinf FD core
        QString laddress = mAddress;
        laddress = laddress.replace("udp/", "eb:");     //different address format


        fdelay_device_t *fd = fdelay_create();
        fdelay_probe(fd,laddress.toAscii().data());

        fdelay_time_t t;
        memset(&t, 0, sizeof(t));
        int finit_result = fdelay_init(fd, 0);
        if (finit_result != 0)
        {
            fdelay_release(fd);
            qDebug() << "Failed to configure FD";
            return;
        }

        fdelay_configure_sync(fd, FDELAY_SYNC_WR);
        fdelay_configure_trigger(fd, 1, 1);
        fdelay_configure_output(fd, 1, 1, 200000, 2000000, 0, 1);
        fdelay_release(fd);
        //done initing FD core
    }

    for (int i = 0; i < txCores.size(); i++)
    {
        txCores[i]->init();
        //adjust the delay at init
			printf("AdjustDelay\n");
        txCores[i]->setTxTriggerDelayInNs(52.0); //wrtttx::mInitialTriggerDelay + adjustTxDelay(i));
    }

    for (int i = 0; i < rxCores.size(); i++)
    {
        rxCores[i]->init();
        rxCores[i]->setRxTriggerDelayInNs(wrttrx::mInitialTriggerDelay + adjustRxDelay(i));
    }

    sharedCore.init();
}

void wrtEbDevice::refresh()
{
    //qDebug() << "wrtEbDevice::refresh();";
    QMutexLocker ml(&mEbSocketMutex);

    //qDebug() << "Shared";
    sharedCore.updateFromDevice();

    for (int i = 0; i < rxCores.size(); i++)
    {
        rxCores[i]->updateFromDevice();
        //qDebug() << "RX" << i;
    }

    for (int i = 0; i < txCores.size(); i++)
    {
        txCores[i]->updateFromDevice();
        //qDebug() << "TX" << i;
    }

}

