﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Domain.Interfaces
{
    interface IPricer
    {
        decimal Price(IPizza pizza);
    }
}