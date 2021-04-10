#ifndef WEATHERMANAGER_H
#define WEATHERMANAGER_H

#include <QObject>
#include <QVariant>
#include <QMap>
#include "additional_structs.h"
#include "url_connection.h"

class WeatherManager : public QObject
{
    Q_OBJECT

    private:
        QPair<QString, CityCoords> _selectedCity;
        QMap<QString, DailyForecast> _fourDayWeather;
        QMap<QString, GraphData> _graphForecast;
        UrlConnection _urlCon;

    public:
        explicit WeatherManager(UrlConnection urlCon, QObject *parent = nullptr);
        void sendCity(QPair<QString, CityCoords> city);
        void callFourDayForecast();
        void sendFourDayForecast();
        void callGraphForecast();
        void sendGraphForecast();

    signals:
        void setCityLabel(QVariant cityName);
        void setFourDayForecast(QVariant list);
        void setGraphForecast(QVariant listTemp, QVariant listPrec);

    public slots:
        void refreshRequest();
};

#endif // WEATHERMANAGER_H






