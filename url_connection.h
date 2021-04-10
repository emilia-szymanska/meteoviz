#ifndef URL_CONNECTION_H
#define URL_CONNECTION_H

#include <QObject>
#include <QtNetwork>
#include <QDateTime>
#include <QtDebug>
#include <QMessageBox>
#include "additional_structs.h"

class UrlConnection
{
    QString _urlAddress = "";
    QString _apiKeyFilepath = "";

    public:
        UrlConnection();
        UrlConnection(QString address, QString keyFilePath);
        QString getApiKey();
        QJsonArray fromStringToIntervals(QString content);
        void callGeneralWeather(QMap<QString, CoordsWeatherData> & generalWeatherMap);
        void callDailyWeather(CityCoords city, QMap<QString, DailyForecast> & fourDayForecast);
        void callGraphWeather(CityCoords city, QMap<QString, GraphData> & graphData);
        int readWeathercode(QString content);
        void readFourDayForecast(QString content, QMap<QString, DailyForecast> & fourDayForecast);
        void readGraphWeather(QString content, QMap<QString, GraphData> & graphData);
};

#endif // URL_CONNECTION_H
