
#include "myappsettingsclass.h"
#include <QSettings>

myAppSettingsClass::myAppSettingsClass(const QString &organization)
    : QSettings(organization)
{
    qDebug() << "Settings class sucessfully created!";
}

QVariant myAppSettingsClass::get_value(QString value_name)
{
    return this->value(value_name);
}

void myAppSettingsClass::set_value(QString value_name, bool value_to_put)
{
    this->setValue(value_name,value_to_put);
}

void myAppSettingsClass::set_value(QString value_name, int value_to_put)
{
    this->setValue(value_name,value_to_put);
}
