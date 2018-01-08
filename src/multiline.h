#ifndef MULTILINE_H
#define MULTILINE_H

#include "figure.h"
#include "point.h"
#include "linesegment.h"

namespace Rosdistant {

    /*
     2D-multiline class
     Author: Rabinovich R.M.
     You can use & modificate the following code without any restrictions
     Date: 10.11.2017
     */
    class Multiline : public Figure
    {
    public:
        Multiline();
        Multiline(Point* points, int quant, bool isClosed);
        Multiline(LineSegment* segments, int quant, bool isClosed);

        operator QString();
        int necessaryPointsQuant() const;
        bool isClosed() const;

        void setIsClosed(bool isClosed);

        //возвраащет название класса
        QString className() const;
    private:
        bool _isClosed;
    };

}

#endif // MULTILINE_H
