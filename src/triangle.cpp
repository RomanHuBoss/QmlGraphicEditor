#include "triangle.h"
#include "math.h"
#include "qnumeric.h"

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

int Triangle::necessaryPointsQuant() const
{
    return 3;
}

Point Triangle::getCentralPoint() const
{
    return Point(
        (pointByIndex(0).x() + pointByIndex(1).x() + pointByIndex(2).x())/3,
        (pointByIndex(0).y() + pointByIndex(1).y() + pointByIndex(2).y())/3
    );
}

bool Triangle::isValid() const
{
    if (!Figure::isValid())
        return false;

    /*

    return ((thirdSide - (firstSide + secondSide)) < DBL_EPSILON) &&
           ((secondSide - (firstSide + thirdSide)) < DBL_EPSILON) &&
           ((firstSide - (secondSide + thirdSide)) < DBL_EPSILON);
           */
    return false;
}
