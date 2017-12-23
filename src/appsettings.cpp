#include "appsettings.h"

QString AppSettings::path = QString();

void AppSettings::setPath(const QString& argPath)
{
    path = argPath;
}

QVariant AppSettings::getValue(const QString& argName)
{
    QSettings settings(path, QSettings::IniFormat);
    return settings.value(argName);
}

void AppSettings::setValue(const QString& argName, const QVariant& argValue)
{
    QSettings settings(path, QSettings::IniFormat);
    settings.setValue(argName, argValue);
}
