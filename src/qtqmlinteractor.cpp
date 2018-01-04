#include <QQuickWindow>
#include <QQmlApplicationEngine>
#include "qtqmlinteractor.h"
#include <QDebug>

QtQmlInteractor::QtQmlInteractor()
{
    _engine.load(QUrl(QLatin1String("qrc:/main.qml")));
}

QtQmlInteractor::~QtQmlInteractor()
{

}

bool QtQmlInteractor::isRootContextLoaded()
{
    return !_engine.rootObjects().isEmpty();
}
