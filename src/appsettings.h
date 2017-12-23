#ifndef APPSETTINGS_H
#define APPSETTINGS_H

#include <QSettings>
#include <QString>

class AppSettings
{    
public:
    static void setPath(const QString &argPath);
    static QVariant getValue(const QString& argName);
    static void setValue(const QString& argName, const QVariant& argValue);
private:
    static QString path;
};

#endif // APPSETTINGS_H
