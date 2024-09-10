#include "figure.h"
#include "figuresstorage.h"
#include <QDateTime>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QDebug>
#include <QFile>
#include "linesegment.h"
#include "multiline.h"
#include "rectangle.h"
#include "square.h"
#include "triangle.h"

namespace RD = Rosdistant;
using namespace RD;

FiguresStorage::FiguresStorage()
{

}

FiguresStorage::~FiguresStorage()
{
    foreach (auto figure, _storage) {
        delete figure;
    }
}

void FiguresStorage::addFigure(const QUuid& uuid, Figure* figure) {
    if (figure->uuid() != uuid)
        figure->setUuid(uuid);

    _storage.insert(uuid, figure);
}

void FiguresStorage::addFigure(Figure* figure)
{
    QUuid uuid = figure->uuid();

    if (uuid.isNull()) {
        uuid = QUuid::createUuidV5(QUuid(), QDateTime::currentDateTime().toString());
        figure->setUuid(uuid);
    }

    _storage.insert(uuid, figure);
}

void FiguresStorage::removeFigure(const QUuid& uuid) {
    if (_storage.contains(uuid)) {
        delete _storage.value(uuid);
        _storage.remove(uuid);
    }
}

bool FiguresStorage::fillupFromFile(const QString &filePath)
{
    if (!QFile::exists(filePath))
        return false;

    QFile file(filePath);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return false;

    QJsonDocument doc = QJsonDocument().fromJson(file.readAll());

    if (doc.isEmpty())
        return false;

    //json-документ верхнего уровня = объект с UUID-ключами фигур сцены
    QJsonObject json = doc.object();

    if (json.isEmpty())
        return false;


    foreach (auto tmp, json) {
        if (tmp.isNull())
            continue;

        QJsonObject jsonFigure = tmp.toObject();

        QString figureClass = jsonFigure["figureClass"].toString();

        Figure * figure;

        if (figureClass == "LineSegment")
            figure = new LineSegment;
        else if (figureClass == "Triangle")
            figure = new Triangle;
        else if (figureClass == "Rectangle")
            figure = new Rectangle;
        else if (figureClass == "Square")
            figure = new Square;
        else if (figureClass == "Multiline")
            figure = new Multiline;
        else
            continue;

        if (!jsonFigure["uuid"].isNull())
            figure->setUuid(jsonFigure["uuid"].toString());

        if (!jsonFigure["isFilled"].isNull())
            figure->setIsFilled(jsonFigure["isFilled"].toBool());
        else
            figure->setIsFilled(false);

        if (!jsonFigure["bgColor"].isNull())
            figure->setBgColor(QColor(jsonFigure["bgColor"].toString()));
        else
            figure->setBgColor(QColor());

        if (figureClass == "Multiline")
            if (!jsonFigure["isClosed"].isNull())
                reinterpret_cast<Multiline*>(figure)->setIsClosed(jsonFigure["isClosed"].toBool());
            else
                reinterpret_cast<Multiline*>(figure)->setIsClosed(false);


        if (!jsonFigure["points"].isNull()) {
            QJsonArray points = jsonFigure["points"].toArray();

            if (!points.isEmpty()) {
                foreach (auto pointJsonValue, points) {
                    QJsonObject pointJson = pointJsonValue.toObject();

                    figure->insertLastPoint(Point(pointJson["x"].toDouble(), pointJson["y"].toDouble()));
                }
            }
        }

        addFigure(figure);
    }

    return true;
}

bool FiguresStorage::saveToFile(const QString &filePath) const
{
    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
            return false;

    QJsonObject json;

    foreach (auto figure, _storage) {
        QJsonObject tmp = figure->serialize();
        json[figure->uuid().toString()] = tmp;
    }

    if (json.isEmpty())
        return false;

    QJsonDocument doc(json);
    file.write(doc.toJson(QJsonDocument::Compact));

    file.close();

    return true;
}

QList<Figure *> FiguresStorage::figures()
{
    QList<Figure*> figures;

    foreach (auto figure, _storage)
        figures.append(figure);

    return figures;
}

int FiguresStorage::figuresQuant() const
{
    return _storage.size();
}

const QHash<QUuid, Figure*>& FiguresStorage::storage() const
{
    return _storage;
}

void FiguresStorage::setStorage(const QHash<QUuid, Figure*>& value)
{
    _storage = value;
}

void FiguresStorage::resetStorage()
{
    _storage.clear();
}

bool FiguresStorage::isEmpty() const
{
    return _storage.isEmpty();
}

Figure* FiguresStorage::getFigure(const QUuid& uuid) const
{
    return  (_storage.contains(uuid)) ? _storage.value(uuid) : nullptr;
}
