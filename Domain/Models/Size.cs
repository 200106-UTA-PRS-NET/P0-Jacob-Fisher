using System;
using System.Collections.Generic;

namespace Domain.Models
{
    public partial class Size
    {
        public Size()
        {
            Pizza = new HashSet<Pizza>();
        }

        public short Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Pizza> Pizza { get; set; }
    }
}
