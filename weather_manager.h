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
#include "url_connection.h"

class WeatherManager : public QObject
{
    Q_OBJECT

    private:
        //QString _cityName = "";
        //CityCoords _cityData;
        QPair<QString, CityCoords> _selectedCity;
        QMap<QString, DailyForecast> _fourDayWeather;
        QMap<QString, GraphData> _graphForecast;
        UrlConnection _urlCon;

    public:
        explicit WeatherManager(QObject *parent = nullptr);
        void setCity(QPair<QString, CityCoords> city);
        void callFourDayForecast();
        void sendFourDayForecast();
        void callGraphForecast();
        void sendGraphForecast();

    signals:
        void setCityLabel(QVariant cityName);
        void setFourDayForecast(QVariant list);
        void setGraphForecast(QVariant list);
};

#endif // WEATHERMANAGER_H






