
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/src/qt/myappsettingsclass.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    myAppSettingsClass myAppSettings("Self-Driving Vehicle");
    myAppSettings.setValue("showToolTips", true);
    myAppSettings.setValue("delayForToolTipsToAppear", 50);
    QSettings myAppConstantsSettings("Self-Driving Vehicle");
    myAppConstantsSettings.setValue("iconHeight", 42);
    myAppConstantsSettings.setValue("iconWidth", 42);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("iconHeight", myAppConstantsSettings.value("iconHeight").toInt());
    engine.rootContext()->setContextProperty("iconWidth", myAppConstantsSettings.value("iconWidth").toInt());
    engine.rootContext()->setContextProperty("myAppSettings", &myAppSettings);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Mindful-Journal", "Main");

    return app.exec();
}
