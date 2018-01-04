#include <QQuickWindow>
#include <QQmlApplicationEngine>
#include "qtqmlinteractor.h"
#include "figuresstorage.h"
#include <QDebug>
#include <QQmlContext>

namespace RD = Rosdistant;
using namespace RD;

QtQmlInteractor::QtQmlInteractor()
{ 
    _engine.rootContext()->setContextProperty("appInteractor", this);
    _engine.load(QUrl(QLatin1String("qrc:/main.qml")));
}

QtQmlInteractor::~QtQmlInteractor()
{
}

bool QtQmlInteractor::isRootContextLoaded()
{
    return !_engine.rootObjects().isEmpty();
}

void QtQmlInteractor::onShowSettings()
{

}

void QtQmlInteractor::onNewScene()
{
    _storage.resetStorage();
}

bool QtQmlInteractor::onSaveScene()
{
    if (_storage.isEmpty()) {
        emit raiseAlertifyError("Невозможно сохранить пустую сцену");
        return false;
    }

    return true;
}

bool QtQmlInteractor::onRedo()
{
    return true;
}

bool QtQmlInteractor::onUndo()
{
    return true;
}
