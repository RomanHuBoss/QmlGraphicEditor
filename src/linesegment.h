#ifndef LINESEGMENT_H
#define LINESEGMENT_H

#include <QString>
#include "figure.h"
#include "point.h"

namespace Rosdistant {

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
        virtual ~LineSegment();

        LineSegment& operator=(const LineSegment& segment);

        bool operator==(const LineSegment& segment) const;
        bool operator!=(const LineSegment& segment) const;

        //строковое представление фигуры
        operator QString();

        //получить необходимое число точек, формирующих фигуру заданного типа
        int getNecessaryPointsQuant() const;

        //праллельность отрезка оси OX
        bool isParallelXAxis() const;

        //параллельность отрезка оси OY
        bool isParallelYAxis() const;

        //замкнутая ли фигура
        bool isClosed() const;

        //валидность фигуры
        bool isValid() const;

        //длина отрезка
        double length() const;

        //получить минимальные и максимальное значение координат
        double minX() const;
        double maxX() const;
        double minY() const;
        double maxY() const;

        //проверка пересечения с другим отрезком
        IntersectType checkIntersection(const LineSegment& segment, Point& intersectionPoint) const;

        //число точек, необходимое для построения отрезка
        int necessaryPointsQuant() const;

        //изменение размера за одну из сторон описывающего прямоугольника
        void bbSideResize(BBoxSides side, double value);

        //пропорциональное изменение размера за один из углов описывающего прямоугольника
        void bbCornerScale(BBoxCorners corner, double xvalue, double yvalue);

        //возвраащет название класса
        QString className() const;
    };
}

#endif // LINESEGMENT_H
