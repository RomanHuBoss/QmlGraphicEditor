#include "math.h"
#include "qnumeric.h"
#include "point.h"
#include "triangle.h"
#include "linesegment.h"

namespace RD = Rosdistant;
using namespace RD;

Triangle::Triangle()
{
}

Triangle::Triangle(const Point& point1, const Point& point2, const Point& point3)
{
    insertLastPoint(point1);
    insertLastPoint(point2);
    insertLastPoint(point3);
}

Triangle::~Triangle()
{

}

QString Triangle::toString() const
{
    return QString("Triangle(%1; %2; %3)").
            arg(firstSide().toString(), secondSide().toString(), thirdSide().toString());
}

int Triangle::necessaryPointsQuant() const
{
    return 3;
}

Point Triangle::getCentralPoint() const
{
    return Point((pointByIndex(0).x() + pointByIndex(1).x() + pointByIndex(2).x())/3,
                 (pointByIndex(0).y() + pointByIndex(1).y() + pointByIndex(2).y())/3);
}

bool Triangle::isClosed() const
{
    return true;
}

bool Triangle::isValid() const
{
    if (!Figure::isValid())
        return false;

    return ((thirdSide().length()  - (firstSide().length() + secondSide().length())) < 0) &&
           ((secondSide().length() - (firstSide().length() + thirdSide().length())) <  0) &&
            ((firstSide().length()  - (secondSide().length() + thirdSide().length())) < 0);
}

LineSegment Triangle::firstSide() const
{
    return getSide(0);
}

LineSegment Triangle::secondSide() const
{
    return getSide(1);
}

LineSegment Triangle::thirdSide() const
{
    return getSide(2);
}
