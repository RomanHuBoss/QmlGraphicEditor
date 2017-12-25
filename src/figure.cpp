#include "figure.h"


Figure::Figure(bool isClosed_): isClosed(isClosed_)
{

}

Figure::~Figure()
{

}

bool Figure::getIsClosed() const
{
    return isClosed;
}
