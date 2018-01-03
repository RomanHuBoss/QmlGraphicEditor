#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "figuresstorage.h"
#include "appsettings.h"
#include "linesegment.h"
#include "triangle.h"
#include "point.h"
#include "rectangle.h"
#include "square.h"
#include "multiline.h"

#include <QDebug>

using namespace Rosdistant;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    AppSettings::setPath("./" + QCoreApplication::applicationName() + ".ini");
    QGuiApplication::setApplicationName("Графический редактор v. 1.0 (2017)");
    QGuiApplication::setWindowIcon(QIcon(":/24px/app-icon.png"));

    //FiguresStorage fs;
    /*LineSegment ls(Point(1,2), Point(3,4));
    fs.addFigure(&ls);
    fs.saveToFile("qqqq.txt");*/
    //fs.fillupFromFile("qqqq.txt");

    //Rosdistant::Rectangle rect(Point(3,3), Point(6,3), Point(4,1), Point(1,1));
    //Rosdistant::Rectangle bbox = rect.getBBox();
    //rect.bbSideResize(Figure::BBoxLeft, -1);
    //qDebug() << bbox.isValid();

    //Point points[] = {Point(1,1), Point(2,2), Point(3,4)};
    //Rosdistant::Multiline ml(points , 3, false);
    //qDebug() << ml;

    //FiguresStorage fs;
    //fs.addFigure(new LineSegment(Point(1,2), Point(3,4)));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
