#include "app_manager.h"
///////////////////////////
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
///

AppManager::AppManager(QQmlApplicationEngine *engine, CitychoiceManager *citychoiceMngr, /*ButtonManager *btnMngr,*/ QObject *parent) : QObject(parent)
{
    _engine = engine;
    _citychoiceMngr = citychoiceMngr;
    _engine->load(QUrl(QStringLiteral("qrc:/citychoice.qml")));
    Q_ASSERT( !_engine->rootObjects().isEmpty() );

    QObject *topQObjectWindow = _engine->rootObjects().value(0);
    this->initCitychoiceConnections(topQObjectWindow);
}


void AppManager::changeWindow()
{
    QObject *qObjectCurrentWindow = _engine->rootObjects().value(0);
    Q_ASSERT( qObjectCurrentWindow != NULL );

    QQuickWindow* mainWindow = qobject_cast<QQuickWindow*>(qObjectCurrentWindow);
    Q_ASSERT( mainWindow );

    _main = !_main;
    if (_main)
    {
        _engine->load(QUrl(QStringLiteral("qrc:/citychoice.qml")));
        QObject *qObjectWindow = _engine->rootObjects().value(1);
        this->initCitychoiceConnections(qObjectWindow);

    } else
    {
        _engine->load(QUrl(QStringLiteral("qrc:/weather.qml")));





        ///////////////////
        /*QFile file("D:/qt_projects/meteoviz/apikey.txt");
        if(!file.open(QIODevice::ReadOnly)) {
            QMessageBox::information(0, "error", file.errorString());
        }

        QTextStream in(&file);
        QString apikey = in.readLine();
        //while(!in.atEnd()) {
        //    QString line = in.readLine();
            //QStringList fields = line.split(",");
            //model->appendRow(fields);
        //}

        file.close();


        QString url = "https://data.climacell.co/v4/timelines?location=-73.98529171943665,40.75872069597532&fields=temperature&timesteps=1d&units=metric&apikey=" + apikey;
        QNetworkAccessManager manager;
        QNetworkReply *response = manager.get(QNetworkRequest(QUrl(url)));
        QEventLoop event;
        connect(response, SIGNAL(finished()), &event, SLOT(quit()));
        event.exec();
        QString content = response->readAll();
        QJsonDocument doc = QJsonDocument::fromJson(content.toUtf8());
        QJsonObject jsonObject = doc.object();
        //QJsonArray jsonArray = jsonObject["properties"].toArray();
        qDebug() << "*******************";
        qDebug() << jsonObject["data"].toString();
        QJsonObject data = jsonObject["data"].toObject();
        QJsonArray x = data["timelines"].toArray();
        qDebug() << "-----------";
        qDebug() << x;
        QJsonObject ar1 = x.at(0).toObject();
        qDebug() << "===================";
        qDebug() << "" << ar1["endTime"].toString();*/


    }
    mainWindow->close();
    qObjectCurrentWindow->deleteLater();
}


void AppManager::initCitychoiceConnections(QObject *qObjectWindow)
{
    this->_window = qobject_cast<QQuickWindow *>(qObjectWindow);

    // connect QML signals to C++ slots
    QObject::connect(this->_window, SIGNAL(clickedButton(QString)),
                             this->_citychoiceMngr, SLOT(onButtonClicked(QString)));
    QObject::connect(this->_window, SIGNAL(chosenCity(QString)),
                             this->_citychoiceMngr, SLOT(onCityChosen(QString)));

    // connect C++ signals to QML slots
    QObject::connect(this->_citychoiceMngr, SIGNAL(setTextField(QVariant)),
                             this->_window, SLOT(setTextField(QVariant)));
    QObject::connect(this->_citychoiceMngr, SIGNAL(sendPinPosition(QVariant, QVariant)),
                             this->_window, SLOT(addMarker(QVariant, QVariant)));

    //QObject::connect(this->_citychoiceMngr, SIGNAL(setCitiesCombobox(QList<QVariant>)),
    //                         this->_window, SLOT(setCitiesList(QVariant)));
    /////////////////////////////////////////////////
   /* QGeoServiceProvider qGeoService("osm");
    QGeoCodingManager *pQGeoCoder = qGeoService.geocodingManager();
    QGeoAddress qGeoAddr;
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
}

