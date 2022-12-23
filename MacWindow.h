#ifndef MACWINDOW_H
#define MACWINDOW_H

#include <QObject>

class MacWindow : public QObject
{
    Q_OBJECT

public:
    explicit MacWindow(QObject *parent = nullptr) : QObject(parent) {}
    virtual ~MacWindow() = default;

    Q_INVOKABLE void handleDestroy(QObject* appWindow);
    Q_INVOKABLE void handleInit(QObject* appWindow);

private:
};

#endif // MACWINDOW_H