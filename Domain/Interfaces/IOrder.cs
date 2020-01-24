using System;
using System.Collections.Generic;
using System.Text;

namespace Domain.Interfaces
{
    public interface IOrder
    {
        public Store Store { get; }
        public User User { get; }
        public decimal Price { get; }
        IEnumerable<IPizza> Pizzas { get; }
        public DateTime Ordertime { get; }
    }
}
