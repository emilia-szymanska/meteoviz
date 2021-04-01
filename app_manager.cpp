#include "app_manager.h"
#include <QQmlApplicationEngine>
#include <QQuickWindow>



AppManager::AppManager(QQmlApplicationEngine *engine, ButtonManager *btnMngr, QObject *parent) : QObject(parent)
{
    _engine = engine;
    _btnMngr = btnMngr;

}

void AppManager::changeWindow()
{
    QObject *qObject = _engine->rootObjects().first();
    Q_ASSERT( qObject != NULL );

    QQuickWindow* mainWindow = qobject_cast<QQuickWindow*>(qObject);
    Q_ASSERT( mainWindow );

    _main = !_main;
    if (_main)
    {
        _engine->load(QUrl(QStringLiteral("qrc:/citychoice.qml")));
        QObject *topLevel = _engine->rootObjects().value(1);
        QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
        qDebug() << window;

        // connect our QML signal to our C++ slot
        QObject::connect(window, SIGNAL(clickedButton(QString)),
                                 _btnMngr, SLOT(onButtonClicked(QString)));

        // connect our C++ signal to our QML slot
        QObject::connect(_btnMngr, SIGNAL(setTextField(QVariant)),
                                 window, SLOT(setTextField(QVariant)));

    } else
    {
        _engine->load(QUrl(QStringLiteral("qrc:/weather.qml")));
    }

    mainWindow->close();

    qObject->deleteLater();
}


