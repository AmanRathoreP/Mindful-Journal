
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QSettings myAppSettings("Self-Driving Vehicle");
    myAppSettings.setValue("showToolTips", true);
    QSettings myAppConstantsSettings("Self-Driving Vehicle");
    myAppConstantsSettings.setValue("iconHeight", 42);
    myAppConstantsSettings.setValue("iconWidth", 42);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("showToolTips", myAppSettings.value("showToolTips").toBool());
    engine.rootContext()->setContextProperty("iconHeight", myAppConstantsSettings.value("iconHeight").toInt());
    engine.rootContext()->setContextProperty("iconWidth", myAppConstantsSettings.value("iconWidth").toInt());

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Mindful-Journal", "Main");

    return app.exec();
}
