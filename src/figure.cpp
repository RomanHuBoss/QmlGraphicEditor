#include "figure.h"
#include "point.h"
#include "linesegment.h"
#include "rectangle.h"
#include <QDebug>
#include <QJsonArray>

namespace RD = Rosdistant;
using namespace RD;

typedef double(Rectangle::*oppCoordGetter)() const;
typedef double(Rectangle::*sizeGetter)() const;
typedef double(Point::*pointCoordGetter)() const;
typedef void(Point::*pointCoordSetter)(double);

Q_DECLARE_METATYPE(oppCoordGetter);
Q_DECLARE_METATYPE(pointCoordGetter);
Q_DECLARE_METATYPE(pointCoordSetter);

Figure::Figure():_isFilled(false)
{

}

Figure::~Figure()
{

}

QUuid Figure::uuid() const
{
    return _uuid;
}

void Figure::setUuid(const QUuid &uuid)
{
    _uuid = uuid;
}

Rectangle Figure::getBBox() const
{
    if (!isValid()) {
        return Rectangle();
    }

    double minX = getMinX();
    double maxX = getMaxX();
    double minY = getMinY();
    double maxY = getMaxY();

    return Rectangle(Point(minX, maxY), Point(maxX, maxY),
                     Point(maxX, minY), Point(minX, minY));
}

void Figure::move(double dx, double dy)
{
    for (int i = 0; i < _points.size(); i++) {
        _points[i].setX(_points[i].x() + dx);
        _points[i].setY(_points[i].y() + dy);
    }
}

void Figure::rotateAroundPoint(const Point& point, const double& theta, AngleType type)
{
    for (int i = 0; i < _points.size(); i++) {
        _points[i].rotateAroundPoint(point, theta, type);
    }
}

void Figure::rotateAroundCenter(const double &theta, AngleType type)
{
    rotateAroundPoint(getCentralPoint(), theta, type);
}

void Figure::bbCornerScale(Figure::BBoxCorners corner, double xvalue, double yvalue)
{

}

void Figure::bbSideResize(BBoxSides side, double value)
{
    /*
     * описание алгоритма растягивания
     * выбирается конкретная сторона описывающего фигуру прямоугольника.
     * точки на противоположной стороне не смещаются.
     * остальные точки смещаются пропорционально удалению от противоположной стороны.
     */

    Rectangle bbox = getBBox();

    if (!bbox.isValid())
        return;
    else if (bbox.height() < DBL_EPSILON || bbox.width() < DBL_EPSILON)
        return;

    QHash<BBoxSides, QList<QVariant>> hashedCalls;

    QList<QVariant> funcs;
    funcs.push_back(QVariant::fromValue<oppCoordGetter>(&Rectangle::getMinY));
    funcs.push_back(QVariant::fromValue<sizeGetter>(&Rectangle::height));
    funcs.push_back(QVariant::fromValue<pointCoordGetter>(&Point::y));
    funcs.push_back(QVariant::fromValue<pointCoordSetter>(&Point::setY));
    hashedCalls.insert(BBoxTop, funcs);

    funcs.clear();
    funcs.push_back(QVariant::fromValue<oppCoordGetter>(&Rectangle::getMaxY));
    funcs.push_back(QVariant::fromValue<sizeGetter>(&Rectangle::height));
    funcs.push_back(QVariant::fromValue<pointCoordGetter>(&Point::y));
    funcs.push_back(QVariant::fromValue<pointCoordSetter>(&Point::setY));
    hashedCalls.insert(BBoxBottom, funcs);

    funcs.clear();
    funcs.push_back(QVariant::fromValue<oppCoordGetter>(&Rectangle::getMinX));
    funcs.push_back(QVariant::fromValue<sizeGetter>(&Rectangle::width));
    funcs.push_back(QVariant::fromValue<pointCoordGetter>(&Point::x));
    funcs.push_back(QVariant::fromValue<pointCoordSetter>(&Point::setX));
    hashedCalls.insert(BBoxRight, funcs);

    funcs.clear();
    funcs.push_back(QVariant::fromValue<oppCoordGetter>(&Rectangle::getMaxX));
    funcs.push_back(QVariant::fromValue<sizeGetter>(&Rectangle::width));
    funcs.push_back(QVariant::fromValue<pointCoordGetter>(&Point::x));
    funcs.push_back(QVariant::fromValue<pointCoordSetter>(&Point::setX));
    hashedCalls.insert(BBoxLeft, funcs);

    for (int i = 0; i < _points.size(); i++) {
        QList<QVariant> funcs = hashedCalls.value(side);

        oppCoordGetter      getOppCoord = funcs[0].value<oppCoordGetter>();
        sizeGetter          getSize = funcs[1].value<sizeGetter>();
        pointCoordGetter    getPointCoord = funcs[2].value<pointCoordGetter>();
        pointCoordSetter    setPointCoord = funcs[3].value<pointCoordSetter>();

        double distFromMargin = fabs((_points[i].*getPointCoord)() - (bbox.*getOppCoord)());
        double newCoord = (_points[i].*getPointCoord)() + (distFromMargin/(bbox.*getSize)())*value;
        (_points[i].*setPointCoord)(newCoord);
    }
}

bool Figure::isPointInside(const Point &point)
{
    return isPointInside(point.x(), point.y());
}

bool Figure::isPointInside(double x, double y)
{
    if (!isClosed() || _points.size() < 3)
        return false;

    //сравним напрямую с каждой из точек
    foreach (auto vertexPoint, _points)
        if (vertexPoint == Point(x, y))
            return true;

    double sum = 0.0;

    Point lastPt = lastPoint();
    lastPt.setX(lastPt.x() - x);
    lastPt.setY(lastPt.y() - y);

    for (int i = 0; i < _points.size()-1; i++) {
        Point curPt = _points[i];
        curPt.setX(curPt.x() - x);
        curPt.setY(curPt.y() - y);

        double del = lastPt.x()*curPt.y() - curPt.x()*lastPt.y();
        double xy  = curPt.x()*lastPt.x() + curPt.y()*lastPt.y();

        sum+= (
            atan((lastPt.x()*lastPt.x()+lastPt.y()*lastPt.y() - xy)/del) +
            atan((curPt.x()*curPt.x()+curPt.y()*curPt.y() - xy)/del)
        );

        lastPt=curPt;
    }

    return fabs(sum) > DBL_EPSILON;
}

LineSegment Figure::getSide(int i) const
{
    if (i > _points.size())
        return LineSegment();
    else if (i < _points.size()-1)
        return LineSegment(_points[i], _points[i+1]);
    else
        return LineSegment(_points[i], _points[0]);
}

void Figure::resetPoints()
{
    _points.clear();
}


const QList<Point>& Figure::getPoints() const
{
    return _points;
}

double Figure::getMinX() const
{
    double min = DBL_MAX;

    for (int i = 0; i < _points.size(); i++)
        if (min > _points[i].x()) min = _points[i].x();

    return min;
}

double Figure::getMaxX() const
{
    double max = DBL_MIN;

    for (int i = 0; i < _points.size(); i++)
        if (max < _points[i].x()) max = _points[i].x();

    return max;
}

double Figure::getMinY() const
{
    double min = DBL_MAX;

    for (int i = 0; i < _points.size(); i++)
        if (min > _points[i].y()) min = _points[i].y();

    return min;
}

double Figure::getMaxY() const
{
    double max = DBL_MIN;

    for (int i = 0; i < _points.size(); i++)
        if (max < _points[i].y()) max = _points[i].y();

    return max;
}

void Figure::insertFirstPoint(const Point& point) {
    _points.push_front(point);
}

void Figure::insertLastPoint(const Point& point) {
    _points.push_back(point);
}

bool Figure::replaceFirstPoint(const Point& point) {
    if (_points.isEmpty())
        return false;

    return replacePoint(0, point);
}

bool Figure::replaceLastPoint(const Point& point) {
    if (_points.isEmpty())
        return false;

    return replacePoint(_points.size()-1, point);
}

bool Figure::setPoints(const QList<Point>& points)
{
    if (points.isEmpty() || points.size() < necessaryPointsQuant())
        return false;

    _points = points;
    return true;
}

void Figure::setBgColor(const QColor &bgcolor)
{
    _bgcolor = bgcolor;
}

QColor Figure::bgColor() const
{
    return _bgcolor;
}

bool Figure::replacePoint(int idx, const Point& point) {
    if (_points.isEmpty() || idx >= _points.size())
        return false;

    _points[idx] = point;
    return true;
}

bool Figure::insertPointAfterPoint(const Point& after, const Point& point) {
    for (int i = 0; i < _points.size(); i++)
        if (_points[i] == after) {
            _points.insert(i + 1, point);
            return true;
        }

    return false;
}

bool Figure::hasPoint(const Point& point) const
{
    if (_points.isEmpty())
        return false;

    return _points.contains(point);
}

bool Figure::hasPoint(double x, double y) const
{
    return hasPoint(Point(x, y));
}

int Figure::pointIndex(const Point &point) const
{
    if (_points.isEmpty())
        return false;

    return _points.indexOf(point);
}

int Figure::pointIndex(double x, double y) const
{
    if (_points.isEmpty())
        return false;

    return _points.indexOf(Point(x, y));
}

Point Figure::firstPoint() const
{
    if (_points.isEmpty())
        return Point();

    return _points.first();
}

Point Figure::lastPoint() const
{
    if (_points.isEmpty())
        return Point();

    return _points.last();
}

Point Figure::pointByIndex(int idx) const
{
    if (_points.isEmpty() || idx >= _points.size())
        return Point();

    return _points[idx];
}

bool Figure::isValid() const
{
    if (_points.isEmpty())
        return false;
    else if (_points.size() < necessaryPointsQuant())
        return false;

    for (int i = 0; i < necessaryPointsQuant(); i++)
        if (!_points[i].isValid())
            return false;

    return true;
}

//сериализация объекта фигуры в JSON-объект и сохранение на диск
QJsonObject Figure::serialize() const
{
    QJsonObject json;

    if (!isValid())
        return json;

    //уникальный идентификатор фигуры
    json["uuid"] = _uuid.toString();

    //название класса фигуры
    json["figureClass"] = className();

    //признак замкнутой фигуры
    json["isClosed"] = isClosed();

    //признак заливки фоновым цветом
    json["isFilled"] = _isFilled;

    //признак фонового цвета
    json["bgColor"] = bgColor().name();

    //координаты вершин фигуры
    QJsonArray pointsArr;

    foreach (auto point, _points)  {
        QJsonObject pointCoords;
        pointCoords["x"] = point.x();
        pointCoords["y"] = point.y();
        pointsArr.append(pointCoords);
    }
    json["points"] = pointsArr;

    return json;
}

void Figure::setIsFilled(bool isFilled)
{
    _isFilled = isFilled;
}

bool Figure::isFilled() const
{
    return _isFilled;
}

QVariantMap Figure::toQML()
{
    QVariantMap map;

    QList<QVariant> fPoints;
    foreach (auto point, _points) {
        QStringList tmp = QStringList() << QString::number(point.x()) << QString::number(point.y());
        fPoints << tmp;
    }

    QList<QVariant> bbPoints;
    foreach (auto point, getBBox().getPoints()) {
        QStringList tmp = QStringList() << QString::number(point.x()) << QString::number(point.y());
        bbPoints << tmp;
    }

    map.insert("uid", _uuid);
    map.insert("type", className());
    map.insert("points", QVariant::fromValue(fPoints));
    map.insert("bbox", QVariant::fromValue(bbPoints));
    map.insert("isClosed", isClosed());
    map.insert("isFilled", isFilled());
    map.insert("filledColor", bgColor().name());

    return map;
}
