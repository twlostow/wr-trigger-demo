#-------------------------------------------------
#
# Project created by QtCreator 2012-11-25T15:48:32
#
#-------------------------------------------------

QT       += core gui network

TARGET = WRT
TEMPLATE = app
LIBS = -L. -L../lib -letherbone -lfd
QMAKE_CFLAGS=-I../lib/ -I../lib/fdelay/include -I../include/hw -g
QMAKE_CXXFLAGS=-I../lib/ -I../lib/fdelay/include -I../include/hw -g

SOURCES += main.cpp\
        mainwindow.cpp \
        wrtebdevice.cpp \
	wrtttx.cpp \
	wrttts.cpp \
	wrttrx.cpp \
	datarefresherthread.cpp \
	histogrampainter.cpp

HEADERS  += mainwindow.h \
    wrtebdevice.h \
    wrtttx.h \
    wrttts.h \
    wrttrx.h \
    datarefresherthread.h \
    histogrampainter.h

FORMS    += mainwindow.ui
