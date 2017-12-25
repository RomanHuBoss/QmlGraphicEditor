#ifndef POINT_H
#define POINT_H
#include "geometry.h"
#include <QString>

/*
 2D-point class
 Author: Rabinovich R.M.
 You can use & modificate the following code without any restrictions
 Date: 10.11.2017
 */
class Point
{
public:
    Point();
    Point(double x, double y);
    Point(const Point& point);
    virtual ~Point();

    Point& operator=(const Point& point);
    Point& operator+=(const Point& point);
    Point& operator-=(const Point& point);
    Point& operator*=(double factor);
    operator QString() const;

    double x() const;
    double y() const;
    void setX(double x);
    void setY(double y);

    bool isValid() const;
    bool isSameX(const Point& point) const;
    bool isSameY(const Point& point) const;
    bool isLeftward(const Point& point) const;
    bool isRightward(const Point& point) const;
    bool isHigher(const Point& point) const;
    bool isBelow(const Point& point) const;

    //поворот точки вокруг другой точки на угол
    void rotateAroundPoint(const Point& central, const double& theta, AngleType type = RadiansType);
private:
    double _x;
    double _y;
};

const Point operator-(const Point& point1, const Point& point2);
const Point operator+(const Point& point1, const Point& point2);
const Point operator*(double factor, const Point& point);
const Point operator*(const Point& point, double factor);
bool operator==(const Point& point1, const Point& point2);
bool operator!=(const Point& point1, const Point& point2);

#endif // POINT_H
