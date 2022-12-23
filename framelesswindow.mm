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
