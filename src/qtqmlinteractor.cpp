#include <QQuickWindow>
#include <QQmlApplicationEngine>
#include "qtqmlinteractor.h"
#include "figuresstorage.h"
#include <QDebug>
#include <QQmlContext>
#include <QFileDialog>
#include <QGuiApplication>
#include "linesegment.h"
#include "multiline.h"
#include "rectangle.h"
#include "figure.h"
#include "square.h"
#include "triangle.h"

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

//парсер данных добавляемой в QML-фигуры
bool QtQmlInteractor::onAddQmlFigure(const QVariantMap& data)
{
    QString mode = data.value("mode").toString();
    QVariantList vertices = data.value("vertices").toList();

    if (!vertices.length()) {
        emit raiseAlertifyError("Невозможно создать фигуру без вершин");
        return false;
    }

    Figure * figure;

    if (mode == "DrawLineSegment")
        figure = new LineSegment;
    else if (mode == "DrawTriangle")
        figure = new Triangle;
    else if (mode == "DrawMultiline") {
        figure = new Multiline;
        dynamic_cast<Multiline*>(figure)->setIsClosed(false);
    }
    else if (mode == "DrawPolygon") {
        figure = new Multiline;
        dynamic_cast<Multiline*>(figure)->setIsClosed(true);
    }
    else if (mode == "DrawRectangle")
        figure = new Rectangle;
    else if (mode == "DrawSquare")
        figure = new Square;
    else {
        emit raiseAlertifyError("Неизвестный тип фигуры");
        return false;
    }

    foreach (auto tmp, vertices) {
        QVariantMap vertice = tmp.toMap();
        Point p(vertice["x"].toDouble(), vertice["y"].toDouble());
        figure->insertLastPoint(p);
    }

    _storage.addFigure(figure);

    emit raiseDrawFigureOnScene(figure->toQML());

    return true;
}

bool QtQmlInteractor::onRotateQmlFigure(const QString& uuid, double angle)
{
    Figure * figure = _storage.getFigure(uuid);
    figure->rotateAroundCenter(angle, AngleType::DegreesType);

    emit raiseDrawFigureOnScene(figure->toQML());

    return true;
}

bool QtQmlInteractor::onFillQmlFigure(const QString &uuid, const QString &color)
{
    Figure * figure = _storage.getFigure(uuid);
    figure->setIsFilled(true);
    figure->setBgColor(color);

    emit raiseDrawFigureOnScene(figure->toQML());

    return true;
}

bool QtQmlInteractor::onMoveQmlFigure(const QString &uuid, double dx, double dy)
{
    Figure * figure = _storage.getFigure(uuid);
    figure->move(dx, dy);
    emit raiseDrawFigureOnScene(figure->toQML());
    return true;
}

bool QtQmlInteractor::onRemoveQmlFigure(const QString &uuid)
{
    _storage.removeFigure(uuid);
    return true;
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

