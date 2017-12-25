#ifndef LINESEGMENT_H
#define LINESEGMENT_H

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
    enum IntersectType {
        NoIntersection,        //нет пересечения
        Overlapping,           //один из отрезков лежит на другом
        Intersection,          //пересечение в одной точке
        Parallel               //лежат на параллельных прямых
    };

    LineSegment();
    LineSegment(const Point& point1_, const Point& point2_);
    LineSegment(const LineSegment& segment);
    LineSegment& operator=(const LineSegment& segment);
    virtual ~LineSegment();

    int getNecessaryPointsQuant() const;

    bool LineSegment::isParallelXAxis() const;
    bool LineSegment::isParallelYAxis() const;

    Point getCentralPoint() const;    
    void rotateAroundCenter(const double& theta, AngleType type = RadiansType);

    bool isValid() const;

    //проверка пересечения с другим отрезком
    IntersectType checkIntersection(const LineSegment& segment, Point& intersectionPoint = Point()) const;
    int necessaryPointsQuant() const;
};

bool operator==(const LineSegment& segment1, const LineSegment& segment2);

#endif // LINESEGMENT_H
