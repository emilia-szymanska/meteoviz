#include "url_connection.h"

UrlConnection::UrlConnection()
{
}

UrlConnection::UrlConnection(QString address)
{
    _urlAddress = address;
}

void UrlConnection::callGeneralWeather(QMap<QString, CoordsWeatherData> & generalWeatherMap)
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
        CoordsWeatherData cityData = generalWeatherMap.value(key);
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

void UrlConnection::callDailyWeather(CityCoords cityData, QMap<QString, DailyForecast> & fourDayForecast)
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

    QString lat = QString::number(cityData.latitude);
    QString lon = QString::number(cityData.longitude);
    /////////
    ///ADD TIME
    ///

    QDateTime currentDate = QDateTime::currentDateTime();
    QDateTime futureDate = currentDate.addDays(3);
    QString formatDay = "yyyy-MM-dd";
    QString formatTime = "hh:mm:ss";
    QString day = currentDate.toString(formatDay);
    QString futureDay = futureDate.toString(formatDay);
    QString time = currentDate.toString(formatTime);
    //2021-03-28T15:00:00Z

    QString url = this->_urlAddress + "v4/timelines?location=" + lat + "," + lon +
                    "&fields=temperature,humidity,windSpeed,windDirection,pressureSurfaceLevel,precipitationIntensity,weatherCode&" +
                    "timesteps=1d&" + "startTime=" + day + "T" + time + "Z" + "&endTime=" + futureDay + "T" + time + "Z" +
                    "&units=metric&apikey=" + apikey;
    qDebug() << url;
    QNetworkReply *response = manager.get(QNetworkRequest(QUrl(url)));

    QEventLoop event;
    QObject::connect(response, SIGNAL(finished()), &event, SLOT(quit()));
    event.exec();

    QString content = response->readAll();
    qDebug() << content;
    readFourDayForecast(content, fourDayForecast);
    //int weatherCode = this->readWeathercode(content);
    //generalWeatherMap[key].weatherCode = weatherCode;

    /*foreach(const QString& key, fourDayForecast.keys()) {
        qDebug() << "===================";
        qDebug() << key;*/
   /*     CoordsWeatherData cityData = fourDayForecast.value(key);
        QString lat = QString::number(cityData.latitude);
        QString lon = QString::number(cityData.longitude);
        qDebug() << lat;
        qDebug() << lon;
*/
        /*QString url = this->_urlAddress + "v4/timelines?location=" + lat + "," + lon +
                "&fields=weatherCode&timesteps=current&units=metric&apikey=" + apikey;
        QNetworkReply *response = manager.get(QNetworkRequest(QUrl(url)));

        QEventLoop event;
        QObject::connect(response, SIGNAL(finished()), &event, SLOT(quit()));
        event.exec();

        QString content = response->readAll();
        int weatherCode = this->readWeathercode(content);
        generalWeatherMap[key].weatherCode = weatherCode;*/
    //}

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
    qDebug() << weatherCode;
    qDebug() << "===================";
    return weatherCode;
}


void UrlConnection::readFourDayForecast(QString content, QMap<QString, DailyForecast> & fourDayForecast)
{
    QJsonDocument doc = QJsonDocument::fromJson(content.toUtf8());
    QJsonObject jsonObject = doc.object();
    QJsonObject data = jsonObject["data"].toObject();
    QJsonArray timelines = data["timelines"].toArray();
    QJsonObject firstEl = timelines.at(0).toObject();
    QJsonArray intervals = firstEl["intervals"].toArray();

    for(int i = 0; i < 4; i++)
    {
        QJsonObject chosenDay = intervals.at(i).toObject();

        /*QJsonObject secondDay = intervals.at(1).toObject();
        QJsonObject thirdDay = intervals.at(2).toObject();
        QJsonObject fourthDay = intervals.at(3).toObject();*/

        QJsonObject values = chosenDay["values"].toObject();

        double temperature   = values["temperature"].toDouble();
        double humidity      = values["humidity"].toDouble();
        double windSpeed     = values["windSpeed"].toDouble();
        double pressure      = values["pressureSurfaceLevel"].toDouble();
        double precipitation = values["precipitationIntensity"].toDouble();
        double windDir       = values["windDirection"].toDouble();
        int weatherCode      = values["weatherCode"].toInt();
        QString windDirection;

        if(windDir >= 345 or windDir <= 15) windDirection = "N";
        if(windDir > 15 and windDir < 75) windDirection = "NE";
        if(windDir >= 75 and windDir <= 105) windDirection = "E";
        if(windDir > 105 and windDir < 165) windDirection = "SE";
        if(windDir >= 165 and windDir <= 195) windDirection = "S";
        if(windDir > 195 and windDir < 225) windDirection = "SW";
        if(windDir >= 225 and windDir <= 285) windDirection = "W";
        if(windDir > 285 and windDir < 345) windDirection = "NW";

        DailyForecast tmp;
        tmp.temperature = temperature;
        tmp.pressure = pressure;
        tmp.humidity = humidity;
        tmp.precipitation = precipitation;
        tmp.windSpeed = windSpeed;
        tmp.weatherCode = weatherCode;
        tmp.windDirection = windDirection;

        QString nr = QString::number(i);
        QString key = "day" + nr;
        fourDayForecast[key] = tmp;

    }

    //return weatherCode;

}
