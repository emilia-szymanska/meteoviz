#include "citychoice_manager.h"

CitychoiceManager::CitychoiceManager(QObject *parent) : QObject(parent)
{

}


Q_INVOKABLE void CitychoiceManager::onButtonClicked(QString str)
{
    qDebug() << "button: " << str;
    emit setTextField("COJEST");
}
