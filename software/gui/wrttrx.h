#ifndef WRTTRX_H
#define WRTTRX_H

#include <QObject>
#include <etherbone.h>
#include <trigger_rx_regs.h>
#include <QMutex>

class wrttrx : public QObject
{
    Q_OBJECT
public:
    wrttrx();
    
    void setDevAddress(eb_device_t device, eb_address_t address, QMutex* socket_mutex);

    void setTriggerId(uint16_t);
    void resetHistogram();
    void resetCounter();
    void enable(bool);

    QString toString();

    void init();

    uint32_t cr;

    uint32_t rcvdCntr;
    uint32_t execCntr;

    uint32_t rxBiasHistogram;
    void setRxBiasHistogram(uint32_t bias);

    uint32_t rxHistogramScale;
    void setRxHistogramScale(uint32_t scale);

    uint32_t rxTriggerDelayCycles;
    void setRxTriggerDelayCycles(uint32_t cycles);

    uint32_t rxTriggerDelaySubCycles;
    void setRxTriggrDelaySubCycles(uint32_t subcycles);

    eb_data_t delayHistogramBuffer[TRX_DHB_RAM_WORDS];

    void setRxTriggerDelayInNs(double ns);

    void setHistogramTimeRange(uint32_t maxInNs);

    void updateFromDevice();

    static const int mHistogramBias = 0;
    static const double mHistogramMaxTimeInNs = 50000;
    static const int mInitialTriggerDelay = 35000;

private:
    eb_device_t mDevice;
    eb_address_t mAddress;

    QMutex* mSocketMutex;


};

#endif // WRTTRX_H
