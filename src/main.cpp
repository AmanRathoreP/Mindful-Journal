
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/src/qt/myappsettingsclass.h"
#include "src/src/qt/mywritergui.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    myWriterGUI myWriter("123");
    myAppSettingsClass myAppSettings("user-settings.conf");
    myAppSettings.settingsList.append(qMakePair("showToolTips", true));
    myAppSettings.settingsList.append(qMakePair("delayForToolTipsToAppear", 50));

    for (int i = 0; i < myAppSettings.settingsList.size(); i++) {
        if (!myAppSettings.contains(myAppSettings.settingsList.at(i).first)) {
            myAppSettings.setValue(myAppSettings.settingsList.at(i).first, myAppSettings.settingsList.at(i).second);
        }
    }

    QSettings myAppConstantsSettings("Self-Driving Vehicle");
    myAppConstantsSettings.setValue("iconHeight", 42);
    myAppConstantsSettings.setValue("iconWidth", 42);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("iconHeight", myAppConstantsSettings.value("iconHeight").toInt());
    engine.rootContext()->setContextProperty("iconWidth", myAppConstantsSettings.value("iconWidth").toInt());
    engine.rootContext()->setContextProperty("myAppSettings", &myAppSettings);
    engine.rootContext()->setContextProperty("myWriter", &myWriter);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("Mindful-Journal", "Main");

    return app.exec();
}
