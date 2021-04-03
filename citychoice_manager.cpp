#include "citychoice_manager.h"

CitychoiceManager::CitychoiceManager(QObject *parent) : QObject(parent)
{
    initCities("D:/qt_projects/meteoviz/available_cities.txt");
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

        QJsonObject addressObject;
        addressObject.insert("geostring", line);
        _citiesJson.insert(city, addressObject);
        //model->appendRow(fields);
    }

    file.close();
}


void CitychoiceManager::initCitiesCombobox()
{
    emit setCitiesCombobox(_availableCities);
}


Q_INVOKABLE void CitychoiceManager::onButtonClicked(QString str)
{
    qDebug() << "button: " << str;
    emit setTextField("COJEST");
}


Q_INVOKABLE void CitychoiceManager::onCityChosen(QString city)
{
    this->_cityName = city;
    double lat = 0.00;
    double lon = 0.00;
    if (_cityName != "None")
    {
        QJsonObject cityData = _citiesJson[_cityName].toObject();

        if( cityData.contains("latitude") )
        {
            lat = cityData["latitude"].toDouble();
            lon = cityData["longitude"].toDouble();
        }
        else
        {
            QString geostring = cityData["geostring"].toString();
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

            QJsonObject coordsObject;
            coordsObject.insert("latitude", lat);
            coordsObject.insert("longitude", lon);
            _citiesJson.insert(_cityName, coordsObject);

        }

    }
    emit sendPinPosition(lat, lon);

}
