#ifndef FIGURE_H
#define FIGURE_H

#include "geometry.h"
#include "point.h"
#include <QList>

/*
 Abstract 2D-figure class
 Author: Rabinovich R.M.
 You can use & modificate the following code without any restrictions
 Date: 10.11.2017
 */
class Figure
{
public:
    explicit Figure();
    virtual ~Figure();

    //получить необходимое число точек, формирующих фигуру заданного типа
    virtual int necessaryPointsQuant() const = 0;

    //вычисляем координаты центральной точки
    virtual Point getCentralPoint() const = 0;

    //вращение фигуры вокруг точки на угол
    void rotateAroundPoint(const Point& point, const double& theta, AngleType type = RadiansType);

    //вращение фигуры вокруг геометрического центра
    virtual void rotateAroundCenter(const double& theta, AngleType type = RadiansType) = 0;

    //валидность фигуры определяется числом точек, соответствующих ее типу и значениями самих точек
    virtual bool isValid() const;

    //замкнутая ли фигура
    bool isClosed() const;

    Point firstPoint() const;
    Point lastPoint() const;
    Point pointByIndex(int idx) const;
    bool hasPoint(const Point& point) const;
    bool hasPoint(double x, double y) const;
    int pointIndex(const Point& point) const;
    int pointIndex(double x, double y) const;

    void resetPoints();
    const QList<Point>& getPoints() const;
    void insertFirstPoint(const Point& point);
    void insertLastPoint(const Point& point);
    bool insertPointAfterPoint(const Point& searching, const Point& inserting);
    bool replacePoint(int idx, const Point& point);
    bool replaceFirstPoint(const Point& point);
    bool replaceLastPoint(const Point& point);
    bool setPoints(const QList<Point>& points);

private:
    //хранилище точек
    QList<Point> _points;
};

#endif // FIGURE_H
