#include "datarefresherthread.h"
#include <QDebug>

dataRefresherThread::dataRefresherThread(QList<wrtEbDevice*>& devices) :
    mDevices(devices), mRun(true)
{
    qDebug() << "Refresher thread created...";
}

dataRefresherThread::~dataRefresherThread()
{
    mRun = false;
    wait();
}

void dataRefresherThread::run()
{
    while (mRun)
    {
        qDebug() << " Refreshing data... " + mDevices.size();

        for (int i = 0; i < mDevices.size(); i++)
        {
            mDevices[i]->refresh();
        }

        emit updated();

        qDebug() << "Done";

        //make it a little more responsive
        for (int i = 0; i < 10; i++)
        {
            msleep(mMsecInterval/10);
            if (!mRun) return;
        }
    }
}
