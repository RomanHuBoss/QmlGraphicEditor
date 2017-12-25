#include "linesegment.h"
#include "math.h"
#include "qnumeric.h"

LineSegment::LineSegment(const Point& point1_, const Point& point2_):
    Figure(false), point1(point1_), point2(point2_)
{

}

LineSegment::LineSegment(const LineSegment& segment):
    Figure(false), point1(segment.getPoint1()), point2(segment.point2)
{

}

LineSegment& LineSegment::operator=(const LineSegment& segment)
{
    if (&segment == this)
        return *this;

    point1 = segment.getPoint1();
    point2 = segment.getPoint2();

    return *this;
}

LineSegment::~LineSegment()
{

}

const Point& LineSegment::getPoint1() const
{
    return point1;
}

const Point& LineSegment::getPoint2() const
{
    return point2;
}

void LineSegment::setPoint1(const Point& point)
{
    point1 = point;
}

void LineSegment::setPoint2(const Point& point)
{
    point2 = point;
}

Point LineSegment::getCentralPoint() const
{
    return Point((point1.getX() + point2.getX()) * 0.5,
                 (point1.getY() + point2.getY()) * 0.5);
}

void LineSegment::rotateAroundPoint(const Point& point, const double& theta, AngleType type)
{
    point1.rotateAroundPoint(point, theta, type);
    point2.rotateAroundPoint(point, theta, type);
}

void LineSegment::rotateAroundCenter(const double& theta, AngleType type)
{
    rotateAroundPoint(getCentralPoint(), theta, type);
}

LineSegment::IntersectType LineSegment::checkIntersection(const LineSegment& segment, Point& intersectionPoint) const
{
    //тот же самый отрезок
    if (&segment == this)
        return UnboundedIntersection;
    //аналогичный отрезок
    else if (*this == segment)
        return UnboundedIntersection;


    const Point a = point2 - point1;
    const Point b = segment.getPoint1() - segment.getPoint2();
    const Point c = point1 - segment.getPoint1();

    const double denominator = a.getY() * b.getX() - a.getX() * b.getY();

    //параллельные отрезки
    if (denominator == 0 || !qIsFinite(denominator))
        return NoIntersection;

    const double reciprocal = 1 / denominator;
    const double na = (b.getY() * c.getX() - b.getX() * c.getY()) * reciprocal;

    intersectionPoint = point1 + a * na;

    //отрезки лежат на одной прямой и пересекаются
    if (na < 0 || na > 1)
        return UnboundedIntersection;

    const double nb = (a.getX() * c.getY() - a.getY() * c.getX()) * reciprocal;

    //отрезки лежат на одной прямой и пересекаются
    if (nb < 0 || nb > 1)
        return UnboundedIntersection;

    return BoundedIntersection;
}


bool operator==(const LineSegment& segment1, const LineSegment& segment2)
{
    return (segment1.getPoint1() == segment2.getPoint1() && segment1.getPoint2() == segment2.getPoint2()) ||
           (segment1.getPoint1() == segment2.getPoint2() && segment1.getPoint2() == segment2.getPoint1());
}
