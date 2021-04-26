#ifndef WEATHERMANAGER_H
#define WEATHERMANAGER_H

#include <QObject>
#include <QVariant>
#include <QMap>
#include "additional_structs.h"
#include "url_connection.h"


/*! Class responsible for managing the second window (the one displaying
 *  the weather and forecast)
 */
class WeatherManager : public QObject
{
    Q_OBJECT

    private:
        QPair<QString, CityCoords> _selectedCity;       /**< pair of the selected city name and its geocoordinates */
        QMap<QString, DailyForecast> _fourDayWeather;   /**< map of pairs city_name-weather_data of the selected city
                                                             for the current day and three future days */
        QMap<QString, GraphData> _graphForecast;        /**< map of pairs city_name-graph_data of the selected city
                                                             for closest hours */
        UrlConnection _urlCon;                          /**< object enabling URL connection to the weather API */


    public:
        /*!
         * @brief Public constructor
         * @param[in] urlCon Object with set connection to weather API
         * @param[in] parent Pointer to the QObject parent
         */
        explicit WeatherManager(UrlConnection urlCon, QObject *parent = nullptr);
        /*!
         * @brief Sending the string of city name or the coordinates to QML frontend
         * @param[in] city Pair of city_name-geocoordinates to be converted to the label
         *                  (in case a custom location is chosen, the label will contain the coordinates)
         */
        void sendCity(QPair<QString, CityCoords> city);
        /*!
         * @brief Evoking the URL request for four day forecast (today + 3) and saving the data to a class field
         */
        void callFourDayForecast();
        /*!
         * @brief Converting the four day forecast data to QVariant and emitting a signal to QML
         */
        void sendFourDayForecast();
        /*!
         * @brief Evoking the URL request for hourly graph data and saving it to a class field
         */
        void callGraphForecast();
        /*!
         * @brief Converting the graph forecast data to QVariants and emitting a signal to QML
         */
        void sendGraphForecast();

    signals:
        /*!
         * @brief Signal sending the city label to display in the second window
         * @param[in] cityName The name (or coordinates) of the selected city
         */
        void setCityLabel(QVariant cityName);
        /*!
         * @brief Signal sending the four day forecast data to the QML frontend
         * @param[in] list List with [temperature, pressure, windSpeed, windDirection,
         *              precitipation, humidity, weatherCode] data for each of the four days
         */
        void setFourDayForecast(QVariant list);
        /*!
         * @brief Signal sending the 8-hour temperature and precitipation
         *        forecast data to the QML frontend
         * @param[in] listTemp List with temperature forecast for 8 hours
         * @param[in] listPrec List with precitipation forecast for 8 hours
         */
        void setGraphForecast(QVariant listTemp, QVariant listPrec);

    public slots:
        /*!
         * @brief Slot for managing the refresh request
         */
        void refreshRequest();
};

#endif // WEATHERMANAGER_H






