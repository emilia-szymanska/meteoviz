#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQmlContext>

#include "../inc/app_manager.h"


int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    UrlConnection urlCon("https://data.climacell.co/",
                         "D:/qt_projects/meteoviz/text_files/apikey.txt");
    CitychoiceManager citychoiceManager("D:/qt_projects/meteoviz/text_files/polish_cities.txt",
                                        "D:/qt_projects/meteoviz/text_files/general_cities.txt", urlCon);
    WeatherManager weatherManager(urlCon);

    AppManager appManager(&engine, &citychoiceManager, &weatherManager);
    engine.rootContext()->setContextProperty("appManager", &appManager);
    QObject::connect(&engine, &QQmlApplicationEngine::quit, &QApplication::quit);

    return app.exec();
}
