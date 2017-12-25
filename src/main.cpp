#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "appsettings.h"
#include "linesegment.h"
#include "triangle.h"
#include "point.h"

#include <QLineF>
#include <QPointF>
#include <QDebug>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    AppSettings::setPath("./" + QCoreApplication::applicationName() + ".ini");
    QGuiApplication::setApplicationName("Графический редактор v. 1.0 (2017)");
    QGuiApplication::setWindowIcon(QIcon(":/24px/app-icon.png"));

    /*QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    */

    //LineSegment l(Point(10, 10), Point(10, 20));
    //l.rotateAroundCenter(90, AngleType::DegreesType);
    Triangle t(Point(1, 5), Point(6, 8), Point(12, 4));
    qDebug() << t.getCentralPoint();

    return app.exec();
}
