#ifndef ADDITIONAL_STRUCTS_H
#define ADDITIONAL_STRUCTS_H
//#pragma once

#include <iostream>
#include <QString>
#include <QVector>

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
    int temperature = 0;
    int pressure = 0;
    int windSpeed = 0;
    QString windDirection = "";
    int precipitation = 0;
    int humidity = 0;
    int weatherCode = 0;

};

struct GraphData
{
    QVector<double> data;
};

/*std::ostream& operator << (std::ostream &strm, const GeneralCityData &data)
{
  strm << data.latitude << " " << data.longitude << " " << data.weatherCode << "\n";
  return strm;
}*/

#endif // ADDITIONAL_STRUCTS_H
