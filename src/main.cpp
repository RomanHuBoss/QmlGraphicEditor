#include <QGuiApplication>
#include <QIcon>
#include "qtqmlinteractor.h"
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


    QtQmlInteractor interactor(&app);

    if (!interactor.isRootContextLoaded())
        return -1;

    return app.exec();
}
