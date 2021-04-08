#ifndef WEATHERMANAGER_H
#define WEATHERMANAGER_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <QJsonObject>
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
#include <QMap>
#include "additional_structs.h"

class WeatherManager : public QObject
{
    Q_OBJECT

    private:
        //QString _cityName = "";
        //CityCoords _cityData;
        QPair<QString, CityCoords> _selectedCity;
        QMap<QString, DailyForecast> _fourDayWeather;

    public:
        explicit WeatherManager(QObject *parent = nullptr);
        void setCity(QPair<QString, CityCoords> city);

    signals:
        void setCityLabel(QVariant cityName);
};

#endif // WEATHERMANAGER_H






