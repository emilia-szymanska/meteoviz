#include "ButtonManager.h"
#include <QDebug>

ButtonManager::ButtonManager(QObject *parent)
    : QObject(parent)
{

}

Q_INVOKABLE void ButtonManager::onButtonClicked(QString str)
{
    qDebug() << "button: " << str;
    emit setTextField("COJEST");
}
