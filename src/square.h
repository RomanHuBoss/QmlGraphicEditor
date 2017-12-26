#ifndef SQUARE_H
#define SQUARE_H

#include <QString>
#include "rectangle.h"

namespace Rosdistant {
    class Point;

    /*
     Abstract 2D-square class
     Author: Rabinovich R.M.
     You can use & modificate the following code without any restrictions
     Date: 10.11.2017
     */

    class Square: public Rectangle
    {
    public:
        Square();
        Square(const Point& point1, const Point& point2, const Point& point3, const Point& point4);
        Square(const Point& point, double size);
        virtual ~Square();

        //строковое представление фигуры
        operator QString();

        //валидность фигуры
        bool isValid() const;

        //изменение размера за одну из сторон описывающего прямоугольника
        void bbSideResize(BBoxSides side, double value);

        //пропорциональное изменение размера за один из углов описывающего прямоугольника
        void bbCornerScale(BBoxCorners corner, double xvalue, double yvalue);
    };

}

#endif // SQUARE_H
