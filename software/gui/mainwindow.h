#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QList>
#include <wrtebdevice.h>
#include <datarefresherthread.h>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT
    
public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    
public slots:
    void refreshView();
    void selectedTx(int row);
    void selectedRx(int row);

    void refreshRx();
    void refreshTx();

    void toggleRxEnabled(bool on);
    void toggleTxEnabled(bool on);

    void setTxTriggerId(int id);
    void setRxTriggerId(QString value);

    void resetRxCounters();
    void setRxTriggerDelay(double ns);

private slots:
    void on_txReinitCoreButton_clicked();

    void on_rxReinitCoreButton_clicked();

private:
    Ui::MainWindow *ui;

    QList<wrtEbDevice*> mWrtEbDevices;

    void loadDevices();

    dataRefresherThread* mDataRefresherThread;

    wrttrx* mSelectedRx;
    wrtttx* mSelectedTx;
    wrtEbDevice* mSelectedDevice;
};

#endif // MAINWINDOW_H
