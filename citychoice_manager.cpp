#include "citychoice_manager.h"

CitychoiceManager::CitychoiceManager(QObject *parent) : QObject(parent)
{

}


Q_INVOKABLE void CitychoiceManager::onButtonClicked(QString str)
{
    qDebug() << "button: " << str;
    emit setTextField("COJEST");
}


Q_INVOKABLE void CitychoiceManager::onCityChosen(QString city)
{
    this->_cityName = city;
    qDebug() << "city: " << _cityName;
}
