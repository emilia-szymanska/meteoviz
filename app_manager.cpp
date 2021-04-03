#include "app_manager.h"
///////////////////////////
#include <QtNetwork>
#include <QMessageBox>
#include <QGeoCodingManager>
#include <QApplication>
#include <QGeoAddress>
#include <QGeoCoordinate>
#include <QGeoLocation>
#include <QGeoServiceProvider>
#include <QtDebug>
#include <iostream>
///

AppManager::AppManager(QQmlApplicationEngine *engine, CitychoiceManager *citychoiceMngr, QObject *parent) : QObject(parent)
{
    _engine = engine;
    _citychoiceMngr = citychoiceMngr;
    _engine->load(QUrl(QStringLiteral("qrc:/citychoice.qml")));
    Q_ASSERT( !_engine->rootObjects().isEmpty() );

    QObject *topQObjectWindow = _engine->rootObjects().value(0);
    this->initCitychoiceConnections(topQObjectWindow);
    this->_citychoiceMngr->initCitiesCombobox();
    //this->_citychoiceMngr->initGeneralCities(QString fileName);

}


void AppManager::changeWindow()
{
    QObject *qObjectCurrentWindow = _engine->rootObjects().value(0);
    Q_ASSERT( qObjectCurrentWindow != NULL );

    QQuickWindow* mainWindow = qobject_cast<QQuickWindow*>(qObjectCurrentWindow);
    Q_ASSERT( mainWindow );

    _main = !_main;
    if (_main){
        _engine->load(QUrl(QStringLiteral("qrc:/citychoice.qml")));
        QObject *qObjectWindow = _engine->rootObjects().value(1);
        this->initCitychoiceConnections(qObjectWindow);
        this->_citychoiceMngr->initCitiesCombobox();
    }
    else{
        _engine->load(QUrl(QStringLiteral("qrc:/weather.qml")));
    }

    mainWindow->close();
    qObjectCurrentWindow->deleteLater();
}


void AppManager::initCitychoiceConnections(QObject *qObjectWindow)
{
    this->_window = qobject_cast<QQuickWindow *>(qObjectWindow);

    // connect QML signals to C++ slots
    //QObject::connect(this->_window, SIGNAL(clickedButton(QString)),
    //                         this->_citychoiceMngr, SLOT(onButtonClicked(QString)));
    QObject::connect(this->_window, SIGNAL(chosenCity(QString)),
                             this->_citychoiceMngr, SLOT(onCityChosen(QString)));

    // connect C++ signals to QML slots
    //QObject::connect(this->_citychoiceMngr, SIGNAL(setTextField(QVariant)),
    //                         this->_window, SLOT(setTextField(QVariant)));
    QObject::connect(this->_citychoiceMngr, SIGNAL(sendPinPosition(QVariant,QVariant)),
                             this->_window, SLOT(addMarker(QVariant,QVariant)));

    QObject::connect(this->_citychoiceMngr, SIGNAL(setCitiesCombobox(QVariant)),
                            this->_window, SLOT(setCitiesList(QVariant)));


}

