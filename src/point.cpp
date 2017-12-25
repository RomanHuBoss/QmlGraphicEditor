#include "point.h"

Point::Point(): _x(DBL_MAX), _y(DBL_MAX)
{

}

Point::Point(double x, double y): _x(x), _y(y)
{

}

Point::Point(const Point& point): _x(point.x()), _y(point.y())
{

}

Point& Point::operator=(const Point& point)
{
    if (&point == this)
        return *this;

    _x = point.x();
    _y = point.y();

    return *this;
}

Point &Point::operator+=(const Point& point)
{
    _x += point.x();
    _y += point.y();

    return *this;
}

Point& Point::operator-=(const Point& point)
{
    _x -= point.x();
    _y -= point.y();

    return *this;
}

Point& Point::operator*=(double factor)
{
    _x *= factor;
    _y *= factor;

    return *this;
}

Point::~Point()
{

}

double Point::x() const
{
    return _x;
}

double Point::y() const
{
    return _y;
}

void Point::setX(double x)
{
    _x = x;
}

void Point::setY(double y)
{
    _y = y;
}

bool Point::isValid() const
{
    return *this != Point();
}

bool Point::isSameX(const Point &point) const
{
    return _x == point.x();
}

bool Point::isSameY(const Point &point) const
{
    return _y == point.y();
}

bool Point::isHigher(const Point& point) const
{
    return _y > point.y();
}

bool Point::isBelow(const Point& point) const
{
    return _y < point.y();
}

bool Point::isLeftward(const Point& point) const
{
    return _x < point.x();
}

bool Point::isRightward(const Point& point) const
{
    return _x > point.x();
}

void Point::rotateAroundPoint(const Point& central, const double& theta, AngleType type) {
    double angleInRadians;

    if (type == DegreesType)
        angleInRadians = theta * (M_PI / 180);

    double cosTheta = cos(angleInRadians);
    double sinTheta = sin(angleInRadians);

    double newX = cosTheta * (_x - central.x()) -
                  sinTheta * (_y - central.y()) + central.x();

    double newY = sinTheta * (_x - central.x()) +
                  cosTheta * (_y - central.y()) + central.y();

    _x = newX;
    _y = newY;
}

const Point operator-(const Point& point1, const Point &point2)
{
    return Point(point1.x() - point2.x(), point1.y() - point2.y());
}

const Point operator+(const Point& point1, const Point& point2) {
    return Point(point1.x() + point2.x(), point1.y() + point2.y());
}

const Point operator*(double factor, const Point& point)
{
    return Point(point.x()*factor, point.y()*factor);
}

const Point operator*(const Point& point, double factor)
{
    return factor*point;
}

bool operator==(const Point& point1, const Point& point2)
{
    return (point1.x() == point2.x()) && (point1.y() == point2.y());
}

bool operator!=(const Point &point1, const Point &point2)
{
    return !(point1 == point2);
}