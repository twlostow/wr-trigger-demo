#include "wrttts.h"

#include <simple-eb.h>

#include <QDebug>

wrttts::wrttts()
{

}

void wrttts::setDevAddress(eb_device_t device, eb_address_t address, QMutex* socket_mutex)
{
    mDevice = device;
    mAddress = address;
    mSocketMutex = socket_mutex;
    updateFromDevice();
}

void wrttts::clearTriggerDetectionBuffer()
{
    QMutexLocker ml(mSocketMutex);
    cr |= TTS_CR_CLEAR_TDB;
    ebs_write(mDevice, mAddress + TTS_REG_CR, cr);
}

void wrttts::setConfigured(bool configured)
{
    QMutexLocker ml(mSocketMutex);
    if (configured)
        cr |= TTS_CR_CONFIGURED;
    else
        cr &= ~TTS_CR_CONFIGURED;
    ebs_write(mDevice, mAddress + TTS_REG_CR, cr);
}


void wrttts::updateFromDevice()
{
    //qDebug() << "Read CR";
    cr = ebs_read(mDevice, mAddress + TTS_REG_CR);
    //qDebug() << "Read fwId";
    fwId = ebs_read(mDevice, mAddress + TTS_REG_IDR);

    //qDebug() << "Read Hist";
    for (int i = 0; i < TTS_TDB_RAM_WORDS/32; i++)
    {
        ebs_block_read(mDevice, mAddress + TTS_TDB_RAM_BASE + (i * 32), triggerDetectionBuffer + (i * 32), 32, true);
    }
}

QStringList wrttts::triggerListFromBitmap()
{
    QStringList detectedTriggers;

    eb_data_t* d = triggerDetectionBuffer;
    int cntr = 0;
    for (int i = 0; i < TTS_TDB_RAM_WORDS; i++)
    {
        uint32_t w = *d++;
        for (int b = 0; b < 32; b++)
        {
            if (w & 0x1)
                detectedTriggers << QString::number(cntr);
            w >>= 1;
            cntr++;
        }
    }
    return detectedTriggers;
}

void wrttts::init()
{
    clearTriggerDetectionBuffer();
    setConfigured(true);
}
