#ifndef URL_CONNECTION_H
#define URL_CONNECTION_H

#include <QObject>
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
#include <QDateTime>

#include "additional_structs.h"

class UrlConnection
{
    QString _urlAddress = "";

    public:
        UrlConnection();
        UrlConnection(QString address);
        void callGeneralWeather(QMap<QString, CoordsWeatherData> & generalWeatherMap);
        void callDailyWeather(CityCoords city, QMap<QString, DailyForecast> & fourDayForecast);
        void callGraphWeather(CityCoords city, QMap<QString, GraphData> & graphData);
        int readWeathercode(QString content);
        void readFourDayForecast(QString content, QMap<QString, DailyForecast> & fourDayForecast);
        void readGraphWeather(QString content, QMap<QString, GraphData> & graphData);

};

#endif // URL_CONNECTION_H
