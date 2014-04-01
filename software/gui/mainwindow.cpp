#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>


#include <QSettings>
#include <QScopedArrayPointer>
#include <QWidgetItem>
#include <QLineEdit>

#include <wrtebdevice.h>
#include <datarefresherthread.h>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    loadDevices();

    mDataRefresherThread = new dataRefresherThread(mWrtEbDevices);
    mDataRefresherThread->start();

    //refresh GUI with change of selected device or with refresh signal from updater thread
    connect(mDataRefresherThread, SIGNAL(updated()), this, SLOT(refreshView()));
    connect(ui->deviceList, SIGNAL(currentRowChanged(int)), this, SLOT(refreshView()));

    //refresh TX and RX elements
    connect(ui->rxCoreList, SIGNAL(currentRowChanged(int)), this, SLOT(selectedRx(int)));
    connect(ui->txCoreList, SIGNAL(currentRowChanged(int)), this, SLOT(selectedTx(int)));

    //enable/disable signals from boxes
    connect(ui->txGroupBox, SIGNAL(clicked(bool)), this, SLOT(toggleTxEnabled(bool)));
    connect(ui->rxGroupBox, SIGNAL(clicked(bool)), this, SLOT(toggleRxEnabled(bool)));

    //set trigged id for tx and rx
    connect(ui->txTriggerIdSpinbox, SIGNAL(valueChanged(int)), this, SLOT(setTxTriggerId(int)));
    connect(ui->rxTriggerIdCombobox, SIGNAL(activated(QString)), this, SLOT(setRxTriggerId(QString)));

    //clear counters and bitmap
    connect(ui->rxResetCountersButton, SIGNAL(clicked()), this, SLOT(resetRxCounters()));

    //delay spinbox callback
    connect(ui->rxTriggerDelaySpinBox, SIGNAL(valueChanged(double)), this, SLOT(setRxTriggerDelay(double)));
}


void MainWindow::loadDevices()
{
    QSettings s("wrt.ini", QSettings::IniFormat);

    QVariant vaddresses = s.value("devices");

    if (!vaddresses.isValid())
        return;

    QStringList addresses = vaddresses.toStringList();
    QStringList items;

    for (int i = 0; i < addresses.size(); i++)
    {
        QScopedPointer<wrtEbDevice> device(new wrtEbDevice);

        eb_status_t status = device->openDevice(addresses[i]);
        if (status != EB_OK)
            continue;       //device is being deleted by scoped pointer

        items << device->toString();            //add item to the list

        mWrtEbDevices.append(device.take());     //release device, move it to QList
    }

    ui->deviceList->clear();
    ui->deviceList->addItems(items);

    qDebug() << QString("Loaded %1 device(s)").arg(mWrtEbDevices.size());
}

void MainWindow::refreshView()
{
    //qDebug() << "refreshView()";
    int selectedDevice = ui->deviceList->currentRow();

    int tsr = ui->txCoreList->currentRow();
    int rsr = ui->rxCoreList->currentRow();

    ui->txCoreList->clear();
    ui->rxCoreList->clear();

    if (selectedDevice < 0)
    {
        mSelectedDevice = NULL;
        return;
    }

    wrtEbDevice* dev = mWrtEbDevices[selectedDevice];
    mSelectedDevice = dev;

    QStringList tcl;
    for (int i = 0; i < dev->txCores.size(); i++)
    {
        tcl << dev->txCores[i]->toString();
    }
    ui->txCoreList->addItems(tcl);
    ui->txCoreList->setCurrentRow(tsr);     //this should call updateTx

    if (tsr != -1)
        mSelectedTx = dev->txCores[tsr];
    else
        mSelectedTx = NULL;

    QStringList rcl;
    //int csr = ui->rxCoreList->currentRow();
    for (int i = 0; i < dev->rxCores.size(); i++)
    {
        rcl << dev->rxCores[i]->toString();
    }
    ui->rxCoreList->addItems(rcl);
    ui->rxCoreList->setCurrentRow(rsr);     //this should call updateRx;

    if (rsr != -1)
        mSelectedRx = dev->rxCores[rsr];
    else
        mSelectedRx = NULL;

}

void MainWindow::selectedRx(int row)
{
    //qDebug() << "SelectedRx" << row;
    if (mSelectedDevice == NULL)
        return;

    int selectedRxRow = ui->rxCoreList->currentRow();

    if (selectedRxRow < 0)
        mSelectedRx = NULL;
    else
        mSelectedRx = mSelectedDevice->rxCores[selectedRxRow];

    ui->rxHistogramPainter->setRxCore(mSelectedRx);

    refreshRx();
}

void MainWindow::selectedTx(int row)
{
    //qDebug() << "SelectedTx" << row;
    if (mSelectedDevice == NULL)
        return;

    int selectedTxRow = ui->txCoreList->currentRow();

    if (selectedTxRow < 0)
        mSelectedTx = NULL;
    else
        mSelectedTx = mSelectedDevice->txCores[selectedTxRow];

    refreshTx();
}

void MainWindow::refreshRx()
{
    if (mSelectedRx == NULL)
    {
        ui->txGroupBox->setChecked(false);
        return;
    }

    ui->rxGroupBox->setChecked(mSelectedRx->cr & TRX_CR_ENABLE);
    ui->rxTriggersExec->setText(QString::number(mSelectedRx->execCntr));
    ui->rxTriggersRcvd->setText(QString::number(mSelectedRx->rcvdCntr));


    //create a list of valid trigger values from the bitmap
    QStringList detectedTriggers = mSelectedDevice->sharedCore.triggerListFromBitmap();

    ui->rxTriggerIdCombobox->clear();
    ui->rxTriggerIdCombobox->insertItems(0, detectedTriggers);

    QString tt = QString::number((mSelectedRx->cr >> 3) & 0xFFFF);
    //uint32_t selectedTrigger = (mSelectedRx->cr >> 3) & 0xFFFF;
    uint32_t foundItem = ui->rxTriggerIdCombobox->findText(tt);
    ui->rxTriggerIdCombobox->setCurrentIndex(foundItem);

    int row = ui->rxCoreList->currentRow();
    double delay = (mSelectedRx->rxTriggerDelayCycles + (mSelectedRx->rxTriggerDelaySubCycles / 4096.0)) * 8.0;
    delay -= mSelectedDevice->adjustRxDelay(row);

    ui->rxTriggerDelaySpinBox->setValue(delay);
    ui->rxHistogramPainter->repaint();
}

void MainWindow::resetRxCounters()
{
    if (mSelectedDevice == NULL)
        return;

    if (mSelectedRx == NULL)
        return;

    mSelectedDevice->sharedCore.clearTriggerDetectionBuffer();
    mSelectedRx->resetHistogram();
    mSelectedRx->resetCounter();
    refreshRx();
}

void MainWindow::refreshTx()
{
    if (mSelectedTx == NULL)
    {
        ui->txGroupBox->setChecked(false);
        return;
    }

    ui->txGroupBox->setChecked(mSelectedTx->cr & TTX_CR_ENABLE);
    ui->txTriggerIdSpinbox->setValue((mSelectedTx->cr >> 2) & 0xFFFF);

    QListWidgetItem* i = ui->txCoreList->currentItem();
    i->setText(mSelectedTx->toString());
}

void MainWindow::toggleRxEnabled(bool on)
{
    if (mSelectedRx == NULL)  //if there's no selected, do not allow it to be turned on
    {
        ui->rxGroupBox->setChecked(false);
        return;
    }

    mSelectedRx->enable(on);
    QListWidgetItem* i = ui->rxCoreList->currentItem();
    i->setText(mSelectedRx->toString());
}

void MainWindow::toggleTxEnabled(bool on)
{
    if (mSelectedTx == NULL)  //if there's no selected, do not allow it to be turned on
    {
        ui->txGroupBox->setChecked(false);
        return;
    }

		mSelectedTx->setTxTriggerDelayInNs(mSelectedDevice->adjustTxDelay(0));

    mSelectedTx->enable(on);
    QListWidgetItem* i = ui->txCoreList->currentItem();
    i->setText(mSelectedTx->toString());
}

void MainWindow::setTxTriggerId(int id)
{
    if (mSelectedTx == NULL)
        return;

    mSelectedTx->setTriggerId(ui->txTriggerIdSpinbox->value());
		mSelectedTx->setTxTriggerDelayInNs(mSelectedDevice->adjustTxDelay(0));

    QListWidgetItem* i = ui->txCoreList->currentItem();
    i->setText(mSelectedTx->toString());
}

void MainWindow::setRxTriggerId(QString value)
{
    if (mSelectedRx == NULL)
        return;

    uint32_t rxTriggerId = value.toInt();
    mSelectedRx->setTriggerId(rxTriggerId);

    QListWidgetItem* i = ui->rxCoreList->currentItem();
    i->setText(mSelectedRx->toString());
    refreshRx();
}

void MainWindow::setRxTriggerDelay(double ns)
{
    if (mSelectedRx == NULL)
        return;

    //qDebug() << "Setting delay!";
    int row = ui->rxCoreList->currentRow();
    mSelectedRx->setRxTriggerDelayInNs(ns+mSelectedDevice->adjustRxDelay(row));
}

MainWindow::~MainWindow()
{
    //free all devices
    for (int i = 0; i < mWrtEbDevices.size(); i++)
        delete mWrtEbDevices[i];

    delete mDataRefresherThread;

    delete ui;
}

void MainWindow::on_txReinitCoreButton_clicked()
{
    if (mSelectedTx == NULL)
        return;

    mSelectedTx->init();
}

void MainWindow::on_rxReinitCoreButton_clicked()
{
    if (mSelectedRx == NULL)
        return;
	
    mSelectedRx->init();
}
