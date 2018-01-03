#include "multiline.h"

Rosdistant::Multiline::Multiline() {

}


Rosdistant::Multiline::Multiline(Rosdistant::Point* points, int quant, bool isClosed):
    _isClosed(isClosed)
{
    for (int i = 0; i < quant; i++)
        insertLastPoint(*(points + i));
}

Rosdistant::Multiline::Multiline(Rosdistant::LineSegment* segments, int quant, bool isClosed):
    _isClosed(isClosed)
{
    for (int i = 0; i < quant; i++) {
        insertLastPoint((*(segments + i)).firstPoint());
        insertLastPoint((*(segments + i)).lastPoint());
    }
}

int Rosdistant::Multiline::necessaryPointsQuant() const
{
    return 2;
}

Rosdistant::Point Rosdistant::Multiline::getCentralPoint() const
{
    return Point();
}

bool Rosdistant::Multiline::isClosed() const
{
    return _isClosed && getPoints().size() > 2;
}

void Rosdistant::Multiline::setIsClosed(bool isClosed)
{
    _isClosed = isClosed;
}

QString Rosdistant::Multiline::className() const
{
    return "Multiline";
}

Rosdistant::Multiline::operator QString()
{
    QList<Point> points = getPoints();

    QString result = "Mutiline(";

    for (int i = 0; i < points.size(); i++) {
        result += QString(points[i]);
    }

    result += ")";

    return result;
}

