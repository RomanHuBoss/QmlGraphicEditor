#ifndef RECTANGLE_H
#define RECTANGLE_H

#include <QString>
#include "figure.h"

namespace Rosdistant {
    class Point;
    class LineSegment;

    /*
     Abstract 2D-rectangle class
     Author: Rabinovich R.M.
     You can use & modificate the following code without any restrictions
     Date: 10.11.2017
     */
    class Rectangle: public Figure
    {
    public:
        Rectangle();
        Rectangle(const Point& point1, const Point& point2, const Point& point3, const Point& point4);
        Rectangle(const Point& point1, const Point& point2);
        Rectangle(const Point& point, double width, double height);
        virtual ~Rectangle();

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

        //размеры прямоугольника
        double width() const;
        double height() const;

        //проверка равенства диагоналей
        bool checkDiagonslsEquality() const;

        //точки прямоугольника
        Point topLeftPoint() const;
        Point topRightPoint() const;
        Point bottomLeftPoint() const;
        Point bottomRightPoint() const;

        //стороны прямоугольника
        LineSegment topSide() const;
        LineSegment rightSide() const;
        LineSegment bottomSide() const;
        LineSegment leftSide() const;
    };

}

#endif // RECTANGLE_H
