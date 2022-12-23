#include "MacWindow.h"
#include <QWindow>

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

#define TITLEBAR_HEIGHT 40

static void moveTrafficLights(const NSWindow* window)
{
    // get title bar buttons
    NSButton* minBtn = [window standardWindowButton:NSWindowMiniaturizeButton];
    NSButton* maxBtn = [window standardWindowButton:NSWindowZoomButton];
    NSButton* closeBtn = [window standardWindowButton:NSWindowCloseButton];

    // move buttons
    int q = (TITLEBAR_HEIGHT / 4);
    [minBtn setFrameOrigin:NSPoint{minBtn.frame.origin.x+q, minBtn.frame.origin.y - q}];
    [maxBtn setFrameOrigin:NSPoint{maxBtn.frame.origin.x+q, maxBtn.frame.origin.y - q}];
    [closeBtn setFrameOrigin:NSPoint{closeBtn.frame.origin.x+q, closeBtn.frame.origin.y - q}];
}

static void windowDidResize(CFNotificationCenterRef /*center*/, void* /*observer*/, CFStringRef /*name*/, const void* object, CFDictionaryRef /*userInfo*/)
{
//    NSWindow* window = reinterpret_cast<NSWindow*>(object);
//    moveTrafficLights(window);
}

void MacWindow::handleDestroy(QObject* /*appWindow*/)
{
    CFNotificationCenterRemoveEveryObserver(CFNotificationCenterGetLocalCenter(), this);
}

void MacWindow::handleInit(QObject* appWindow)
{
    QWindow* win = qobject_cast<QWindow*>(appWindow);
    NSView* view = reinterpret_cast<NSView*>(win->winId());
    NSWindow* window = [view window];

    // imersive title bar
    [window setStyleMask:[window styleMask] | NSWindowStyleMaskFullSizeContentView];
    [window setTitlebarAppearsTransparent:YES];
    [window setTitleVisibility:NSWindowTitleHidden];

    // resize title bar
    NSView* dummyView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 20, TITLEBAR_HEIGHT-20)];
    NSTitlebarAccessoryViewController* dummyCtrl = [NSTitlebarAccessoryViewController new];
    dummyCtrl.view = dummyView;
    dummyCtrl.fullScreenMinHeight = TITLEBAR_HEIGHT;
    [window addTitlebarAccessoryViewController:dummyCtrl];

    // need to bind resize signal to move buttons
    CFNotificationCenterAddObserver(
       CFNotificationCenterGetLocalCenter(),
       this,
       &windowDidResize,
       CFSTR("NSWindowDidResizeNotification"),
       window,
       CFNotificationSuspensionBehaviorDeliverImmediately);

    moveTrafficLights(window);
}
