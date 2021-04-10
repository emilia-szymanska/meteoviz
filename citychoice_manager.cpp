#include "citychoice_manager.h"

CitychoiceManager::CitychoiceManager(QString allCitiesFilepath, QString generalCitiesFilepath, UrlConnection urlCon, QObject *parent) : QObject(parent)
{
    initCities(allCitiesFilepath);
    initGeneralCities(generalCitiesFilepath);
    _urlCon = urlCon;
    _urlCon.callGeneralWeather(_generalCities);
}


void CitychoiceManager::initCities(QString fileName)
{
    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        QMessageBox::information(0, "error", file.errorString());
    }

    _availableCities.append("None");
    _availableCities.append("Custom");

    QTextStream in(&file);
    in.setCodec("UTF-8");
    while(!in.atEnd())
    {
        QString line = in.readLine();
        QStringList fields = line.split(" ");
        QString city = fields[0];
        city.replace("_", " ");

        _availableCities.append(city);

        _cities[city].latitude = fields[2].toDouble();
        _cities[city].longitude = fields[1].toDouble();
    }

    file.close();
}


void CitychoiceManager::initGeneralCities(QString fileName)
{
    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        QMessageBox::information(0, "error", file.errorString());
    }

    QTextStream in(&file);
    while(!in.atEnd())
    {
        QString line = in.readLine();
        QStringList fields = line.split(",");
        QString city = fields[0];
        double lat = fields[1].toDouble();
        double lon = fields[2].toDouble();

        CoordsWeatherData newCity;
        newCity.latitude = lat;
        newCity.longitude = lon;
        newCity.weatherCode = 0;
        _generalCities[city] = newCity;
    }

    file.close();
}


void CitychoiceManager::initCitiesCombobox()
{
    emit setCitiesCombobox(_availableCities);
}


void CitychoiceManager::initMapItems()
{
    QList<QVariant> list;
    foreach(const QString& key, _generalCities.keys())
    {
        QVariant lat  = _generalCities[key].latitude;
        QVariant lon  = _generalCities[key].longitude;
        QVariant code = _generalCities[key].weatherCode;
        QList <QVariant> tempList;
        tempList.append(lat);
        tempList.append(lon);
        tempList.append(code);
        list.append(tempList);
    }
    emit setMapItems(list);
}


QPair<QString, CityCoords> CitychoiceManager::selectedCity()
{
    return _selectedCity;
}


Q_INVOKABLE void CitychoiceManager::onCityChosen(QString city)
{
    this->_selectedCity.first = city;
    double lat = 0.00;
    double lon = 0.00;
    if (city != "None" && city != "Custom")
    {
        CityCoords cityData = _cities[city];
        if( cityData.latitude < 190.0)
        {
            lat = cityData.latitude;
            lon = cityData.longitude;
            this->_selectedCity.second.latitude = lat;
            this->_selectedCity.second.longitude = lon;
        }
        emit sendPinPosition(lat, lon);
    }
}


Q_INVOKABLE void CitychoiceManager::onCustomCoords(QString coords)
{
    QStringList fields = coords.split(",");
    _selectedCity.second.latitude = fields[0].toDouble();
    _selectedCity.second.longitude = fields[1].toDouble();
}

