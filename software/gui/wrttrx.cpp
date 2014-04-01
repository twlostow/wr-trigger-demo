#include "wrttrx.h"
#include <simple-eb.h>
#include <QDebug>
#include <math.h>
#include <QMutexLocker>

wrttrx::wrttrx()
{

}

void wrttrx::setDevAddress(eb_device_t device, eb_address_t address, QMutex* socket_mutex)
{
    mDevice = device;
    mAddress = address;
    mSocketMutex = socket_mutex;
    updateFromDevice();
}

void wrttrx::setTriggerId(uint16_t triggerId)
{
    QMutexLocker ml(mSocketMutex);
    cr &= ~TRX_CR_ID_MASK;
    cr |= triggerId << TRX_CR_ID_SHIFT;
    ebs_write(mDevice, mAddress + TRX_REG_CR, cr);
}

void wrttrx::resetHistogram()
{
    QMutexLocker ml(mSocketMutex);
    cr |= TRX_CR_RST_HIST;
    ebs_write(mDevice, mAddress + TRX_REG_CR, cr);
}

void wrttrx::resetCounter()
{
    QMutexLocker ml(mSocketMutex);
    cr |= TRX_CR_RST_CNT;
    ebs_write(mDevice, mAddress + TRX_REG_CR, cr);
}

void wrttrx::enable(bool enabled)
{
    QMutexLocker ml(mSocketMutex);
    if (enabled)
        cr |= TRX_CR_ENABLE;
    else
        cr &= ~TRX_CR_ENABLE;

    ebs_write(mDevice, mAddress + TRX_REG_CR, cr);
}


void wrttrx::setRxBiasHistogram(uint32_t bias)
{
    QMutexLocker ml(mSocketMutex);
    rxBiasHistogram = bias;
    ebs_write(mDevice, mAddress + TRX_REG_RX_HIST_BIAS, bias);
}

void wrttrx::setRxHistogramScale(uint32_t scale)
{
    QMutexLocker ml(mSocketMutex);
    rxHistogramScale = scale;
    ebs_write(mDevice, mAddress + TRX_REG_RX_HIST_SCALE, scale);
}


void wrttrx::setRxTriggerDelayCycles(uint32_t cycles)
{
    QMutexLocker ml(mSocketMutex);
    //qDebug() << "Setting cycles " << cycles;
    rxTriggerDelayCycles = cycles;
    ebs_write(mDevice, mAddress + TRX_REG_DELAY_C, cycles);
}


void wrttrx::setRxTriggrDelaySubCycles(uint32_t subcycles)
{
    QMutexLocker ml(mSocketMutex);
    //qDebug() << "Setting subcycles " << subcycles;
    rxTriggerDelaySubCycles = subcycles;
    ebs_write(mDevice, mAddress + TRX_REG_DELAY_F, subcycles);
}


void wrttrx::updateFromDevice()
{
    //qDebug() << "wrttrx update";
    cr = ebs_read(mDevice, mAddress + TRX_REG_CR);

    rcvdCntr = ebs_read(mDevice, mAddress + TRX_REG_CNTR_RX);
    execCntr = ebs_read(mDevice, mAddress + TRX_REG_CNTR_EXEC);

    rxBiasHistogram = ebs_read(mDevice, mAddress + TRX_REG_RX_HIST_BIAS);
    rxHistogramScale = ebs_read(mDevice, mAddress + TRX_REG_RX_HIST_SCALE);
    qDebug() << "Read HS: " << rxHistogramScale;

    rxTriggerDelayCycles = ebs_read(mDevice, mAddress + TRX_REG_DELAY_C);
    rxTriggerDelaySubCycles = ebs_read(mDevice, mAddress + TRX_REG_DELAY_F);

    for (int i = 0; i < TRX_DHB_RAM_WORDS / 32; i++)
        ebs_block_read(mDevice, mAddress + TRX_DHB_RAM_BASE + (i * 32 * 4), delayHistogramBuffer + i * 32, 32, true);
}

void wrttrx::init()
{
    resetCounter();
    resetHistogram();
    setHistogramTimeRange(mHistogramMaxTimeInNs);
    setRxTriggerDelayInNs(mInitialTriggerDelay);
    //enable(true);
}

void wrttrx::setRxTriggerDelayInNs(double ns)
{
    uint32_t cycles = floor(ns / 8.0);  //100us => 100,000 ns => 17b
    double cycleFraction = fmod(ns, 8.0) / 8.0 * (1 << 12);
    uint32_t subcycles = lrint(cycleFraction);       //scale subcycles to 12 bits
    qDebug() << QString("C: %1 F:%2").arg(cycles, 16).arg(subcycles,16);
    setRxTriggerDelayCycles(cycles);
    setRxTriggrDelaySubCycles(subcycles);
}


void wrttrx::setHistogramTimeRange(uint32_t maxInNs)
{
    double binSizeIn8Ns = maxInNs / ((double)(TRX_DHB_RAM_WORDS) * 8.0);
    //qDebug() << "Bin size in 8 ns: " << binSizeIn8Ns;
    double scale = double(1<<17) * (double)TRX_DHB_RAM_WORDS / (maxInNs / 8.0);
    qDebug() << QString("Scale: %1 (%2) ").arg(scale).arg(scale / (1 << 17));
    setRxHistogramScale(lrint(scale));
    setRxBiasHistogram(0);
    //setRxHistogramScale((1<<17) - 1);
}


QString wrttrx::toString()
{
    QString result = QString("RX - %1 - %2").arg(cr & TRX_CR_ENABLE ? "Enabled": "Disabled").arg((cr >> 3) & 0xFFFF);
    return result;
}
