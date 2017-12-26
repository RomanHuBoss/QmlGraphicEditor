#ifndef FIGURE_H
#define FIGURE_H

#include <QList>
#include <QString>
#include "geometry.h"

namespace Rosdistant {
    class Point;
    class LineSegment;

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

        //стороны прямоугольника, в который вписывается фигура
        enum BBoxSides {BBoxTop, BBoxRight, BBoxBottom, BBoxLeft};

        //углы прямоугольника, в который вписывается фигура
        enum BBoxCorners {BBoxTopLeft, BBoxTopRight, BBoxBottomLeft, BBoxBottomRight};

        //строковое представление фигуры
        virtual operator QString() = 0;

        //получить необходимое число точек, формирующих фигуру заданного типа
        virtual int necessaryPointsQuant() const = 0;

        //вычисляем координаты центральной точки
        virtual Point getCentralPoint() const = 0;

        //перемещение фигуры на заданные величины по X и Y
        void move(double dx, double dy);

        //вращение фигуры вокруг точки на угол
        void rotateAroundPoint(const Point& point, const double& theta, AngleType type = RadiansType);

        //вращение фигуры вокруг геометрического центра
        void rotateAroundCenter(const double& theta, AngleType type = RadiansType);

        //пропорциональное изменение размера за один из углов описывающего прямоугольника
        virtual void bbCornerScale(BBoxCorners corner, double xvalue, double yvalue) = 0;

        //изменение размера за одну из сторон описывающего прямоугольника
        virtual void bbSideResize(BBoxSides side, double value) = 0;

        //точка внутри замкнутой фигуры (взято отсюда https://habrahabr.ru/post/125356/)
        bool isPointInside(const Point& point);
        bool isPointInside(double x, double y);

        //валидность фигуры определяется числом точек, соответствующих ее типу и значениями самих точек
        bool isValid() const;

        //замкнутая ли фигура
        virtual bool isClosed() const = 0;

        //получить сторону фигуры по индексу (0 - сторона между первой и второй точками, 1 - между второй и третьей и т.д.)
        LineSegment getSide(int i) const;

        //первая точка коллекции
        Point firstPoint() const;

        //последняя точка коллекции
        Point lastPoint() const;

        //точка коллекции по индексу (от 0)
        Point pointByIndex(int idx) const;

        //проверка наличия точки в коллекции
        bool hasPoint(const Point& point) const;
        bool hasPoint(double x, double y) const;

        //ищет индекс точки в коллекции
        int pointIndex(const Point& point) const;
        int pointIndex(double x, double y) const;

        //обнуляет коллекцию точек
        void resetPoints();

        //отдает коллекцию точек
        const QList<Point>& getPoints() const;

        //вставка точки в начало коллекции
        void insertFirstPoint(const Point& point);

        //вставка точки в конец коллекции
        void insertLastPoint(const Point& point);

        //вставка точки после искомой точки
        bool insertPointAfterPoint(const Point& searching, const Point& inserting);

        //замена точек в коллекции
        bool replacePoint(int idx, const Point& point);
        bool replaceFirstPoint(const Point& point);
        bool replaceLastPoint(const Point& point);

        //обновление коллекции точек
        bool setPoints(const QList<Point>& points);

    private:
        //коллекция точек
        QList<Point> _points;
    };

}

#endif // FIGURE_H
