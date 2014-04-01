/****************************************************************************
** Meta object code from reading C++ file 'mainwindow.h'
**
** Created: Fri Mar 15 00:58:13 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "mainwindow.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mainwindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MainWindow[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      12,   11,   11,   11, 0x0a,
      30,   26,   11,   11, 0x0a,
      46,   26,   11,   11, 0x0a,
      62,   11,   11,   11, 0x0a,
      74,   11,   11,   11, 0x0a,
      89,   86,   11,   11, 0x0a,
     111,   86,   11,   11, 0x0a,
     136,  133,   11,   11, 0x0a,
     162,  156,   11,   11, 0x0a,
     186,   11,   11,   11, 0x0a,
     207,  204,   11,   11, 0x0a,
     233,   11,   11,   11, 0x08,
     265,   11,   11,   11, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_MainWindow[] = {
    "MainWindow\0\0refreshView()\0row\0"
    "selectedTx(int)\0selectedRx(int)\0"
    "refreshRx()\0refreshTx()\0on\0"
    "toggleRxEnabled(bool)\0toggleTxEnabled(bool)\0"
    "id\0setTxTriggerId(int)\0value\0"
    "setRxTriggerId(QString)\0resetRxCounters()\0"
    "ns\0setRxTriggerDelay(double)\0"
    "on_txReinitCoreButton_clicked()\0"
    "on_rxReinitCoreButton_clicked()\0"
};

void MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        MainWindow *_t = static_cast<MainWindow *>(_o);
        switch (_id) {
        case 0: _t->refreshView(); break;
        case 1: _t->selectedTx((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: _t->selectedRx((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: _t->refreshRx(); break;
        case 4: _t->refreshTx(); break;
        case 5: _t->toggleRxEnabled((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 6: _t->toggleTxEnabled((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 7: _t->setTxTriggerId((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 8: _t->setRxTriggerId((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->resetRxCounters(); break;
        case 10: _t->setRxTriggerDelay((*reinterpret_cast< double(*)>(_a[1]))); break;
        case 11: _t->on_txReinitCoreButton_clicked(); break;
        case 12: _t->on_rxReinitCoreButton_clicked(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData MainWindow::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject MainWindow::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_MainWindow,
      qt_meta_data_MainWindow, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MainWindow::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MainWindow))
        return static_cast<void*>(const_cast< MainWindow*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 13)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
