#pragma once

#include <QObject>
#include <QtQml>
#include <QWindow>

class FramelessAttachedType : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(bool minButtonVisible READ minButtonVisible WRITE setMinButtonVisible NOTIFY
                   minButtonVisibleChanged)
    Q_PROPERTY(bool maxButtonVisible READ maxButtonVisible WRITE setMaxButtonVisible NOTIFY
                   maxButtonVisibleChanged)
    Q_PROPERTY(bool closeButtonVisible READ closeButtonVisible WRITE setCloseButtonVisible NOTIFY
                   closeButtonVisibleChanged)
    QML_ANONYMOUS
public:
    FramelessAttachedType(QObject *parent);

    bool enabled() const;
    void setEnabled(bool newEnabled);

    bool minButtonVisible() const;
    void setMinButtonVisible(bool newMinButtonVisible);

    bool maxButtonVisible() const;
    void setMaxButtonVisible(bool newMaxButtonVisible);

    bool closeButtonVisible() const;
    void setCloseButtonVisible(bool newCloseButtonVisible);

signals:
    void enabledChanged();
    void minButtonVisibleChanged();
    void maxButtonVisibleChanged();

    void closeButtonVisibleChanged();

private:
    bool m_enabled = false;
    int m_styleMask = 0;
    bool m_minButtonVisible = true;
    bool m_maxButtonVisible = true;
    bool m_closeButtonVisible = true;
};

class FramelessController : public QObject
{
    Q_OBJECT
    QML_ATTACHED(FramelessAttachedType)
    QML_NAMED_ELEMENT(Frameless)
public:
    static FramelessAttachedType *qmlAttachedProperties(QObject *object)
    {
        auto window = qobject_cast<QWindow*>(object);
        if(!window){
            qWarning()<<"Frameless can only be used on a QWindow object!";
            return nullptr;
        }
        return new FramelessAttachedType(object);
    }
};
