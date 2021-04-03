#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQmlContext>

#include "app_manager.h"

int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);    
    QQmlApplicationEngine engine;
    CitychoiceManager citychoiceManager;

    AppManager appManager(&engine, &citychoiceManager);
    engine.rootContext()->setContextProperty("appManager", &appManager);

    return app.exec();
}
