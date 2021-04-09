#include "weather_manager.h"

WeatherManager::WeatherManager(QObject *parent) : QObject(parent)
{
    _urlCon = UrlConnection("https://data.climacell.co/");
    //urlCon.callGeneralWeather(_generalCities);
}



void WeatherManager::setCity(QPair<QString, CityCoords> city)
{
    _selectedCity = city;
    if(_selectedCity.first != "Custom")
    {
        emit setCityLabel(_selectedCity.first);
    }
    else
    {
        QString latitudePart;
        QString longitudePart;
        float lat = _selectedCity.second.latitude;
        float lon = _selectedCity.second.longitude;
        if (lat > 0.00) latitudePart = "N";
        else latitudePart = "S";
        if (lon > 0.00) longitudePart = "E";
        else longitudePart = "W";

        QString coordsString = QString::number(lat) + "\u00B0" + latitudePart + "  " + QString::number(lon) + "\u00B0" + longitudePart;
        emit setCityLabel(coordsString);
    }
    //_cityName = city.first;
    //_cityData = city.second;
}


void WeatherManager::callFourDayForecast()
{
    //QMap<QString, DailyForecast> fourDayForecast;
    _urlCon.callDailyWeather(_selectedCity.second, _fourDayWeather);
    sendFourDayForecast();
}

void WeatherManager::sendFourDayForecast()
{
    QList<QVariant> list;
    foreach(const QString& key, _fourDayWeather.keys()){
        QVariant temperature = _fourDayWeather[key].temperature;
        QVariant pressure  = _fourDayWeather[key].pressure;
        QVariant windSpeed = _fourDayWeather[key].windSpeed;
        QVariant windDirection = _fourDayWeather[key].windDirection;
        QVariant precitipation = _fourDayWeather[key].precipitation;
        QVariant humidity = _fourDayWeather[key].humidity;
        QVariant weatherCode = _fourDayWeather[key].weatherCode;
        QList <QVariant> tempList;
        tempList.append(temperature);
        tempList.append(pressure);
        tempList.append(windSpeed);
        tempList.append(windDirection);
        tempList.append(precitipation);
        tempList.append(humidity);
        tempList.append(weatherCode);
        list.append(tempList);
    }

    emit setFourDayForecast(list);
}


void WeatherManager::callGraphForecast()
{
    _urlCon.callGraphWeather(_selectedCity.second, _graphForecast);
}


void WeatherManager::sendGraphForecast()
{
    QList<QVariant> listTemp;
    QList<QVariant> listPrec;
    /*QVector<double> temperature = _graphForecast["temperature"].data;
    QVector<double> precitipation = _graphForecast["precitipation"].data;



    for(int i = 0; i < temperature.size(); i++){
        listTemp.append(temperature[i]);
        listPrec.append(precitipation[i]);
    }*/

    double f = (double)rand() / RAND_MAX;

    double x[] = {f, 6.03, 5.22, 4.72, 4.52, 4.23, 3.85, 3.47};
    double y[] = {0.0, 1.0, f, 0.0, 3.0, 0.0, 0.0, 0.0};
    for(int i = 0; i < 8; i++){
        listTemp.append(x[i]);
        listPrec.append(y[i]);
    }

    emit setGraphForecast(listTemp, listPrec);
    //qDebug() << list;
    //emit setGraphTempForecast(listTemp);
    //emit setGraphPrecForecast(listPrec);
}


void WeatherManager::refreshRequest()
{
    //callFourDayForecast();
    //callGraphForecast();
    sendGraphForecast();
}
