#include "math.h"
#include "qnumeric.h"
#include "point.h"
#include "linesegment.h"

namespace RD = Rosdistant;
using namespace RD;

LineSegment::LineSegment()
{
}

LineSegment::LineSegment(const Point& point1, const Point& point2)
{
    insertFirstPoint(point1);
    insertLastPoint(point2);
}

LineSegment::LineSegment(const LineSegment& segment)
{
    insertFirstPoint(segment.firstPoint());
    insertFirstPoint(segment.lastPoint());
}

LineSegment& LineSegment::operator=(const LineSegment& segment)
{
    if (&segment == this)
        return *this;

    resetPoints();
    insertFirstPoint(segment.firstPoint());
    insertLastPoint(segment.firstPoint());

    return *this;
}

bool LineSegment::operator==(const LineSegment& segment) const
{
    return (firstPoint() == segment.firstPoint() && lastPoint() == segment.lastPoint()) ||
            (firstPoint() == segment.lastPoint() && lastPoint() == segment.firstPoint());
}

bool LineSegment::operator!=(const LineSegment &segment) const
{
    return !(*this == segment);
}

int LineSegment::getNecessaryPointsQuant() const
{
    return 2;
}

LineSegment::operator QString()
{
    return QString("LineSegment(%1;%2)").
            arg(firstPoint(), lastPoint());
}

LineSegment::~LineSegment()
{

}

bool LineSegment::isClosed() const
{
    return false;
}

int LineSegment::necessaryPointsQuant() const
{
    return 2;
}

void LineSegment::bbSideResize(BBoxSides side, double value)
{

}

void LineSegment::bbCornerScale(BBoxCorners corner, double xvalue, double yvalue)
{

}

Point LineSegment::getCentralPoint() const
{
    return Point((firstPoint().x() + lastPoint().x()) * 0.5,
                 (firstPoint().y() + lastPoint().y()) * 0.5);
}

bool LineSegment::isValid() const
{
    if (!Figure::isValid())
        return false;

    return firstPoint() != lastPoint();
}

double LineSegment::length() const
{
    return pow(pow(lastPoint().x() - firstPoint().x(), 2) +
               pow(lastPoint().y() - firstPoint().y(), 2), 0.5);
}

double LineSegment::minX() const
{
    return fmin(firstPoint().x(), lastPoint().x());
}

double LineSegment::maxX() const
{
    return fmax(firstPoint().x(), lastPoint().x());
}

double LineSegment::minY() const
{
    return fmin(firstPoint().y(), lastPoint().y());
}

double LineSegment::maxY() const
{
    return fmax(firstPoint().y(), lastPoint().y());
}

bool LineSegment::isParallelXAxis() const
{
    return firstPoint().y() == lastPoint().y();
}

bool LineSegment::isParallelYAxis() const
{
    return firstPoint().x() == lastPoint().x();
}


LineSegment::IntersectType LineSegment::checkIntersection(const LineSegment& segment, Point& intersectionPoint) const
{
    intersectionPoint = Point();

    if (&segment == this)
        return Overlapping;
    else if (*this == segment)
        return Overlapping;

    double denom = ((segment.lastPoint().y() - segment.firstPoint().y())*(lastPoint().x() - firstPoint().x())) -
                  ((segment.lastPoint().x() - segment.firstPoint().x())*(lastPoint().y() - firstPoint().y()));

    double nume_a = ((segment.lastPoint().x() - segment.firstPoint().x())*(firstPoint().y() - segment.firstPoint().y())) -
                   ((segment.lastPoint().y() - segment.firstPoint().y())*(firstPoint().x() - segment.firstPoint().x()));

    double nume_b = ((lastPoint().x() - firstPoint().x())*(firstPoint().y() - segment.firstPoint().y())) -
                    ((lastPoint().y() - firstPoint().y())*(firstPoint().x() - segment.firstPoint().x()));

    if (fabs(denom) <= DBL_EPSILON) {
        if (fabs(nume_a) <= DBL_EPSILON && fabs(nume_b) <= DBL_EPSILON) {
            return Overlapping;
        }
        return Parallel;
    }

    double ua = nume_a / denom;
    double ub = nume_b / denom;

    if (ua >= 0.0 && ua <= 1.0 && ub >= 0.0 && ub <= 1.0) {
        // получаем точку пересечения
        intersectionPoint = Point(firstPoint().x() + ua*(lastPoint().x() - firstPoint().x()),
                                  firstPoint().y() + ua*(lastPoint().y() - firstPoint().y()));
        return Intersection;
    }
    return NoIntersection;
}
