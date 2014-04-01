#ifndef WRTTTS_H
#define WRTTTS_H

#include <QObject>
#include <etherbone.h>
#include <trigger_shared_regs.h>
#include <QStringList>
#include <QMutex>

class wrttts : public QObject
{
    Q_OBJECT
public:
    wrttts();

    void setDevAddress(eb_device_t device, eb_address_t address, QMutex* socket_mutex);

    void clearTriggerDetectionBuffer();
    void setConfigured(bool configured);

    bool isConfigured() {return cr & TTS_CR_CONFIGURED;}

    void updateFromDevice();

    void init();

    uint32_t cr;
    uint32_t fwId;

    eb_data_t triggerDetectionBuffer[TTS_TDB_RAM_WORDS];

    QStringList triggerListFromBitmap();

private:
    eb_device_t mDevice;
    eb_address_t mAddress;
    QMutex* mSocketMutex;
};

#endif // WRTTTS_H
