#include "weather_manager.h"

WeatherManager::WeatherManager(QObject *parent) : QObject(parent)
{

}


void WeatherManager::setCity(std::pair<QString, CityDataGeo> city)
{
    _cityName = city.first;
    _cityData = city.second;
}


//UrlConnection urlCon = UrlConnection("https://data.climacell.co/");
//urlCon.callGeneralWeather(_generalCities);
