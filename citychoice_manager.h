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

class CitychoiceManager : public QObject
{
    Q_OBJECT

    private:
        QString _cityName = "";
        QList <QVariant> _availableCities;
        QJsonObject _citiesJson;

    public:
        explicit CitychoiceManager(QObject *parent = nullptr);
        void initCities(QString fileName);

    signals:
        void setTextField(QVariant text);
        void setCitiesCombobox(QList<QVariant> list);

    public slots:
        void onButtonClicked(QString str);
        void onCityChosen(QString city);
};

#endif // CITYCHOICEMANAGER_H
