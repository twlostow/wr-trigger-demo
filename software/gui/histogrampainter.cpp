#include "histogrampainter.h"
#include <QPainter>
#include <QFont>
#include <QDebug>
#include <qglobal.h>
#include <math.h>

histogramPainter::histogramPainter(QWidget* parent):
    QWidget(parent), mRxDevice(NULL)

{
}

void histogramPainter::setRxCore(wrttrx* dev)
{
    mRxDevice = dev;
}

void histogramPainter::paintEvent(QPaintEvent *)
{
    QPainter p(this);
    QRect wholeGraph(this->rect());

    if (mRxDevice == NULL)
    {
        p.setFont(QFont("Arial", 30));
        p.drawText(wholeGraph, "No core selected");
        return;
    }

    p.eraseRect(wholeGraph);

    int max = 0;
    int binMax = 0;

    eb_data_t* d = mRxDevice->delayHistogramBuffer;

    for (int i = 0; i < TRX_DHB_RAM_WORDS; i++)
    {
        if (*d > max)
        {
            max = *d;
            binMax = i;
        }
        d++;
    }

    qDebug() << "Histogram max: " << max;
    qDebug() << "MaxBin: " << binMax;

    int maxHeight = wholeGraph.height() - 30;       //leave 30 pixels for texts

    qDebug() << "MaxH: " << maxHeight;

    d = mRxDevice->delayHistogramBuffer;
    QVector<QRect> bars;



    for (int i = 0; i < TRX_DHB_RAM_WORDS; i++)
    {
        uint32_t h = lrint((((double)*d++) / (double)max) * maxHeight);
        //QRect(i,0,i,h);

        bars.append(QRect(i, 0, 1, h));
        //qDebug() << h;
    }

    p.setPen(QColor::fromRgb(0,0,0));
    QString lowerTimeScale = "0 us";
    p.drawText(QPoint(28, maxHeight + 20), lowerTimeScale);
    QString midTimeScale =  QString("%1 us").arg(wrttrx::mHistogramMaxTimeInNs/2000, 0, 'f', 2);
    p.drawText(QPoint(28 + 256 - 50, maxHeight + 20), midTimeScale);
    QString upperTimeScale = QString("%1 us").arg(wrttrx::mHistogramMaxTimeInNs/1000, 0, 'f', 2);
    p.drawText(QPoint(28 + 512 - 50, maxHeight + 20), upperTimeScale);

    p.drawText(QPoint(-20,20), QString::number(max));

    p.resetTransform();
    p.translate(540 - 512, maxHeight);
    p.scale(1, -1);


    //lines arount the graph
    p.setPen(QColor::fromRgb(0,0, 255));
    p.drawLine(-1, 0, -1, maxHeight);
    p.drawLine(-1, -1, 512,-1);

    //rectangles
    p.setPen(QColor::fromRgb(255,0,0));
    p.drawRects(bars);

}
