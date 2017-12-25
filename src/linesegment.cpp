#include "linesegment.h"
#include "math.h"
#include "qnumeric.h"

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

LineSegment::operator QString() const
{
    return "LineSegment(" + firstPoint() + ";" + lastPoint() + ")";
}

LineSegment::~LineSegment()
{

}

int LineSegment::necessaryPointsQuant() const
{
    return 2;
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

    if (abs(denom) <= DBL_EPSILON) {
        if (abs(nume_a) <= DBL_EPSILON && abs(nume_b) <= DBL_EPSILON) {
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


bool operator==(const LineSegment& segment1, const LineSegment& segment2)
{
    return (segment1.firstPoint() == segment2.firstPoint() && segment1.lastPoint() == segment2.lastPoint()) ||
           (segment1.firstPoint() == segment2.lastPoint() && segment1.lastPoint() == segment2.firstPoint());
}
