#include "framelesswindow.h"
#include <QWindow>

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

namespace FramelessWindow{

void initialize(QObject* appWindow)
{
    QWindow* win = qobject_cast<QWindow*>(appWindow);
    NSView* view = reinterpret_cast<NSView*>(win->winId());
    NSWindow* window = [view window];

    // imersive title bar
    [window setStyleMask:[window styleMask] | NSWindowStyleMaskFullSizeContentView];
    [window setTitlebarAppearsTransparent:YES];
    [window setTitleVisibility:NSWindowTitleHidden];

    NSButton* minBtn = [window standardWindowButton:NSWindowMiniaturizeButton];
    NSButton* maxBtn = [window standardWindowButton:NSWindowZoomButton];
    NSButton* closeBtn = [window standardWindowButton:NSWindowCloseButton];

    [minBtn setHidden:YES];
    [maxBtn setHidden:YES];
    [closeBtn setHidden:NO];
}
}

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
    QWindow* win = qobject_cast<QWindow*>(parent());
    NSView* view = reinterpret_cast<NSView*>(win->winId());
    NSWindow* window = [view window];

    NSButton* minBtn = [window standardWindowButton:NSWindowMiniaturizeButton];

    bool isVisible = [minBtn isHidden];
    return isVisible;
}

void FramelessAttachedType::setMinButtonVisible(bool newMinButtonVisible)
{
    QWindow* win = qobject_cast<QWindow*>(parent());
    NSView* view = reinterpret_cast<NSView*>(win->winId());
    NSWindow* window = [view window];

    NSButton* minBtn = [window standardWindowButton:NSWindowMiniaturizeButton];

    if(newMinButtonVisible)
      [minBtn setHidden:NO];
    else
        [minBtn setHidden:YES];
}
