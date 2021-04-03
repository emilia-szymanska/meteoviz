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
        QString _cityName = "";
        QList <QVariant> _availableCities;
        QMap <QString, CityDataGeo> _cities;
        QMap <QString, CityData> _generalCities;

    public:
        explicit CitychoiceManager(QObject *parent = nullptr);
        void initCities(QString fileName);
        void initGeneralCities(QString fileName);
        void initCitiesCombobox();
        void initMapItems();

    signals:
        void setCitiesCombobox(QVariant list);
        void sendPinPosition(QVariant latitude, QVariant longitude);
        void setMapItems(QVariant list);

    public slots:
        void onCityChosen(QString city);
};

#endif // CITYCHOICEMANAGER_H
