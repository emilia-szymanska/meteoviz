#ifndef APPMANAGER_H
#define APPMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QQuickWindow>
#include "citychoice_manager.h"
#include "weather_manager.h"



class QQmlApplicationEngine;
/*! Class responsible for managing the app, switching between windows,
 *  connecting slots with signals etc.
 */
class AppManager : public QObject
{
    Q_OBJECT

    private:
        QQmlApplicationEngine *_engine = nullptr;       /**< pointer to the engine of the app */
        CitychoiceManager *_citychoiceMngr = nullptr;   /**< pointer to the manager of the first window */
        WeatherManager *_weatherMngr = nullptr;         /**< pointer to the manager of the second window */
        bool _main = true;                              /**< bool value stating if the first window is active */
        QQuickWindow *_window  = nullptr;               /**< pointer to the current window */

    public:
        /*!
         * @brief Public constructor
         * @param[in] engine Pointer to the engine of the app
         * @param[in] citychoiceMngr Pointer to the manager of the first window
         * @param[in] weatherMngr Pointer to the manager of the second window
         * @param[in] parent Pointer to the QObject parent
         */
        explicit AppManager(QQmlApplicationEngine *engine, CitychoiceManager *citychoiceMngr,
                            WeatherManager *weatherMngr, QObject *parent = nullptr);
        /*!
         * @brief Public method enabling switching between windows
         */
        Q_INVOKABLE void changeWindow();
        /*!
         * @brief Public method for initializing the slot-signal pairs regarding the first window
         * @param[in] qObjectWindow Pointer to the chosen window (it should be the first window)
         */
        void initCitychoiceConnections(QObject *qObjectWindow);
        /*!
         * @brief Public method for initializing the slot-signal pairs regarding the second window
         * @param[in] qObjectWindow Pointer to the chosen window (it should be the second window)
         */
        void initWeatherConnections(QObject *qObjectWindow);


};

#endif // APPMANAGER_H

