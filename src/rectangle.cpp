#include "point.h"
#include "linesegment.h"
#include "rectangle.h"

namespace RD = Rosdistant;
using namespace RD;

Rectangle::Rectangle()
{

}

Rectangle::Rectangle(const Point& point1, const Point& point2, const Point& point3, const Point& point4)
{
    insertLastPoint(point1);
    insertLastPoint(point2);
    insertLastPoint(point3);
    insertLastPoint(point4);
}

Rectangle::Rectangle(const Point& point1, const Point& point2)
{
    insertLastPoint(point1);
    insertLastPoint(Point(point2.x(), point1.y()));
    insertLastPoint(point2);
    insertLastPoint(Point(point1.x(), point2.y()));
}

Rectangle::Rectangle(const Point& point, double width, double height)
{
    insertLastPoint(point);
    insertLastPoint(Point(point.x()+width, point.y()));
    insertLastPoint(Point(point.x()+width, point.y()+height));
    insertLastPoint(Point(point.x(), point.y()+height));
}

Rectangle::~Rectangle()
{

}

Rectangle::operator QString()
{
    return QString("Rectangle(%1; %2; %3; %4)").
            arg(topSide(), rightSide(),
                bottomSide(), leftSide());
}

int Rectangle::necessaryPointsQuant() const
{
    return 4;
}


bool Rectangle::isClosed() const
{
    return true;
}

bool Rectangle::isValid() const
{
    if (!Figure::isValid())
        return false;

    return topSide().length() == bottomSide().length() &&
            leftSide().length() == rightSide().length() &&
            checkDiagonslsEquality();
}

double Rectangle::width() const
{
    return fabs(getMaxX() - getMinX());
}

double Rectangle::height() const
{
    return fabs(getMaxY() - getMinY());
}

bool Rectangle::checkDiagonslsEquality() const
{
    LineSegment diagonal1(topLeftPoint(), bottomRightPoint());
    LineSegment diagonal2(bottomLeftPoint(), topRightPoint());

    return (diagonal1.length() - diagonal2.length()) < DBL_EPSILON;
}

Point Rectangle::topLeftPoint() const
{
    return topSide().firstPoint();
}

Point Rectangle::topRightPoint() const
{
    return topSide().lastPoint();
}

Point Rectangle::bottomLeftPoint() const
{
    return bottomSide().lastPoint();
}

Point Rectangle::bottomRightPoint() const
{
    return bottomSide().firstPoint();
}

LineSegment Rectangle::topSide() const
{
    return getSide(0);
}

LineSegment Rectangle::rightSide() const
{
    return getSide(1);
}

LineSegment Rectangle::bottomSide() const
{
    return getSide(2);
}

LineSegment Rectangle::leftSide() const
{
    return getSide(3);
}

QString Rectangle::className() const
{
    return "Rectangle";
}
