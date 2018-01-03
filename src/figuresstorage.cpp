#include "figure.h"
#include "figuresstorage.h"
#include <QDateTime>
#include <QJsonObject>
#include <QJsonDocument>

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

QString FiguresStorage::toJson() const {
    return QString();
}

bool FiguresStorage::fillupFromFile(const QString &filePath)
{
    if (!QFile::exists(filePath))
        return false;



    return true;
}

bool FiguresStorage::saveToFile(const QString &fileName) const
{
    QFile file(fileName);
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
    return _storage.value(uuid);
}
