#ifndef CITYCHOICEMANAGER_H
#define CITYCHOICEMANAGER_H

#include <QObject>
#include <QVariant>
#include <QDebug>

class CitychoiceManager : public QObject
{
    Q_OBJECT

    private:
        QString _cityName = "";

    public:
        explicit CitychoiceManager(QObject *parent = nullptr);

    signals:
        void setTextField(QVariant text);
    public slots:
        void onButtonClicked(QString str);
        void onCityChosen(QString city);
};

#endif // CITYCHOICEMANAGER_H
