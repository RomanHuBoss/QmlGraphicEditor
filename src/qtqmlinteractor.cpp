#include <QQuickWindow>
#include <QQmlApplicationEngine>
#include "qtqmlinteractor.h"
#include "figuresstorage.h"
#include <QDebug>
#include <QQmlContext>
#include <QFileDialog>
#include <QGuiApplication>

namespace RD = Rosdistant;
using namespace RD;

QtQmlInteractor::QtQmlInteractor(const QGuiApplication * const app):
    _app(app)
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

void QtQmlInteractor::onSetMode(const QString &mode, const QString& additional)
{
    if (mode == "Drawing") {

        QList<QString> availableModes = QList<QString>()
               << "LineSegment"
               << "Multiline"
               << "Rectangle"
               << "Square"
               << "Triangle";

        _mode = (availableModes.contains(additional)) ? mode : QString();
        _drownFigure = additional;
    }
    else if (mode == "Rotate") {

    }
    else if (mode == "Resize") {

    }
    else if (mode == "Color") {

    }
    else if (mode == "Text") {

    }
}

void QtQmlInteractor::onNewScene()
{
    _storage.resetStorage();
}

void QtQmlInteractor::onSelectSceneFile(const QUrl& fileUrl)
{
    QString filePath = fileUrl.toLocalFile();

    if (!QFile(filePath).exists()) {
        emit raiseAlertifyError("Выбранный файл не существует");
    }
    else if (!QFile(filePath).size()) {
        emit raiseAlertifyError("Выбран пустой файл файл");
    }
    else if (!_storage.fillupFromFile(filePath)) {
        emit raiseAlertifyError("Не удалось загрузить файл");
    }

    emit raiseClearScene();
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

