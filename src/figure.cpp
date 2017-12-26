#include "figure.h"
#include "point.h"
#include "linesegment.h"

namespace RD = Rosdistant;
using namespace RD;

Figure::Figure()
{

}

Figure::~Figure()
{

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
