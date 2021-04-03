#include "citychoice_manager.h"

CitychoiceManager::CitychoiceManager(QObject *parent) : QObject(parent)
{
    initCities("D:/qt_projects/meteoviz/available_cities.txt");
    initGeneralCities("D:/qt_projects/meteoviz/general_cities.txt");
    UrlConnection urlCon = UrlConnection("https://data.climacell.co/");
    urlCon.callGeneralWeather(_generalCities);
}


void CitychoiceManager::initCities(QString fileName)
{
    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        QMessageBox::information(0, "error", file.errorString());
    }

    _availableCities.append("None");

    QTextStream in(&file);
    while(!in.atEnd()) {
        QString line = in.readLine();
        QStringList fields = line.split(",");
        QString city = fields[2];
        _availableCities.append(city);

        _cities[city].geostring = line;
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
    while(!in.atEnd()) {
        QString line = in.readLine();
        QStringList fields = line.split(",");
        QString city = fields[0];
        double lat = fields[1].toDouble();
        double lon = fields[2].toDouble();

        CityData newCity;
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
    //QList<QVariant<QVariant> > list;
    QList<QVariant> list;
    foreach(const QString& key, _generalCities.keys()){
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

Q_INVOKABLE void CitychoiceManager::onCityChosen(QString city)
{
    this->_cityName = city;
    double lat = 0.00;
    double lon = 0.00;
    if (_cityName != "None")
    {
        CityDataGeo cityData = _cities[_cityName];
        if( cityData.latitude < 190.0)
        {
            lat = cityData.latitude;
            lon = cityData.longitude;
        }
        else
        {
            QString geostring = cityData.geostring;
            QStringList fields = geostring.split(",");

            QGeoServiceProvider qGeoService("osm");
            QGeoCodingManager *pQGeoCoder = qGeoService.geocodingManager();
            QGeoAddress qGeoAddr;

            qGeoAddr.setCountry(fields[0]);
            qGeoAddr.setPostalCode(fields[1]);
            qGeoAddr.setCity(fields[2]);
            qGeoAddr.setStreet(fields[3]);

            QGeoCodeReply *pQGeoCode = pQGeoCoder->geocode(qGeoAddr);
            if (!pQGeoCode) {
                std::cerr << "GeoCoding totally failed!" << std::endl;
            }

            QEventLoop event;
            connect(pQGeoCode,SIGNAL(finished()), &event, SLOT(quit()));
            event.exec();

            QList<QGeoLocation> qGeoLocs = pQGeoCode->locations();
            QGeoLocation qGeoLoc = qGeoLocs[0];
            qGeoLoc.setAddress(qGeoAddr);
            QGeoCoordinate qGeoCoord = qGeoLoc.coordinate();

            lon = qGeoCoord.longitude();
            lat = qGeoCoord.latitude();

            _cities[_cityName].latitude = lat;
            _cities[_cityName].longitude = lon;

        }

    }
    emit sendPinPosition(lat, lon);

}
