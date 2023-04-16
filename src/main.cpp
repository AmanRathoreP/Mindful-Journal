
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/src/qt/myappsettingsclass.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    myAppSettingsClass myAppSettings("user-settings.conf");
    QList<QPair<QString, QVariant>> settingsList;
    settingsList.append(qMakePair("showToolTips", true));
    settingsList.append(qMakePair("delayForToolTipsToAppear", 50));

    for (int i = 0; i < settingsList.size(); i++) {
        if (!myAppSettings.contains(settingsList.at(i).first)) {
            myAppSettings.setValue(settingsList.at(i).first, settingsList.at(i).second);
        }
    }

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
