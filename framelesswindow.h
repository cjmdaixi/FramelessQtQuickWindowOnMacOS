#pragma once

#include <QObject>
#include <QtQml>

class FramelessAttachedType : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(bool minButtonVisible READ minButtonVisible WRITE setMinButtonVisible NOTIFY
                   minButtonVisibleChanged)
    QML_ANONYMOUS
public:
    FramelessAttachedType(QObject *parent);

    bool enabled() const;
    void setEnabled(bool newEnabled);

    bool minButtonVisible() const;
    void setMinButtonVisible(bool newMinButtonVisible);
signals:
    void enabledChanged();
    void minButtonVisibleChanged();
private:
    bool m_enabled = false;
    int m_styleMask = 0;
};

class FramelessController : public QObject
{
    Q_OBJECT
    QML_ATTACHED(FramelessAttachedType)
    QML_ELEMENT
public:
    static FramelessAttachedType *qmlAttachedProperties(QObject *object)
    {
        return new FramelessAttachedType(object);
    }
};
