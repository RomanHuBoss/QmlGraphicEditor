#ifndef POINT_H
#define POINT_H
#include "geometry.h"

/*
 2D-point class
 Author: Rabinovich R.M.
 You can use & modificate the following code without any restrictions
 Date: 10.11.2017
 */
class Point
{
public:


    Point(double x_, double y_);
    Point(const Point& point);
    virtual ~Point();

    Point& operator=(const Point& point);
    Point& operator+=(const Point& point);
    Point& operator-=(const Point& point);
    Point& operator*=(double factor);

    double getX() const;
    double getY() const;
    void setX(double x_);
    void setY(double y_);

    //поворот точки вокруг другой точки на угол
    void rotateAroundPoint(const Point& point, const double& theta, AngleType type = RadiansType);
private:
    double x;
    double y;
};

const Point operator-(const Point& point1, const Point& point2);
const Point operator+(const Point& point1, const Point& point2);
const Point operator*(double factor, const Point& point);
const Point operator*(const Point& point, double factor);
bool operator==(const Point& point1, const Point& point2);

#endif // POINT_H
