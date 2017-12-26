#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "appsettings.h"
#include "linesegment.h"
#include "triangle.h"
#include "point.h"
#include "rectangle.h"
#include "square.h"

#include <QDebug>

namespace RD = Rosdistant;
using RD::Point;
using RD::LineSegment;
using RD::Triangle;
using RD::Rectangle;
using RD::Square;

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

    qDebug() << Triangle(Point(1,2), Point(3,4), Point(6,2)).getBBox();

    //qDebug() << QString(Point(1, 2));
    //qDebug() << LineSegment(Point(1,2), Point(3,4));
    //qDebug() << Triangle(Point(1,2), Point(3,4), Point(2, 2));
    //qDebug() << RD::Rectangle(Point(1,2), Point(2, 3));

    //qDebug() << t.isValid();
    //qDebug() << t.getCentralPoint();


    return app.exec();
}
