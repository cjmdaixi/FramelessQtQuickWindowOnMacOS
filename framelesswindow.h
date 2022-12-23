#pragma once

#include <QObject>

namespace FramelessWindow{
    void handleDestroy(QObject* appWindow);
    void initialize(QObject* appWindow);
}
