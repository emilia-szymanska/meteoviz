#include "weather_manager.h"

WeatherManager::WeatherManager(QObject *parent) : QObject(parent)
{

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

        QString coordsString = QString::number(lat) + latitudePart + "  " + QString::number(lon) + longitudePart;
        emit setCityLabel(coordsString);
    }
    //_cityName = city.first;
    //_cityData = city.second;
}


//UrlConnection urlCon = UrlConnection("https://data.climacell.co/");
//urlCon.callGeneralWeather(_generalCities);
