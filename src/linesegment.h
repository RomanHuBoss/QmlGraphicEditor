#ifndef LINESEGMENT_H
#define LINESEGMENT_H

#include <cfloat>
#include "figure.h"
#include "point.h"

/*
 2D-line segment class
 Author: Rabinovich R.M.
 You can use & modificate the following code without any restrictions
 Date: 10.11.2017
 */
class LineSegment: public Figure
{
public:
    enum IntersectType { NoIntersection,        //нет пересечения
                         UnboundedIntersection, //отрезок лежит на той же прямой
                         BoundedIntersection    //пересечение в одной точке
    };

    LineSegment(const Point& point1_, const Point& point2_);
    LineSegment(const LineSegment& segment);
    LineSegment& operator=(const LineSegment& segment);
    virtual ~LineSegment();

    const Point& getPoint1() const;
    const Point& getPoint2() const;
    void setPoint1(const Point& point);
    void setPoint2(const Point& point);

    Point getCentralPoint() const;
    void rotateAroundPoint(const Point &point, const double &theta, AngleType type = RadiansType);
    void rotateAroundCenter(const double& theta, AngleType type = RadiansType);

    //проверка пересечения с другим отрезком
    IntersectType checkIntersection(const LineSegment& segment, Point& intersectionPoint = Point(DBL_MAX, DBL_MAX)) const;

private:
    Point point1;
    Point point2;
};

bool operator==(const LineSegment& segment1, const LineSegment& segment2);

#endif // LINESEGMENT_H
