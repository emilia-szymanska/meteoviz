#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQmlContext>
#include <QQuickWindow>
#include "ButtonManager.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/citychoice.qml")));

    ButtonManager buttonManager;
    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);

    // connect our QML signal to our C++ slot
    QObject::connect(window, SIGNAL(clickedButton(QString)),
                             &buttonManager, SLOT(onButtonClicked(QString)));

    // connect our C++ signal to our QML slot
    QObject::connect(&buttonManager, SIGNAL(setTextField(QVariant)),
                             window, SLOT(setTextField(QVariant)));

    qDebug() << "xdd";
    engine.load(QUrl(QStringLiteral("qrc:/weather.qml")));

    return app.exec();
}
