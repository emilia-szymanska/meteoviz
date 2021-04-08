#ifndef CITYCHOICEMANAGER_H
#define CITYCHOICEMANAGER_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <QJsonObject>
#include <QtNetwork>
#include <QMessageBox>

#include <QGeoCodingManager>
#include <QApplication>
#include <QGeoAddress>
#include <QGeoCoordinate>
#include <QGeoLocation>
#include <QGeoServiceProvider>
#include <QtDebug>
#include <iostream>
#include <QMap>
#include "url_connection.h"

class CitychoiceManager : public QObject
{
    Q_OBJECT

    private:
        QPair<QString, CityCoords> _selectedCity;
        QList <QVariant> _availableCities;
        QMap <QString, CityCoords> _cities;
        QMap <QString, CoordsWeatherData> _generalCities;
        /*QPair<QString, CityData> _selectedCity;
        QString _cityName = "";
        QList <QVariant> _availableCities;
        QMap <QString, CityDataGeo> _cities;
        QMap <QString, CityData> _generalCities;
*/
    public:
        explicit CitychoiceManager(QObject *parent = nullptr);
        void initCities(QString fileName);
        void initGeneralCities(QString fileName);
        void initCitiesCombobox();
        void initMapItems();
        QPair<QString, CityCoords> selectedCity();

    signals:
        void setCitiesCombobox(QVariant list);
        void sendPinPosition(QVariant latitude, QVariant longitude);
        void setMapItems(QVariant list);

    public slots:
        void onCityChosen(QString city);
        void onCustomCoords(QString coords);
};

#endif // CITYCHOICEMANAGER_H
