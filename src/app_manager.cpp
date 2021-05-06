#include "../inc/app_manager.h"

AppManager::AppManager(QQmlApplicationEngine *engine, CitychoiceManager *citychoiceMngr, WeatherManager *weatherMngr, QObject *parent) : QObject(parent)
{
    _engine = engine;
    _citychoiceMngr = citychoiceMngr;
    _weatherMngr = weatherMngr;

    _engine->load(QUrl(QStringLiteral("qrc:/citychoice.qml")));
    Q_ASSERT( !_engine->rootObjects().isEmpty() );

    QObject *topQObjectWindow = _engine->rootObjects().value(0);
    this->initCitychoiceConnections(topQObjectWindow);
    this->_citychoiceMngr->initCitiesCombobox();
    this->_citychoiceMngr->initMapItems();
}


void AppManager::changeWindow()
{
    QObject *qObjectCurrentWindow = _engine->rootObjects().value(0);
    Q_ASSERT( qObjectCurrentWindow != NULL );

    QQuickWindow* mainWindow = qobject_cast<QQuickWindow*>(qObjectCurrentWindow);
    Q_ASSERT( mainWindow );

    _main = !_main;
    if (_main){
        _engine->load(QUrl(QStringLiteral("qrc:/citychoice.qml")));
        QObject *qObjectWindow = _engine->rootObjects().value(1);
        this->initCitychoiceConnections(qObjectWindow);
        this->_citychoiceMngr->initCitiesCombobox();
        this->_citychoiceMngr->initMapItems();
    }
    else{
        _engine->load(QUrl(QStringLiteral("qrc:/weather.qml")));
        QObject *qObjectWindow = _engine->rootObjects().value(1);
        this->initWeatherConnections(qObjectWindow);
        this->_weatherMngr->sendCity(this->_citychoiceMngr->selectedCity());
        ///////////////////////////////
        /// uncomment when needed
        this->_weatherMngr->callFourDayForecast();
        this->_weatherMngr->callGraphForecast();
        this->_weatherMngr->sendFourDayForecast();
        //////////////////////////////
        this->_weatherMngr->sendGraphForecast();

    }

    mainWindow->close();
    qObjectCurrentWindow->deleteLater();
}


void AppManager::initCitychoiceConnections(QObject *qObjectWindow)
{
    this->_window = qobject_cast<QQuickWindow *>(qObjectWindow);

    // connect QML signals to C++ slots
    QObject::connect(this->_window, SIGNAL(chosenCity(QString)),
                             this->_citychoiceMngr, SLOT(onCityChosen(QString)));
    QObject::connect(this->_window, SIGNAL(customCoords(QString)),
                             this->_citychoiceMngr, SLOT(onCustomCoords(QString)));

    // connect C++ signals to QML slots
    QObject::connect(this->_citychoiceMngr, SIGNAL(sendPinPosition(QVariant,QVariant)),
                             this->_window, SLOT(addMarker(QVariant,QVariant)));

    QObject::connect(this->_citychoiceMngr, SIGNAL(setCitiesCombobox(QVariant)),
                            this->_window, SLOT(setCitiesList(QVariant)));

    QObject::connect(this->_citychoiceMngr, SIGNAL(setMapItems(QVariant)),
                            this->_window, SLOT(setMapItems(QVariant)));

}


void AppManager::initWeatherConnections(QObject *qObjectWindow)
{
   this->_window = qobject_cast<QQuickWindow *>(qObjectWindow);

   // QML to C++ slots
   QObject::connect(this->_window, SIGNAL(refresh()),
                             this->_weatherMngr, SLOT(refreshRequest()));

   // C++ to QML slots
   QObject::connect(this->_weatherMngr, SIGNAL(setCityLabel(QVariant)),
                            this->_window, SLOT(setCityLabel(QVariant)));

   QObject::connect(this->_weatherMngr, SIGNAL(setGraphForecast(QVariant,QVariant)),
                           this->_window, SLOT(updateSeries(QVariant,QVariant)));


   QObject::connect(this->_weatherMngr, SIGNAL(setFourDayForecast(QVariant)),
                           this->_window, SLOT(setFourWeatherForecast(QVariant)));


}
