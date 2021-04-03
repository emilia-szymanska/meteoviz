#ifndef ADDITIONAL_STRUCTS_H
#define ADDITIONAL_STRUCTS_H
//#pragma once

#include <iostream>
#include <QString>

struct CityData
{
    double latitude  = 200.0;
    double longitude = 200.0;
    int weatherCode  = 0;
};

struct CityDataGeo
{
    double latitude  = 200.0;
    double longitude = 200.0;
    QString geostring = "";
};

/*std::ostream& operator << (std::ostream &strm, const GeneralCityData &data)
{
  strm << data.latitude << " " << data.longitude << " " << data.weatherCode << "\n";
  return strm;
}*/

#endif // ADDITIONAL_STRUCTS_H
