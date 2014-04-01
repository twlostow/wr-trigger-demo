/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created: Fri Mar 15 00:21:54 2013
**      by: Qt User Interface Compiler version 4.8.1
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QComboBox>
#include <QtGui/QDoubleSpinBox>
#include <QtGui/QFrame>
#include <QtGui/QGridLayout>
#include <QtGui/QGroupBox>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QListWidget>
#include <QtGui/QMainWindow>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QSpinBox>
#include <QtGui/QWidget>
#include <histogrampainter.h>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralWidget;
    QGridLayout *gridLayout_2;
    QGridLayout *gridLayout;
    QLabel *label;
    QLabel *label_2;
    QFrame *line;
    QGroupBox *txGroupBox;
    QGridLayout *gridLayout_3;
    QSpinBox *txTriggerIdSpinbox;
    QLabel *label_4;
    QSpacerItem *verticalSpacer;
    QPushButton *txReinitCoreButton;
    QLabel *label_3;
    QListWidget *txCoreList;
    QListWidget *rxCoreList;
    QListWidget *deviceList;
    QGroupBox *rxGroupBox;
    QGridLayout *gridLayout_4;
    QLabel *label_5;
    QLabel *label_7;
    QLabel *label_6;
    QLabel *rxTriggersExec;
    QLabel *rxTriggersRcvd;
    QPushButton *rxResetCountersButton;
    QLabel *label_8;
    QComboBox *rxTriggerIdCombobox;
    QPushButton *rxReinitCoreButton;
    QDoubleSpinBox *rxTriggerDelaySpinBox;
    QFrame *frame;
    QHBoxLayout *horizontalLayout;
    histogramPainter *rxHistogramPainter;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QString::fromUtf8("MainWindow"));
        MainWindow->resize(1122, 604);
        centralWidget = new QWidget(MainWindow);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        gridLayout_2 = new QGridLayout(centralWidget);
        gridLayout_2->setSpacing(6);
        gridLayout_2->setContentsMargins(11, 11, 11, 11);
        gridLayout_2->setObjectName(QString::fromUtf8("gridLayout_2"));
        gridLayout = new QGridLayout();
        gridLayout->setSpacing(6);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        label = new QLabel(centralWidget);
        label->setObjectName(QString::fromUtf8("label"));

        gridLayout->addWidget(label, 0, 1, 1, 1);

        label_2 = new QLabel(centralWidget);
        label_2->setObjectName(QString::fromUtf8("label_2"));

        gridLayout->addWidget(label_2, 0, 3, 1, 1);

        line = new QFrame(centralWidget);
        line->setObjectName(QString::fromUtf8("line"));
        line->setFrameShape(QFrame::VLine);
        line->setFrameShadow(QFrame::Sunken);

        gridLayout->addWidget(line, 1, 2, 3, 1);

        txGroupBox = new QGroupBox(centralWidget);
        txGroupBox->setObjectName(QString::fromUtf8("txGroupBox"));
        QSizePolicy sizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(txGroupBox->sizePolicy().hasHeightForWidth());
        txGroupBox->setSizePolicy(sizePolicy);
        txGroupBox->setCheckable(true);
        txGroupBox->setChecked(false);
        gridLayout_3 = new QGridLayout(txGroupBox);
        gridLayout_3->setSpacing(6);
        gridLayout_3->setContentsMargins(11, 11, 11, 11);
        gridLayout_3->setObjectName(QString::fromUtf8("gridLayout_3"));
        txTriggerIdSpinbox = new QSpinBox(txGroupBox);
        txTriggerIdSpinbox->setObjectName(QString::fromUtf8("txTriggerIdSpinbox"));
        txTriggerIdSpinbox->setMaximum(4095);

        gridLayout_3->addWidget(txTriggerIdSpinbox, 0, 1, 1, 1);

        label_4 = new QLabel(txGroupBox);
        label_4->setObjectName(QString::fromUtf8("label_4"));

        gridLayout_3->addWidget(label_4, 0, 0, 1, 1);

        verticalSpacer = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_3->addItem(verticalSpacer, 2, 0, 1, 1);

        txReinitCoreButton = new QPushButton(txGroupBox);
        txReinitCoreButton->setObjectName(QString::fromUtf8("txReinitCoreButton"));

        gridLayout_3->addWidget(txReinitCoreButton, 1, 0, 1, 2);


        gridLayout->addWidget(txGroupBox, 0, 4, 2, 1);

        label_3 = new QLabel(centralWidget);
        label_3->setObjectName(QString::fromUtf8("label_3"));

        gridLayout->addWidget(label_3, 2, 3, 1, 1);

        txCoreList = new QListWidget(centralWidget);
        txCoreList->setObjectName(QString::fromUtf8("txCoreList"));
        txCoreList->setMaximumSize(QSize(200, 120));

        gridLayout->addWidget(txCoreList, 1, 3, 1, 1);

        rxCoreList = new QListWidget(centralWidget);
        rxCoreList->setObjectName(QString::fromUtf8("rxCoreList"));
        rxCoreList->setMaximumSize(QSize(200, 16777215));

        gridLayout->addWidget(rxCoreList, 3, 3, 1, 1);

        deviceList = new QListWidget(centralWidget);
        deviceList->setObjectName(QString::fromUtf8("deviceList"));
        deviceList->setMaximumSize(QSize(200, 16777215));

        gridLayout->addWidget(deviceList, 1, 1, 3, 1);

        rxGroupBox = new QGroupBox(centralWidget);
        rxGroupBox->setObjectName(QString::fromUtf8("rxGroupBox"));
        QSizePolicy sizePolicy1(QSizePolicy::Expanding, QSizePolicy::Preferred);
        sizePolicy1.setHorizontalStretch(0);
        sizePolicy1.setVerticalStretch(0);
        sizePolicy1.setHeightForWidth(rxGroupBox->sizePolicy().hasHeightForWidth());
        rxGroupBox->setSizePolicy(sizePolicy1);
        rxGroupBox->setCheckable(true);
        rxGroupBox->setChecked(false);
        gridLayout_4 = new QGridLayout(rxGroupBox);
        gridLayout_4->setSpacing(6);
        gridLayout_4->setContentsMargins(11, 11, 11, 11);
        gridLayout_4->setObjectName(QString::fromUtf8("gridLayout_4"));
        label_5 = new QLabel(rxGroupBox);
        label_5->setObjectName(QString::fromUtf8("label_5"));

        gridLayout_4->addWidget(label_5, 0, 1, 1, 1);

        label_7 = new QLabel(rxGroupBox);
        label_7->setObjectName(QString::fromUtf8("label_7"));

        gridLayout_4->addWidget(label_7, 2, 1, 1, 1);

        label_6 = new QLabel(rxGroupBox);
        label_6->setObjectName(QString::fromUtf8("label_6"));

        gridLayout_4->addWidget(label_6, 1, 1, 1, 1);

        rxTriggersExec = new QLabel(rxGroupBox);
        rxTriggersExec->setObjectName(QString::fromUtf8("rxTriggersExec"));

        gridLayout_4->addWidget(rxTriggersExec, 2, 2, 1, 1);

        rxTriggersRcvd = new QLabel(rxGroupBox);
        rxTriggersRcvd->setObjectName(QString::fromUtf8("rxTriggersRcvd"));

        gridLayout_4->addWidget(rxTriggersRcvd, 1, 2, 1, 1);

        rxResetCountersButton = new QPushButton(rxGroupBox);
        rxResetCountersButton->setObjectName(QString::fromUtf8("rxResetCountersButton"));

        gridLayout_4->addWidget(rxResetCountersButton, 1, 3, 2, 1);

        label_8 = new QLabel(rxGroupBox);
        label_8->setObjectName(QString::fromUtf8("label_8"));

        gridLayout_4->addWidget(label_8, 3, 1, 1, 1);

        rxTriggerIdCombobox = new QComboBox(rxGroupBox);
        rxTriggerIdCombobox->setObjectName(QString::fromUtf8("rxTriggerIdCombobox"));

        gridLayout_4->addWidget(rxTriggerIdCombobox, 0, 2, 1, 3);

        rxReinitCoreButton = new QPushButton(rxGroupBox);
        rxReinitCoreButton->setObjectName(QString::fromUtf8("rxReinitCoreButton"));

        gridLayout_4->addWidget(rxReinitCoreButton, 1, 4, 2, 1);

        rxTriggerDelaySpinBox = new QDoubleSpinBox(rxGroupBox);
        rxTriggerDelaySpinBox->setObjectName(QString::fromUtf8("rxTriggerDelaySpinBox"));
        rxTriggerDelaySpinBox->setMinimum(5000);
        rxTriggerDelaySpinBox->setMaximum(100000);
        rxTriggerDelaySpinBox->setSingleStep(1);
        rxTriggerDelaySpinBox->setValue(15000);

        gridLayout_4->addWidget(rxTriggerDelaySpinBox, 3, 2, 1, 3);

        frame = new QFrame(rxGroupBox);
        frame->setObjectName(QString::fromUtf8("frame"));
        sizePolicy.setHeightForWidth(frame->sizePolicy().hasHeightForWidth());
        frame->setSizePolicy(sizePolicy);
        frame->setFrameShape(QFrame::StyledPanel);
        frame->setFrameShadow(QFrame::Raised);
        horizontalLayout = new QHBoxLayout(frame);
        horizontalLayout->setSpacing(6);
        horizontalLayout->setContentsMargins(11, 11, 11, 11);
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        rxHistogramPainter = new histogramPainter(frame);
        rxHistogramPainter->setObjectName(QString::fromUtf8("rxHistogramPainter"));
        sizePolicy.setHeightForWidth(rxHistogramPainter->sizePolicy().hasHeightForWidth());
        rxHistogramPainter->setSizePolicy(sizePolicy);
        rxHistogramPainter->setMinimumSize(QSize(540, 0));
        rxHistogramPainter->setMaximumSize(QSize(512, 16777215));

        horizontalLayout->addWidget(rxHistogramPainter);


        gridLayout_4->addWidget(frame, 4, 1, 1, 4);


        gridLayout->addWidget(rxGroupBox, 2, 4, 2, 1);


        gridLayout_2->addLayout(gridLayout, 1, 1, 1, 1);

        MainWindow->setCentralWidget(centralWidget);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "White Rabbit Trigger Demo 2012", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("MainWindow", "Devices:", 0, QApplication::UnicodeUTF8));
        label_2->setText(QApplication::translate("MainWindow", "TX Cores:", 0, QApplication::UnicodeUTF8));
        txGroupBox->setTitle(QApplication::translate("MainWindow", "TX Core Details:", 0, QApplication::UnicodeUTF8));
        label_4->setText(QApplication::translate("MainWindow", "Trigger ID:", 0, QApplication::UnicodeUTF8));
        txReinitCoreButton->setText(QApplication::translate("MainWindow", "Reinitalize core", 0, QApplication::UnicodeUTF8));
        label_3->setText(QApplication::translate("MainWindow", "RX Cores:", 0, QApplication::UnicodeUTF8));
        rxGroupBox->setTitle(QApplication::translate("MainWindow", "RX Core Details:", 0, QApplication::UnicodeUTF8));
        label_5->setText(QApplication::translate("MainWindow", "Trigger ID:", 0, QApplication::UnicodeUTF8));
        label_7->setText(QApplication::translate("MainWindow", "Triggers executed:", 0, QApplication::UnicodeUTF8));
        label_6->setText(QApplication::translate("MainWindow", "Triggers received:", 0, QApplication::UnicodeUTF8));
        rxTriggersExec->setText(QApplication::translate("MainWindow", "0", 0, QApplication::UnicodeUTF8));
        rxTriggersRcvd->setText(QApplication::translate("MainWindow", "0", 0, QApplication::UnicodeUTF8));
        rxResetCountersButton->setText(QApplication::translate("MainWindow", "Reset Triggers", 0, QApplication::UnicodeUTF8));
        label_8->setText(QApplication::translate("MainWindow", "Output delay:", 0, QApplication::UnicodeUTF8));
        rxReinitCoreButton->setText(QApplication::translate("MainWindow", "Reinitialize Core", 0, QApplication::UnicodeUTF8));
        rxTriggerDelaySpinBox->setSuffix(QApplication::translate("MainWindow", " ns", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
