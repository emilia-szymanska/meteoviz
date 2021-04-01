#ifndef APPMANAGER_H
#define APPMANAGER_H

#include <QObject>
#include "ButtonManager.h"


class QQmlApplicationEngine;
class AppManager : public QObject
{
    Q_OBJECT
public:
    explicit AppManager(QQmlApplicationEngine *engine, ButtonManager *btnMngr, QObject *parent = nullptr);
    //QQmlApplicationEngine *_engine = nullptr;

    Q_INVOKABLE void changeWindow();

private:
    QQmlApplicationEngine *_engine = nullptr;
    ButtonManager *_btnMngr = nullptr;
    bool _main = true;
};

#endif // APPMANAGER_H

