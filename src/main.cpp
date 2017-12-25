#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "appsettings.h"
#include "linesegment.h"
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

    LineSegment l1( Point(1,2), Point(5, 2));
    LineSegment l2( Point(1,0), Point(6, 3));

    LineSegment::IntersectType type = l1.checkIntersection(l2);

    if (type == LineSegment::Overlapping) {
        qWarning("Overlapping");
    }
    else if (type == LineSegment::Intersection) {
        qWarning("OnePointIntersection");
    }
    else if (type == LineSegment::Parallel) {
        qWarning("Parallel");
    }
    else {
        qWarning("NoIntersection");
    }

    return app.exec();
}
