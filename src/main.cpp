#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "appsettings.h"
#include "linesegment.h"
#include "point.h"

#include <QLineF>
#include <QPointF>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    AppSettings::setPath("./" + QCoreApplication::applicationName() + ".ini");
    QGuiApplication::setApplicationName("Графический редактор v. 1.0 (2017)");
    QGuiApplication::setWindowIcon(QIcon(":/24px/app-icon.png"));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    LineSegment l1( Point(1,2), Point(3, 2));
    LineSegment l2( Point(3,2), Point(2, 2));
    LineSegment::IntersectType type = l1.checkIntersection(l2);

    if (type == LineSegment::UnboundedIntersection) {
        qWarning("UnboundedIntersection");
    }
    else if (type == LineSegment::BoundedIntersection) {
        qWarning("BoundedIntersection");
    }
    else {
        qWarning("NoIntersection");
    }

    return app.exec();
}
