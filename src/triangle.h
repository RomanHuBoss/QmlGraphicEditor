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

        //замкнутая ли фигура
        bool isClosed() const;

        //валидность фигуры
        bool isValid() const;

        LineSegment firstSide() const;
        LineSegment secondSide() const;
        LineSegment thirdSide() const;

        //возвраащет название класса
        QString className() const;

    };

}

#endif // TRIANGLE_H
