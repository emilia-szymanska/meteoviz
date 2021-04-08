#ifndef ADDITIONAL_STRUCTS_H
#define ADDITIONAL_STRUCTS_H
//#pragma once

#include <iostream>
#include <QString>

struct CoordsWeatherData
{
    double latitude  = 200.0;
    double longitude = 200.0;
    int weatherCode  = 0;
};

/*struct CityDataGeo
{
    double latitude  = 200.0;
    double longitude = 200.0;
    QString geostring = "";
};*/

struct CityCoords
{
    double latitude  = 200.0;
    double longitude = 200.0;
};


struct DailyForecast
{
    double temperature = 0;
    double pressure = 0;
    double windSpeed = 0;
    QString windDirection = "";
    double precipitation = 0;
    double humidity = 0;
    int weatherCode = 0;

};

/*std::ostream& operator << (std::ostream &strm, const GeneralCityData &data)
{
  strm << data.latitude << " " << data.longitude << " " << data.weatherCode << "\n";
  return strm;
}*/

#endif // ADDITIONAL_STRUCTS_H
