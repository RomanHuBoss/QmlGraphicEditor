#ifndef TRIANGLE_H
#define TRIANGLE_H

#include "figure.h"

namespace Rosdistant {
    class Point;
    class LineSegment;

    /*
     Abstract 2D-triangle class
     Author: Rabinovich R.M.
     You can use & modificate the following code without any restrictions
     Date: 10.11.2017
     */

    class Triangle: public Figure
    {
    public:
        Triangle();
        Triangle(const Point& point1, const Point& point2, const Point& point3);
        virtual ~Triangle();

        //строковое представление фигуры
        operator QString();

        //получить необходимое число точек, формирующих фигуру заданного типа
        int necessaryPointsQuant() const;

        //вычисляем координаты центральной точки
        Point getCentralPoint() const;

        //замкнутая ли фигура
        bool isClosed() const;

        //валидность фигуры
        bool isValid() const;

        //изменение размера за одну из сторон описывающего прямоугольника
        void bbSideResize(BBoxSides side, double value);

        //пропорциональное изменение размера за один из углов описывающего прямоугольника
        void bbCornerScale(BBoxCorners corner, double xvalue, double yvalue);

        LineSegment firstSide() const;
        LineSegment secondSide() const;
        LineSegment thirdSide() const;

    };

}

#endif // TRIANGLE_H