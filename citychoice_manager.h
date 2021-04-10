#ifndef CITYCHOICEMANAGER_H
#define CITYCHOICEMANAGER_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <QMessageBox>
#include <QMap>
#include "url_connection.h"


class CitychoiceManager : public QObject
{
    Q_OBJECT

    private:
        UrlConnection _urlCon;
        QPair<QString, CityCoords> _selectedCity;
        QList <QVariant> _availableCities;
        QMap <QString, CityCoords> _cities;
        QMap <QString, CoordsWeatherData> _generalCities;

    public:
        explicit CitychoiceManager(QString allCitiesFilepath, QString generalCitiesFilepath,
                                   UrlConnection urlCon, QObject *parent = nullptr);
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
