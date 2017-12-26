#include "point.h"
#include "linesegment.h"
#include "square.h"

namespace RD = Rosdistant;
using namespace RD;

Square::Square()
{

}

Square::Square(const Point &point1, const Point &point2, const Point &point3, const Point &point4)
    :Rectangle(point1, point2, point3, point4)
{
}

Square::Square(const Point& point, double size)
    :Rectangle(point, size, size)
{
}

Square::~Square()
{

}

QString Square::toString() const
{
    return QString("Square(%1; %2; %3; %4)").
            arg(topSide().toString(), rightSide().toString(),
                bottomSide().toString(), leftSide().toString());
}

bool Square::isValid() const
{
    if (!Rectangle::isValid())
        return false;

    return topSide().length() == leftSide().length();
}
