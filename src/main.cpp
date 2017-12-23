#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "appsettings.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    AppSettings::setPath("./" + QCoreApplication::applicationName() + ".ini");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
