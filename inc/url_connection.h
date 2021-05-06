#ifndef URL_CONNECTION_H
#define URL_CONNECTION_H

#include <QObject>
#include <QtNetwork>
#include <QDateTime>
#include <QtDebug>
#include <QMessageBox>
#include "additional_structs.h"


/*! Class responsible for managing the requests for weather API
 */
class UrlConnection
{
    QString _urlAddress = "";       /**< address for URL requests */
    QString _apiKeyFilepath = "";   /**< path to the file with API key */

    public:
        /*!
         * @brief Non-parameter constructor
         */
        UrlConnection();
        /*!
         * @brief Constructor with parameters
         * @param[in] address The URL address
         * @param[in] keyFilePath The path to the file with API key
         */
        UrlConnection(QString address, QString keyFilePath);
        /*!
         * @brief Method retrieving the API key from the file
         */
        QString getApiKey();
        /*!
         * @brief Converting a string to JSON Array
         * @param[in] content String with JSON-styled data
         * @return JSON Array with weather data intervals
         */
        QJsonArray fromStringToIntervals(QString content);
        /*!
         * @brief Calling a request on general weather for chosen cities displayed on the MAP
         * @param[in] generalWeatherMap A reference to the map of pairs city_name-coordinates_with_weathercode
         */
        void callGeneralWeather(QMap<QString, CoordsWeatherData> & generalWeatherMap);
        /*!
         * @brief Calling a request on daily weather for the current day and three subsequent days
         * @param[in] city Coordinates of the selected city
         * @param[in] fourDayForecast A reference to the map with four pairs day-weather_data
         */
        void callDailyWeather(CityCoords city, QMap<QString, DailyForecast> & fourDayForecast);
        /*!
         * @brief Calling a request on today's weather for a couple of hours in the future (for graphs)
         * @param[in] city Coordinates of the selected city
         * @param[in] graphData A reference to the map with four pairs day-graph_data
         */
        void callGraphWeather(CityCoords city, QMap<QString, GraphData> & graphData);
        /*!
         * @brief Converting JSON-styled data to weather code
         * @param[in] content String with JSON-styled data
         * @return Returns the weather code
         */
        int readWeathercode(QString content);
        /*!
         * @brief Converting JSON-styled data to weather data
         * @param[in] content String with JSON-styled data
         * @param[in] fourDayForecast A reference to the map with four pairs day-weather_data to which
         *            the data from JSON should be written
         */
        void readFourDayForecast(QString content, QMap<QString, DailyForecast> & fourDayForecast);
        /*!
         * @brief Converting JSON-styled data to graph data
         * @param[in] content String with JSON-styled data
         * @param[in] graphData A reference to the map with four pairs day-graph_data to which
         *            the data from JSON should be written
         */
        void readGraphWeather(QString content, QMap<QString, GraphData> & graphData);
};

#endif // URL_CONNECTION_H
