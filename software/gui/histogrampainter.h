#ifndef HISTOGRAMPAINTER_H
#define HISTOGRAMPAINTER_H

#include <QWidget>
#include <wrttrx.h>

class histogramPainter : public QWidget
{
    Q_OBJECT
public:
    histogramPainter(QWidget* parent = NULL);
    ~histogramPainter() {}

    void setRxCore(wrttrx* dev);

    virtual void paintEvent(QPaintEvent *);

private:
    wrttrx* mRxDevice;
};

#endif // HISTOGRAMPAINTER_H
