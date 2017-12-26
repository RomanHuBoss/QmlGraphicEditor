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

        //строковое представление фигуры
        virtual QString toString() const = 0;

        //получить необходимое число точек, формирующих фигуру заданного типа
        virtual int necessaryPointsQuant() const = 0;

        //вычисляем координаты центральной точки
        virtual Point getCentralPoint() const = 0;

        //вращение фигуры вокруг точки на угол
        void rotateAroundPoint(const Point& point, const double& theta, AngleType type = RadiansType);

        //вращение фигуры вокруг геометрического центра
        void rotateAroundCenter(const double& theta, AngleType type = RadiansType);

        //валидность фигуры определяется числом точек, соответствующих ее типу и значениями самих точек
        bool isValid() const;

        //получить сторону фигуры по индексу (0 - сторона между первой и второй точками, 1 - между второй и третьей и т.д.)
        LineSegment getSide(int i) const;

        //замкнутая ли фигура
        virtual bool isClosed() const = 0;

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
