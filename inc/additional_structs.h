#ifndef ADDITIONAL_STRUCTS_H
#define ADDITIONAL_STRUCTS_H

#include <QString>
#include <QVector>

/*! Struct for keeping the geocoordinations and the weather associated
 *  with them
 */
struct CoordsWeatherData
{
    double latitude  = 200.0; /**< geograhic latitude */
    double longitude = 200.0; /**< geograhic longitude */
    int weatherCode  = 0;     /**< code for the weather type */
};

/*! Struct for keeping the geocoordinations of a city
 */
struct CityCoords
{
    double latitude  = 200.0; /**< geograhic latitude */
    double longitude = 200.0; /**< geograhic longitude */
};

/*! Struct for keeping the weather data
 */
struct DailyForecast
{
    int temperature = 0;        /**< temperature in C */
    int pressure = 0;           /**< atmospheric pressure in hPa */
    int windSpeed = 0;          /**< wind speed in m/s */
    QString windDirection = ""; /**< wind direction e.g. NE, SE etc. */
    int precipitation = 0;      /**< amount of rain in mm/h */
    int humidity = 0;           /**< humidity in % */
    int weatherCode = 0;        /**< code for the weather type */

};


/*! Struct for keeping the data later plotted on graphs
 */
struct GraphData
{
    QVector<double> data;       /**< data for graphs */
};

#endif // ADDITIONAL_STRUCTS_H
