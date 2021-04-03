#include "url_connection.h"

UrlConnection::UrlConnection()
{
}

UrlConnection::UrlConnection(QString address)
{
    _urlAddress = address; // https://data.climacell.co/
}

void UrlConnection::callGeneralWeather(QJsonObject generalWeatherList)
{

    ////// APIKEY ///////////
    QFile file("D:/qt_projects/meteoviz/apikey.txt");
    if(!file.open(QIODevice::ReadOnly)) {
        QMessageBox::information(0, "error", file.errorString());
    }
    QTextStream in(&file);
    QString apikey = in.readLine();
    file.close();

    /////// TIME ///////////
    /*QDateTime currentDate = QDateTime::currentDateTime();
    QString formatDay = "yyyy-MM-dd";
    QString formatTime = "hh:mm:ss";
    QString day = currentDate.toString(formatDay);
    QString time = currentDate.toString(formatTime);
    //2021-03-28T15:00:00Z
*/
    //QJsonObject json = doc.object();


    QNetworkAccessManager manager;

    foreach(const QString& key, generalWeatherList.keys()) {
        QJsonObject cityData = generalWeatherList.value(key).toObject();
        QString location = cityData["coords"].toString();
        QString url = this->_urlAddress + "v4/timelines?location=" + location + "&fields=weatherCode&timesteps=current&units=metric&apikey=" + apikey;
        QNetworkReply *response = manager.get(QNetworkRequest(QUrl(url)));
        QEventLoop event;
        QObject::connect(response, SIGNAL(finished()), &event, SLOT(quit()));
        event.exec();
        QString content = response->readAll();
        QJsonDocument doc = QJsonDocument::fromJson(content.toUtf8());
        QJsonObject jsonObject = doc.object();
        QJsonObject data = jsonObject["data"].toObject();
        qDebug() << "===================";
        qDebug() << data;
        QJsonArray timelines = data["timelines"].toArray();
        qDebug() << timelines;
        QJsonObject firstEl = timelines.at(0).toObject();
        qDebug() << firstEl;
        QJsonArray intervals = firstEl["intervals"].toArray();
        qDebug() << intervals;
        QJsonObject firstInterval = intervals.at(0).toObject();
        qDebug() << firstInterval;
        QJsonObject values = firstInterval["values"].toObject();
        qDebug() << values;
        int weatherCode = values["weatherCode"].toInt();
        qDebug() << weatherCode;
        qDebug() << "===================";
        cityData.insert("weather_code", weatherCode);
    }







}
