//
// Created by shubh on 23/03/2021.
//

#include "Math.h"

HD bool approximatelyeq(double x, double y)
{
    const double EPSILON = 1E-14;
    if (x == 0)
        return fabs(y) <= EPSILON;
    if (y == 0)
        return fabs(x) <= EPSILON;
    return fabs(x - y) / max(fabs(x), fabs(y)) <= EPSILON;
}