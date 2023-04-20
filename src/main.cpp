
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/src/qt/myappsettingsclass.h"
#include "src/src/qt/mywritergui.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    myAppSettingsClass myAppSettings("user-settings.conf");
    myAppSettings.settingsList.append(qMakePair("showToolTips", true));
    myAppSettings.settingsList.append(qMakePair("delayForToolTipsToAppear", 50));
    myAppSettings.settingsList.append(qMakePair("newItemAddingFormat", "Day <entry_number> (<yyyy>-<MM>-<dd>) [src - <source_number>]"));
    myAppSettings.settingsList.append(qMakePair("newEntryFormat", "entry format is not specified"));

    for (int i = 0; i < myAppSettings.settingsList.size(); i++) {
        if (!myAppSettings.contains(myAppSettings.settingsList.at(i).first)) {
            myAppSettings.setValue(myAppSettings.settingsList.at(i).first, myAppSettings.settingsList.at(i).second);
        }
    }

    myWriterGUI myWriter(myAppSettings.get_value("newEntryFormat").toString(), myAppSettings.get_value("newItemAddingFormat").toString());

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("iconHeight", 42);
    engine.rootContext()->setContextProperty("iconWidth", 42);
    engine.rootContext()->setContextProperty("myAppSettings", &myAppSettings);
    engine.rootContext()->setContextProperty("myWriter", &myWriter);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("Mindful-Journal", "Main");

    return app.exec();
}
