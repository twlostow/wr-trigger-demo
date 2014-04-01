#include "wrtttx.h"
#include "simple-eb.h"
#include <QDebug>
#include <math.h>

wrtttx::wrtttx()
{

}

wrtttx::~wrtttx()
{

}

void wrtttx::setDevAddress(eb_device_t device, eb_address_t address, QMutex* socket_mutex)
{
    mDevice = device;
    mAddress = address;
    cr = 0;
    mSocketMutex = socket_mutex;
    updateFromDevice();
}

void wrtttx::resetCounter()
{
    QMutexLocker ml(mSocketMutex);
    cr |= TTX_CR_RST_CNT;
    ebs_write(mDevice, mAddress + TTX_REG_CR, cr);
}

void wrtttx::enable(bool enabled)
{
    QMutexLocker ml(mSocketMutex);
    if (enabled)
        cr |= TTX_CR_ENABLE;
    else
        cr &= ~TTX_CR_ENABLE;

    qDebug() << "Writing CR";
    ebs_write(mDevice, mAddress + TTX_REG_CR, cr);
}

void wrtttx::setTriggerId(uint16_t trigger_id)
{
    QMutexLocker ml(mSocketMutex);
    cr &= ~TTX_CR_ID_MASK;                      //mask
    cr |= trigger_id << TTX_CR_ID_SHIFT;        //OR new one
    ebs_write(mDevice, mAddress + TTX_REG_CR, cr);
}

void wrtttx::setAdjustCycle(uint32_t ac)
{
    QMutexLocker ml(mSocketMutex);
    adjustCycle = ac;
    ebs_write(mDevice, mAddress + TTX_REG_ADJ_C, ac);
}

void wrtttx::setAdjustSubCycle(uint32_t asc)
{
    QMutexLocker ml(mSocketMutex);
    adjustSubCycle = asc;
    ebs_write(mDevice, mAddress + TTX_REG_ADJ_F, asc);
}

void wrtttx::setTxTriggerDelayInNs(double ns)
{
    uint32_t cycles = floor(ns / 8.0);  //100us => 100,000 ns => 17b
		printf("adjtx %.3f cyc %d\n", ns ,cycles);
    double cycleFraction = fmod(ns, 8.0) / 8.0 * (1 << 12);
    uint32_t subcycles = lrint(cycleFraction);       //scale subcycles to 12 bits
    qDebug() << QString("AdjTx: C: %1 F:%2").arg(cycles, 16).arg(subcycles,16);
    setAdjustCycle(cycles);
    setAdjustSubCycle(cycles);
}

void wrtttx::updateFromDevice()
{
    //qDebug() << "wrtttx update";
    cr = ebs_read(mDevice, mAddress + TTX_REG_CR);

    counter = ebs_read(mDevice, mAddress + TTX_REG_CNTR);

    adjustCycle = ebs_read(mDevice, mAddress + TTX_REG_ADJ_C);
    adjustSubCycle = ebs_read(mDevice, mAddress + TTX_REG_ADJ_F);
}


void wrtttx::init()
{
    setTxTriggerDelayInNs(mInitialTriggerDelay);
    setTriggerId(0);
    resetCounter();
    enable(false);
}

QString wrtttx::toString()
{
    QString result = QString("TX - %1 - %2").arg(cr & TTX_CR_ENABLE ?  "Enabled": "Disabled").arg((cr >> 2) & 0xFFFF);
    return result;
}
