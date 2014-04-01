#ifndef DATAREFRESHERTHREAD_H
#define DATAREFRESHERTHREAD_H

#include <QThread>
#include <QList>
#include <wrtebdevice.h>

class dataRefresherThread : public QThread
{
    Q_OBJECT
public:
    dataRefresherThread(QList<wrtEbDevice*>& devices);
    ~dataRefresherThread();

    void stop() {mRun = false; wait();}

signals:
    void updated();

private:
    void run();

    QList<wrtEbDevice*>& mDevices;

    const static int mMsecInterval = 5000;

    volatile bool mRun;
};

#endif // DATAREFRESHERTHREAD_H
