#ifndef CITYCHOICEMANAGER_H
#define CITYCHOICEMANAGER_H

#include <QObject>
#include <QVariant>
#include <QDebug>

class CitychoiceManager : public QObject
{
    Q_OBJECT
public:
    explicit CitychoiceManager(QObject *parent = nullptr);

signals:
    void setTextField(QVariant text);
public slots:
    void onButtonClicked(QString str);
};

#endif // CITYCHOICEMANAGER_H
