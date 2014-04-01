#ifndef WRTTTX_H
#define WRTTTX_H

#include <QObject>
#include <QString>
#include <QMutex>

#include "etherbone.h"
#include "trigger_tx_regs.h"

class wrtttx : public QObject
{
    Q_OBJECT
public:
    wrtttx();
    ~wrtttx();

    void setDevAddress(eb_device_t device, eb_address_t address, QMutex* socket_mutex);

    void resetCounter();
    void enable(bool);
    void setTriggerId(uint16_t);
    void setAdjustCycle(uint32_t);
    void setAdjustSubCycle(uint32_t);

    void setTxTriggerDelayInNs(double delay_in_ns);

    void init();
    QString toString();

    uint32_t cr;
    uint32_t counter;
    uint32_t adjustCycle;
    uint32_t adjustSubCycle;

    void updateFromDevice();

    //static const int mCycle = 0;
    //static const int mSubCycle = 0;
    static const double mInitialTriggerDelay = 54.0;

private:
    eb_device_t mDevice;
    eb_address_t mAddress;

    QMutex* mSocketMutex;

    //initial register values


    
};

#endif // WRTTTX_H
