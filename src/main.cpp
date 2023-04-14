
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

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("showToolTips", myAppSettings.value("showToolTips").toBool());
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Mindful-Journal", "Main");

    return app.exec();
}
