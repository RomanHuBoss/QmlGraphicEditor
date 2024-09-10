#include <QQmlApplicationEngine>
#include "qtqmlinteractor.h"
#include "figuresstorage.h"
#include <QFile>
#include <QDebug>
#include <QQmlContext>
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

    if (figure == nullptr) {
        emit raiseAlertifyError("Запрашиваемая фигура не найдена");
        return false;
    }

    figure->rotateAroundCenter(angle, AngleType::DegreesType);

    emit raiseDrawFigureOnScene(figure->toQML());

    return true;
}

bool QtQmlInteractor::onFillQmlFigure(const QString &uuid, const QString &color)
{
    Figure * figure = _storage.getFigure(uuid);

    if (figure == nullptr) {
        emit raiseAlertifyError("Запрашиваемая фигура не найдена");
        return false;
    }

    figure->setIsFilled(true);
    figure->setBgColor(color);

    emit raiseDrawFigureOnScene(figure->toQML());

    return true;
}

bool QtQmlInteractor::onMoveQmlFigure(const QString &uuid, double dx, double dy)
{
    Figure * figure = _storage.getFigure(uuid);

    if (figure == nullptr) {
        emit raiseAlertifyError("Запрашиваемая фигура не найдена");
        return false;
    }

    figure->move(dx, dy);
    emit raiseDrawFigureOnScene(figure->toQML());
    return true;
}

bool QtQmlInteractor::onRemoveQmlFigure(const QString &uuid)
{
    if (_storage.getFigure(uuid) == nullptr) {
        emit raiseAlertifyError("Запрашиваемая фигура не найдена");
        return false;
    }

    _storage.removeFigure(uuid);
    return true;
}

int QtQmlInteractor::figuresQuant() const
{
    return _storage.figuresQuant();
}

void QtQmlInteractor::onNewScene()
{
    foreach (auto figure,_storage.figures()) {
        emit raiseRemoveQmlFigure(figure->uuid().toString());
    }

    emit raiseAlertifyInfo("Создана новая сцена");
}

bool QtQmlInteractor::onSaveScene(const QUrl& fileUrl) {
    if (_storage.isEmpty()) {
        emit raiseAlertifyError("Невозможно сохранить пустую сцену");
        return false;
    }

    QString filePath = fileUrl.toLocalFile();

    _storage.saveToFile(filePath);

    emit raiseAlertifyInfo("Сцена успешно сохранена");

    return true;
}

void QtQmlInteractor::onSelectSceneFile(const QUrl& fileUrl)
{
    QString filePath = fileUrl.toLocalFile();

    onNewScene();

    if (!QFile(filePath).exists()) {
        emit raiseAlertifyError("Выбранный файл не существует");
    }
    else if (!QFile(filePath).size()) {
        emit raiseAlertifyError("Выбран пустой файл файл");
    }
    else if (!_storage.fillupFromFile(filePath)) {
        emit raiseAlertifyError("Не удалось загрузить файл");
    }

    foreach (auto figure,_storage.figures()) {
        emit raiseDrawFigureOnScene(figure->toQML());
    }

    emit raiseAlertifyInfo("Сцена успешно загружена");
}


bool QtQmlInteractor::onResizeQmlFigure(const QString& uuid, double scaleLeft, double scaleRight, double scaleTop, double scaleBottom, double offsetLeft, double offsetTop) {
    Figure * figure = _storage.getFigure(uuid);


    if (scaleLeft) {
        figure->bbSideResize(Figure::BBoxLeft, scaleLeft);
    }
    if (scaleRight) {
        figure->bbSideResize(Figure::BBoxRight, scaleRight);
    }
    if (scaleTop) {
        figure->bbSideResize(Figure::BBoxTop, scaleTop);
    }
    if (scaleBottom) {
        double dx = offsetLeft - figure->getMinX();
        double dy = offsetTop - figure->getMinY();

        figure->bbSideResize(Figure::BBoxTop, scaleBottom);
        figure->move(dx, dy);
    }

    emit raiseDrawFigureOnScene(figure->toQML());

    return true;
}

