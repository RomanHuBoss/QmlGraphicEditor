#ifndef FIGURE_H
#define FIGURE_H

#include "geometry.h"
#include "point.h"

/*
 Abstract 2D-figure class
 Author: Rabinovich R.M.
 You can use & modificate the following code without any restrictions
 Date: 10.11.2017
 */
class Figure
{
public:
    explicit Figure(bool isClosed_);
    virtual ~Figure();

    //вычисляем координаты центральной точки
    virtual Point getCentralPoint() const = 0;

    //вращение фигуры вокруг точки на угол
    virtual void rotateAroundPoint(const Point &point, const double &theta, AngleType type = RadiansType) = 0;

    //вращение фигуры вокруг геометрического центра
    virtual void rotateAroundCenter(const double& theta, AngleType type = RadiansType) = 0;

    //замкнутая ли фигура
    bool getIsClosed() const;

private:
    bool isClosed;
};

#endif // FIGURE_H
