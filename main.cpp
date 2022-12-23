
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>

#include <QLocale>
#include <QTranslator>

#include "MacWindow.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationDisplayName("Euca Notes App");
    app.setApplicationName("EucaNotes");
    app.setOrganizationName("Euca-family Apps");
    app.setOrganizationDomain("space.chenjinming.space");

    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "EucaNotes_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }

    QQmlApplicationEngine engine;
#if __APPLE__
    MacWindow windowEx;
#endif
    engine.rootContext()->setContextProperty("WindowEx", &windowEx);
    const QUrl url(u"qrc:/FramelessQuickDemo/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}


