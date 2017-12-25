#ifndef RECTANGLE_H
#define RECTANGLE_H

#include "linesegment.h"

class Rectangle: public Figure
{
public:
    Rectangle(const Point& topLeftPoint, const Point& botRightPoint);
    Rectangle(const Point& topLeftPoint, double vertSize, double horSize);
    ~Rectangle();
private:
    QList<Point> points;
};

#endif // RECTANGLE_H
