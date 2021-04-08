#ifndef APPMANAGER_H
#define APPMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "citychoice_manager.h"
#include "weather_manager.h"
#include "url_connection.h"


class QQmlApplicationEngine;
class AppManager : public QObject
{
    Q_OBJECT

    private:
        QQmlApplicationEngine *_engine = nullptr;
        CitychoiceManager *_citychoiceMngr = nullptr;
        WeatherManager *_weatherMngr = nullptr;
        bool _main = true;
        QQuickWindow *_window  = nullptr;

    public:
        explicit AppManager(QQmlApplicationEngine *engine, CitychoiceManager *citychoiceMngr, WeatherManager *weatherMngr, QObject *parent = nullptr);
        Q_INVOKABLE void changeWindow();
        void initCitychoiceConnections(QObject *qObjectWindow);
        void initWeatherConnections(QObject *qObjectWindow);


};

#endif // APPMANAGER_H

