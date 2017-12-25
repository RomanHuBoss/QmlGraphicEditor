#ifndef TRIANGLE_H
#define TRIANGLE_H

#include "figure.h"

class Triangle: public Figure
{
public:
    Triangle();
    Triangle(const Point& point1, const Point& point2, const Point& point3);

    virtual ~Triangle();

    //получить необходимое число точек, формирующих фигуру заданного типа
    int necessaryPointsQuant() const;

    //вычисляем координаты центральной точки
    Point getCentralPoint() const;

    //валидность фигуры определяется числом точек, соответствующих ее типу и значениями самих точек
    bool isValid() const;
};

#endif // TRIANGLE_H
