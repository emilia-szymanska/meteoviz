#ifndef BUTTONMANAGER_H
#define BUTTONMANAGER_H

#include <QObject>
#include <QVariant>

class ButtonManager : public QObject
{
    Q_OBJECT
public:
    explicit ButtonManager(QObject *parent = nullptr);

signals:
    void setTextField(QVariant text);

public slots:
    void onButtonClicked(QString str);


};

#endif // BUTTONMANAGER_H

