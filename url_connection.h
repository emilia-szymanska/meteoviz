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

class UrlConnection
{
    QString _urlAddress = "";

    public:
        UrlConnection();
        UrlConnection(QString address);
        void callGeneralWeather(QJsonObject generalWeatherList);
};

#endif // URL_CONNECTION_H
