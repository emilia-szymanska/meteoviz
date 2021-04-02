#ifndef APPMANAGER_H
#define APPMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "ButtonManager.h"


class QQmlApplicationEngine;
class AppManager : public QObject
{
    Q_OBJECT

    private:
        QQmlApplicationEngine *_engine = nullptr;
        ButtonManager *_btnMngr = nullptr;
        bool _main = true;
        QQuickWindow *_window  = nullptr;

    public:
        explicit AppManager(QQmlApplicationEngine *engine, ButtonManager *btnMngr, QObject *parent = nullptr);
        Q_INVOKABLE void changeWindow();
        void initCitychoiceConnections(QObject *qObjectWindow);


};

#endif // APPMANAGER_H

