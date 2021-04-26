#ifndef CITYCHOICEMANAGER_H
#define CITYCHOICEMANAGER_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <QMessageBox>
#include <QMap>
#include "url_connection.h"

/*! Class responsible for managing the first window (the one enabling
 *  the choice of the city)
 */
class CitychoiceManager : public QObject
{
    Q_OBJECT

    private:
        UrlConnection _urlCon;                              /**< object enabling URL connection to the weather API */
        QPair<QString, CityCoords> _selectedCity;           /**< pair of the selected city name and its geocoordinates */
        QList <QVariant> _availableCities;                  /**< list of the names of all available cities */
        QMap <QString, CityCoords> _cities;                 /**< map of pairs city_name-geocoords of all available cities */
        QMap <QString, CoordsWeatherData> _generalCities;   /**< map of pairs city_name-geocoords_with_weather of chosen cities
                                                                 for which the weather on the MAP is displayed */

    public:
        /*!
         * @brief Public constructor
         * @param[in] allCitiesFilepath String being the path to the file with all cities (names and coordinates)
         * @param[in] generalCitiesFilepath String being the path to the file with chosen cities (names and coordinates)
         *            for general weather displayed on the MAP
         * @param[in] urlCon Object with set connection to weather API
         * @param[in] parent Pointer to the QObject parent
         */
        explicit CitychoiceManager(QString allCitiesFilepath, QString generalCitiesFilepath,
                                   UrlConnection urlCon, QObject *parent = nullptr);
        /*!
         * @brief Initialization of all cities - converting the data from file to the class members
         * @param[in] fileName String being the path to the file with all cities (names and coordinates)
         */
        void initCities(QString fileName);
        /*!
         * @brief Initialization of chosen cities with weather displayed on the MAP -
         *         - converting the data from file to the class members
         * @param[in] fileName String being the path to the file with the cities (names and coordinates)
         */
        void initGeneralCities(QString fileName);
        /*!
         * @brief Initialization of the combobox with all cities in frontend part
         */
        void initCitiesCombobox();
        /*!
         * @brief Initialization of the map items (weather icons) with general weather
         */
        void initMapItems();
        /*!
         * @brief Getting the information on the selected city
         * @return pair of the selected city name and its geocoordinates
         */
        QPair<QString, CityCoords> selectedCity();

    signals:
        /*!
         * @brief Signal sending the list of all city names
         * @param[in] list List of all available cities
         */
        void setCitiesCombobox(QVariant list);
        /*!
         * @brief Signal sending coordinates of the pin of the selected city
         * @param[in] latitude Geographical city latitude
         * @param[in] longitude Geographical city longitidue
         */
        void sendPinPosition(QVariant latitude, QVariant longitude);
        /*!
         * @brief Signal sending the list with geocoordinates and associated weather
         *        code of chosen cities for displaying general icons on the map
         * @param[in] list List of [latitude, longitude, weatherCode] for chosen cities
         */
        void setMapItems(QVariant list);

    public slots:
        /*!
         * @brief Slot reacting to the selection of the city (sends its coordinates)
         * @param[in] city Selected city
         */
        void onCityChosen(QString city);
        /*!
         * @brief Slot saving the coordinates of a custom selection of a place on the map
         * @param[in] coords String with both coordinates separated with ','
         */
        void onCustomCoords(QString coords);
};

#endif // CITYCHOICEMANAGER_H
