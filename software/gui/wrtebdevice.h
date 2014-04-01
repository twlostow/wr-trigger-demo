#ifndef WRTEBDEVICE_H
#define WRTEBDEVICE_H

#include <QObject>

#include "etherbone.h"
#include <wrttts.h>
#include <wrttrx.h>
#include <wrtttx.h>
#include <QList>
#include <QMutex>




class wrtEbDevice : public QObject
{
    Q_OBJECT
public:
    enum deviceType_e
    {
        DIO = 0,
        FD = 1
    };

    wrtEbDevice();
    ~wrtEbDevice();

    enum deviceType_e getDeviceType() {return mDeviceType;}

    eb_status_t openDevice(QString address);

    void refresh();     //updates information from the device

    QString toString();

    //cores in the device
    wrttts sharedCore;
    QList<wrtttx*> txCores;
    QList<wrttrx*> rxCores;

    void mutexLock() {mEbSocketMutex.lock();}
    void mutexUnlock() {mEbSocketMutex.unlock();}


    static const double DIOAdjustDelayRx[5];
    static const double DIOAdjustDelayTx[5];

    static const double FDAdjustDelayTx[1];
    static const double FDAdjustDelayRx[1];


    double adjustRxDelay(int device);
    double adjustTxDelay(int device);

private:

    void setUpDevice();

    eb_device_t mEbDevice;
    QString mAddress;

    deviceType_e mDeviceType;

    QMutex mEbSocketMutex;

    bool mValid;
};

#endif // WRTEBDEVICE_H
