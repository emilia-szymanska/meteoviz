#include "app_manager.h"
///////////////////////////
#include <QtNetwork>
#include <QMessageBox>
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
        QFile file("D:/qt_projects/meteoviz/apikey.txt");
        if(!file.open(QIODevice::ReadOnly)) {
            QMessageBox::information(0, "error", file.errorString());
        }

        QTextStream in(&file);
        QString apikey = in.readLine();
        /*while(!in.atEnd()) {
            QString line = in.readLine();
            //QStringList fields = line.split(",");
            //model->appendRow(fields);
        }*/

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
        qDebug() << "" << ar1["endTime"].toString();
        /*QNetworkAccessManager *manager = new QNetworkAccessManager(this);

        manager->get(QNetworkRequest(QUrl("https://data.climacell.co/v4/timelines?location=-73.98529171943665,40.75872069597532&fields=temperature&timesteps=1h&units=metric&apikey=KzMgATyAMAz1lsuzz6d8gLDPQBca3ggZ")));
        QNetworkRequest request;
        request.setUrl(QUrl("http://qt-project.org"));
        //request.setRawHeader("User-Agent", "MyOwnBrowser 1.0");

        QNetworkReply *reply = manager->get(request);

        connect(reply, &QNetworkReply::finished, [=]() {

            if(reply->error() == QNetworkReply::NoError)
            {
                QByteArray response = reply->readAll();
                qDebug() << response;
                // do something with the data...
            }
        });*/
        /*QNetworkRequest request(QUrl("https://data.climacell.co/"));
        request.setHeader(QNetworkRequest::ContentTypeHeader, "v4/timelines?location=-73.98529171943665,40.75872069597532&fields=temperature&timesteps=1h&units=metric&apikey=KzMgATyAMAz1lsuzz6d8gLDPQBca3ggZ");
        QJsonObject json;
        QNetworkAccessManager nam;
        QNetworkReply *reply = nam.post(request, QJsonDocument(json).toJson());
        while (!reply->isFinished())
        {
            qApp->processEvents();
        }
        QByteArray response_data = reply->readAll();
        QJsonDocument json2 = QJsonDocument::fromJson(response_data);
        qDebug() << json;
        qDebug() << json2;
        reply->deleteLater();*/
        ///////////////////

    }

    mainWindow->close();
    qObjectCurrentWindow->deleteLater();
}


void AppManager::initCitychoiceConnections(QObject *qObjectWindow)
{
    this->_window = qobject_cast<QQuickWindow *>(qObjectWindow);

    // connect our QML signal to our C++ slot
    QObject::connect(this->_window, SIGNAL(clickedButton(QString)),
                             this->_citychoiceMngr, SLOT(onButtonClicked(QString)));
    QObject::connect(this->_window, SIGNAL(chosenCity(QString)),
                             this->_citychoiceMngr, SLOT(onCityChosen(QString)));

    // connect our C++ signal to our QML slot
    QObject::connect(this->_citychoiceMngr, SIGNAL(setTextField(QVariant)),
                             this->_window, SLOT(setTextField(QVariant)));
}

