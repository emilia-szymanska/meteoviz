#include "url_connection.h"

UrlConnection::UrlConnection()
{
}

UrlConnection::UrlConnection(QString address)
{
    _urlAddress = address;
}

void UrlConnection::callGeneralWeather(QMap<QString, CityData> & generalWeatherMap)
{

    ////// APIKEY ///////////
    QFile file("D:/qt_projects/meteoviz/apikey.txt");
    if(!file.open(QIODevice::ReadOnly)) {
        QMessageBox::information(0, "error", file.errorString());
    }
    QTextStream in(&file);
    QString apikey = in.readLine();
    file.close();

    QNetworkAccessManager manager;

    foreach(const QString& key, generalWeatherMap.keys()) {
        qDebug() << "===================";
        qDebug() << key;
        //QJsonObject cityData = generalWeatherMap.value(key).toObject();
        //QString lat = QString::number(cityData["latitude"].toDouble());
        //QString lon = QString::number(cityData["longitude"].toDouble());
        CityData cityData = generalWeatherMap.value(key);
        QString lat = QString::number(cityData.latitude);
        QString lon = QString::number(cityData.longitude);
        qDebug() << lat;
        qDebug() << lon;

        /*QString url = this->_urlAddress + "v4/timelines?location=" + lat + "," + lon +
                "&fields=weatherCode&timesteps=current&units=metric&apikey=" + apikey;
        QNetworkReply *response = manager.get(QNetworkRequest(QUrl(url)));

        QEventLoop event;
        QObject::connect(response, SIGNAL(finished()), &event, SLOT(quit()));
        event.exec();

        QString content = response->readAll();
        int weatherCode = this->readWeathercode(content);
        generalWeatherMap[key].weatherCode = weatherCode;*/
    }

}


int UrlConnection::readWeathercode(QString content)
{
    QJsonDocument doc = QJsonDocument::fromJson(content.toUtf8());
    QJsonObject jsonObject = doc.object();
    QJsonObject data = jsonObject["data"].toObject();
    QJsonArray timelines = data["timelines"].toArray();
    QJsonObject firstEl = timelines.at(0).toObject();
    QJsonArray intervals = firstEl["intervals"].toArray();
    QJsonObject firstInterval = intervals.at(0).toObject();
    QJsonObject values = firstInterval["values"].toObject();
    int weatherCode = values["weatherCode"].toInt();
    //qDebug() << weatherCode;
    //qDebug() << "===================";
    return weatherCode;
}
