#include "url_connection.h"

UrlConnection::UrlConnection()
{
}


UrlConnection::UrlConnection(QString address, QString keyFilePath)
{
    _urlAddress = address;
    _apiKeyFilepath = keyFilePath;
}


QString UrlConnection::getApiKey()
{
    QFile file(_apiKeyFilepath);
    if(!file.open(QIODevice::ReadOnly)) {
        QMessageBox::information(0, "error", file.errorString());
    }
    QTextStream in(&file);
    QString apikey = in.readLine();
    file.close();
    return apikey;
}


QJsonArray UrlConnection::fromStringToIntervals(QString content)
{
    QJsonDocument doc = QJsonDocument::fromJson(content.toUtf8());
    QJsonObject jsonObject = doc.object();
    QJsonObject data = jsonObject["data"].toObject();
    QJsonArray timelines = data["timelines"].toArray();
    QJsonObject firstEl = timelines.at(0).toObject();
    QJsonArray intervals = firstEl["intervals"].toArray();
    return intervals;
}


void UrlConnection::callGeneralWeather(QMap<QString, CoordsWeatherData> & generalWeatherMap)
{
    QString apikey = getApiKey();

    QNetworkAccessManager manager;

    foreach(const QString& key, generalWeatherMap.keys()) {
        CoordsWeatherData cityData = generalWeatherMap.value(key);
        QString lat = QString::number(cityData.latitude);
        QString lon = QString::number(cityData.longitude);

        ////////////////// uncomment when you want to use curl

        /*QString url = this->_urlAddress + "v4/timelines?location=" + lat + "," + lon +
                "&fields=weatherCode&timesteps=current&units=metric&apikey=" + apikey;
        QNetworkReply *response = manager.get(QNetworkRequest(QUrl(url)));

        QEventLoop event;
        QObject::connect(response, SIGNAL(finished()), &event, SLOT(quit()));
        event.exec();

        QString content = response->readAll();
        int weatherCode = this->readWeathercode(content);
        generalWeatherMap[key].weatherCode = weatherCode;*/
        /////////////////////////////////
    }
}


void UrlConnection::callDailyWeather(CityCoords cityData, QMap<QString, DailyForecast> & fourDayForecast)
{
    QString apikey = getApiKey();
    QString lat = QString::number(cityData.latitude);
    QString lon = QString::number(cityData.longitude);

    ///// ADD TIME /////////
    /// 2021-03-28T15:00:00Z

    QDateTime currentDate = QDateTime::currentDateTime();
    QDateTime futureDate = currentDate.addDays(3);
    QString formatDay = "yyyy-MM-dd";
    QString formatTime = "hh:mm:ss";
    QString day = currentDate.toString(formatDay);
    QString futureDay = futureDate.toString(formatDay);
    QString time = currentDate.toString(formatTime);


    QString url = this->_urlAddress + "v4/timelines?location=" + lat + "," + lon +
                    "&fields=temperature,humidity,windSpeed,windDirection,pressureSurfaceLevel,precipitationIntensity,weatherCode&" +
                    "timesteps=1d&" + "startTime=" + day + "T" + time + "Z" + "&endTime=" + futureDay + "T" + time + "Z" +
                    "&units=metric&apikey=" + apikey;


    QNetworkAccessManager manager;
    QNetworkReply *response = manager.get(QNetworkRequest(QUrl(url)));

    QEventLoop event;
    QObject::connect(response, SIGNAL(finished()), &event, SLOT(quit()));
    event.exec();

    QString content = response->readAll();
    readFourDayForecast(content, fourDayForecast);

}


void UrlConnection::callGraphWeather(CityCoords city, QMap<QString, GraphData> & graphData)
{
    QString apikey = getApiKey();

    QString lat = QString::number(city.latitude);
    QString lon = QString::number(city.longitude);

    /////////
    ///ADD TIME
    //2021-03-28T15:00:00Z

    QDateTime currentDate = QDateTime::currentDateTime();
    QDateTime futureDate = currentDate.addSecs(7*60*60);
    QString formatDay = "yyyy-MM-dd";
    QString formatTime = "hh:00:00";
    QString day = currentDate.toString(formatDay);
    QString futureDay = futureDate.toString(formatDay);
    QString time = currentDate.toString(formatTime);
    QString futureTime = futureDate.toString(formatTime);


    QString url = this->_urlAddress + "v4/timelines?location=" + lat + "," + lon +
                    "&fields=temperature,precipitationIntensity&" +
                    "timesteps=1h&" + "startTime=" + day + "T" + time + "Z" + "&endTime=" + futureDay + "T" + futureTime + "Z" +
                    "&units=metric&apikey=" + apikey;

    QNetworkAccessManager manager;
    QNetworkReply *response = manager.get(QNetworkRequest(QUrl(url)));

    QEventLoop event;
    QObject::connect(response, SIGNAL(finished()), &event, SLOT(quit()));
    event.exec();

    QString content = response->readAll();
    readGraphWeather(content, graphData);
}


int UrlConnection::readWeathercode(QString content)
{
    QJsonArray intervals = fromStringToIntervals(content);
    QJsonObject firstInterval = intervals.at(0).toObject();
    QJsonObject values = firstInterval["values"].toObject();
    int weatherCode = values["weatherCode"].toInt();
    return weatherCode;
}


void UrlConnection::readFourDayForecast(QString content, QMap<QString, DailyForecast> & fourDayForecast)
{
    QJsonArray intervals = fromStringToIntervals(content);

    for(int i = 0; i < 4; i++)
    {
        QJsonObject chosenDay = intervals.at(i).toObject();
        QJsonObject values = chosenDay["values"].toObject();

        double temperature   = values["temperature"].toDouble();
        double humidity      = values["humidity"].toDouble();
        double windSpeed     = values["windSpeed"].toDouble();
        double pressure      = values["pressureSurfaceLevel"].toDouble();
        double precipitation = values["precipitationIntensity"].toDouble();
        double windDir       = values["windDirection"].toDouble();
        int weatherCode      = values["weatherCode"].toInt();
        QString windDirection;

        if(windDir >= 345 or  windDir <=  15)  windDirection = "N";
        if(windDir > 15   and windDir <   75)  windDirection = "NE";
        if(windDir >= 75  and windDir <= 105)  windDirection = "E";
        if(windDir > 105  and windDir <  165)  windDirection = "SE";
        if(windDir >= 165 and windDir <= 195)  windDirection = "S";
        if(windDir > 195  and windDir <  225)  windDirection = "SW";
        if(windDir >= 225 and windDir <= 285)  windDirection = "W";
        if(windDir > 285  and windDir <  345)  windDirection = "NW";

        DailyForecast tmp;
        tmp.temperature   = temperature;
        tmp.pressure      = pressure;
        tmp.humidity      = humidity;
        tmp.precipitation = precipitation;
        tmp.windSpeed     = windSpeed;
        tmp.weatherCode   = weatherCode;
        tmp.windDirection = windDirection;

        QString nr = QString::number(i);
        QString key = "day" + nr;
        fourDayForecast[key] = tmp;

    }
}


void UrlConnection::readGraphWeather(QString content, QMap<QString, GraphData> & graphData)
{
    GraphData precitipationData;
    GraphData temperatureData;

    QJsonArray intervals = fromStringToIntervals(content);

    for(auto it = intervals.begin(); it != intervals.end(); ++it)
    {
        QJsonObject chosenTime = it->toObject();
        QJsonObject values = chosenTime["values"].toObject();

        double temperature   = values["temperature"].toDouble();
        double precipitation = values["precipitationIntensity"].toDouble();

        temperatureData.data.append(temperature);
        precitipationData.data.append(precipitation);
    }

    graphData["temperature"]   = temperatureData;
    graphData["precitipation"] = precitipationData;
}
