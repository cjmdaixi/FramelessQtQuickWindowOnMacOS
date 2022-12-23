#include "framelesswindow.h"
#include <QWindow>

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

FramelessAttachedType::FramelessAttachedType(QObject *parent)
    : QObject(parent)
{
    QWindow* win = qobject_cast<QWindow*>(parent);
    NSView* view = reinterpret_cast<NSView*>(win->winId());
    NSWindow* window = [view window];

    m_styleMask = [window styleMask];
}

bool FramelessAttachedType::enabled() const
{
    return m_enabled;
}

void FramelessAttachedType::setEnabled(bool newEnabled)
{
    if(m_enabled == newEnabled) return;
    QWindow* win = qobject_cast<QWindow*>(parent());
    NSView* view = reinterpret_cast<NSView*>(win->winId());
    NSWindow* window = [view window];

    if(newEnabled){
      // imersive title bar
      [window setStyleMask:m_styleMask | NSWindowStyleMaskFullSizeContentView];
      [window setTitlebarAppearsTransparent:YES];
      [window setTitleVisibility:NSWindowTitleHidden];
    }else{
        // imersive title bar
        [window setStyleMask:m_styleMask];
        [window setTitlebarAppearsTransparent:NO];
        [window setTitleVisibility:NSWindowTitleVisible];
    }
    m_enabled = newEnabled;
    emit enabledChanged();
}

bool FramelessAttachedType::minButtonVisible() const
{
    return m_minButtonVisible;
}

void FramelessAttachedType::setMinButtonVisible(bool newMinButtonVisible)
{
    if(m_minButtonVisible == newMinButtonVisible) return;

    QWindow* win = qobject_cast<QWindow*>(parent());
    NSView* view = reinterpret_cast<NSView*>(win->winId());
    NSWindow* window = [view window];

    NSButton* minBtn = [window standardWindowButton:NSWindowMiniaturizeButton];

    if(newMinButtonVisible)
        [minBtn setHidden:NO];
    else
        [minBtn setHidden:YES];
    m_minButtonVisible = newMinButtonVisible;
    emit minButtonVisibleChanged();
}

bool FramelessAttachedType::maxButtonVisible() const
{
    return m_maxButtonVisible;
}

void FramelessAttachedType::setMaxButtonVisible(bool newMaxButtonVisible)
{
    if (m_maxButtonVisible == newMaxButtonVisible)
        return;

    QWindow* win = qobject_cast<QWindow*>(parent());
    NSView* view = reinterpret_cast<NSView*>(win->winId());
    NSWindow* window = [view window];

    NSButton* maxBtn = [window standardWindowButton:NSWindowZoomButton];

    if(newMaxButtonVisible)
        [maxBtn setHidden:NO];
    else
        [maxBtn setHidden:YES];

    m_maxButtonVisible = newMaxButtonVisible;
    emit maxButtonVisibleChanged();
}

bool FramelessAttachedType::closeButtonVisible() const
{
    return m_closeButtonVisible;
}

void FramelessAttachedType::setCloseButtonVisible(bool newCloseButtonVisible)
{
    if (m_closeButtonVisible == newCloseButtonVisible)
        return;

    QWindow* win = qobject_cast<QWindow*>(parent());
    NSView* view = reinterpret_cast<NSView*>(win->winId());
    NSWindow* window = [view window];

    NSButton* closeBtn = [window standardWindowButton:NSWindowCloseButton];

    if(newCloseButtonVisible)
        [closeBtn setHidden:NO];
    else
        [closeBtn setHidden:YES];

    m_closeButtonVisible = newCloseButtonVisible;
    emit closeButtonVisibleChanged();
}
