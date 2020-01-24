using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Client
{
    class ActionDict:Dictionary<string, Action<string>>
    {
        public void Help()
        {
            Help(null);
        }
        public void Help(IEnumerable<string> extraCommands)
        {
            int i = 0;
            IEnumerable<string> commands = this.Keys;
            if (extraCommands != null)
            {
                commands = commands.Union(extraCommands);
            }
            foreach (string key in commands.OrderBy(k => k))
            {
                Console.Write(key);
                if (++i % 4 == 0)
                {
                    Console.WriteLine();
                }
                else if (key.Length < 8)
                {
                    Console.Write("\t\t");
                }
                else
                {
                    Console.Write("\t");
                }
            }
            if (i % 4 != 0) { Console.WriteLine(); }
        }
        public void Add(string key, Action action)
        {
            Add(key, s => action());
        }
    }
}
