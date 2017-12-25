#include "point.h"

Point::Point(double x_, double y_): x(x_), y(y_)
{

}

Point::Point(const Point &point): x(point.getX()), y(point.getY())
{

}

Point& Point::operator=(const Point& point)
{
    if (&point == this)
        return *this;

    x = point.getX();
    y = point.getY();

    return *this;
}

Point &Point::operator+=(const Point &point)
{
    x += point.getX();
    y += point.getY();

    return *this;
}

Point& Point::operator-=(const Point &point)
{
    x -= point.getX();
    y -= point.getY();

    return *this;
}

Point& Point::operator*=(double factor)
{
    x *= factor;
    y *= factor;

    return *this;
}

Point::~Point()
{

}

double Point::getX() const
{
    return x;
}

double Point::getY() const
{
    return y;
}

void Point::setX(double x_)
{
    x = x_;
}

void Point::setY(double y_)
{
    y = y_;
}

void Point::rotateAroundPoint(const Point& point, const double& theta, AngleType type)
{
    double angleInRadians;

    if (type == DegreesType)
        angleInRadians = theta * (M_PI / 180);

    double cosTheta = cos(angleInRadians);
    double sinTheta = sin(angleInRadians);

    double newX = cosTheta * (x - point.getX()) -
                  sinTheta * (y - point.getY()) + point.getX();

    double newY = sinTheta * (x - point.getX()) +
                  cosTheta * (y - point.getY()) + point.getY();

    x = newX;
    y = newY;
}

const Point operator-(const Point& point1, const Point &point2)
{
    return Point(point1.getX() - point2.getX(), point1.getY() - point2.getY());
}

const Point operator+(const Point& point1, const Point& point2) {
    return Point(point1.getX() + point2.getX(), point1.getY() + point2.getY());
}

const Point operator*(double factor, const Point& point)
{
    return Point(point.getX()*factor, point.getY()*factor);
}

const Point operator*(const Point& point, double factor)
{
    return factor*point;
}

bool operator==(const Point& point1, const Point& point2)
{
    return (point1.getX() == point2.getX()) && (point1.getY() == point2.getY());
}
