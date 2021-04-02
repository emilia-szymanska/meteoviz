#include "citychoice_manager.h"

CitychoiceManager::CitychoiceManager(QObject *parent) : QObject(parent)
{
    initCities("D:/qt_projects/meteoviz/available_cities.txt");
}

void CitychoiceManager::initCities(QString fileName)
{
    //QGeoServiceProvider qGeoService("osm");
    //QGeoCodingManager *pQGeoCoder = qGeoService.geocodingManager();

    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        QMessageBox::information(0, "error", file.errorString());
    }

    QTextStream in(&file);
    while(!in.atEnd()) {
        QString line = in.readLine();
        QStringList fields = line.split(",");
        QString city = fields[2];
        _availableCities.append(city);

        QJsonObject addressObject;
        addressObject.insert("geostring", line);
        _citiesJson.insert(city, addressObject);
        qDebug() << _citiesJson;
        //QJsonArray recordsArray;
        //recordsArray.push_back(recordObject);
        //QJsonDocument doc(recordsArray);
        //qDebug() << doc.toJson();




        //model->appendRow(fields);
    }



    /*QGeoAddress qGeoAddr;
    qGeoAddr.setCountry(QString::fromUtf8("Poland"));
    qGeoAddr.setPostalCode(QString::fromUtf8("10-818"));
    qGeoAddr.setCity(QString::fromUtf8("Olsztyn"));
    qGeoAddr.setStreet(QString::fromUtf8("Klosowa 137"));
    QGeoCodeReply *pQGeoCode = pQGeoCoder->geocode(qGeoAddr);
        if (!pQGeoCode) {
          std::cerr << "GeoCoding totally failed!" << std::endl;

        }
    QEventLoop event;
    connect(pQGeoCode,SIGNAL(finished()), &event, SLOT(quit()));
    event.exec();
    QList<QGeoLocation> qGeoLocs = pQGeoCode->locations();
    std::cout << qGeoLocs.size() << " location(s) returned." << std::endl;
    for (QGeoLocation &qGeoLoc : qGeoLocs) {
                     qGeoLoc.setAddress(qGeoAddr);
                     QGeoCoordinate qGeoCoord = qGeoLoc.coordinate();
                     std::cout
                       << "Lat.:  " << qGeoCoord.latitude() << std::endl
                       << "Long.: " << qGeoCoord.longitude() << std::endl
                       << "Alt.:  " << qGeoCoord.altitude() << std::endl;
                   }*/


    file.close();
}


Q_INVOKABLE void CitychoiceManager::onButtonClicked(QString str)
{
    qDebug() << "button: " << str;
    emit setTextField("COJEST");
    emit setCitiesCombobox(_availableCities);
}


Q_INVOKABLE void CitychoiceManager::onCityChosen(QString city)
{
    this->_cityName = city;
    double lat = 0.00;
    double lon = 0.00;
    if (_cityName != "None" && _cityName != "Wroclaw")
    {
        QJsonObject cityData = _citiesJson[_cityName].toObject();

        if( cityData.contains("latitude") )
        {
            qDebug() << cityData;
            lat = cityData["latitude"].toDouble();
            lon = cityData["longitude"].toDouble();
            //qDebug()  << lat1;
            //qDebug()  << lon2;
            //lat = lat1.toFloat();
            //lon = lon2.toFloat();
            //qDebug() << cityData["latitude"];
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
            for (QGeoLocation &qGeoLoc : qGeoLocs) {
                qGeoLoc.setAddress(qGeoAddr);
                QGeoCoordinate qGeoCoord = qGeoLoc.coordinate();
                lon = qGeoCoord.longitude();
                lat = qGeoCoord.latitude();
                std::cout << lon << std::endl;
                std::cout << lat << std::endl;
                QJsonObject coordsObject;
                coordsObject.insert("latitude", /*QString::number(*/lat);
                coordsObject.insert("longitude", lon);
                _citiesJson.insert(_cityName, coordsObject);

            }
        }

    }
    qDebug() << "city: " << _cityName;
    qDebug() << "==============";
    qDebug() << lat;
    qDebug() << lon;
}
