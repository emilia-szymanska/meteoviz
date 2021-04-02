#include "app_manager.h"


AppManager::AppManager(QQmlApplicationEngine *engine, CitychoiceManager *citychoiceMngr, /*ButtonManager *btnMngr,*/ QObject *parent) : QObject(parent)
{
    _engine = engine;
    _citychoiceMngr = citychoiceMngr;
    //_btnMngr = btnMngr;
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
        //_btnMngr = nullptr;
    }

    mainWindow->close();
    qObjectCurrentWindow->deleteLater();
}


void AppManager::initCitychoiceConnections(QObject *qObjectWindow)
{
    this->_window = qobject_cast<QQuickWindow *>(qObjectWindow);

    // connect our QML signal to our C++ slot
    /*
    QObject::connect(this->_window, SIGNAL(clickedButton(QString)),
                             this->_btnMngr, SLOT(onButtonClicked(QString)));

    // connect our C++ signal to our QML slot
    QObject::connect(this->_btnMngr, SIGNAL(setTextField(QVariant)),
                             this->_window, SLOT(setTextField(QVariant)));*/

    QObject::connect(this->_window, SIGNAL(clickedButton(QString)),
                             this->_citychoiceMngr, SLOT(onButtonClicked(QString)));

    // connect our C++ signal to our QML slot
    QObject::connect(this->_citychoiceMngr, SIGNAL(setTextField(QVariant)),
                             this->_window, SLOT(setTextField(QVariant)));
}

