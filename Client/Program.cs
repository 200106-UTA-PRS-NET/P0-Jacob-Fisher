using System;
using System.IO;
using Domain.Models;
using System.Linq;
using System.Text;
using System.Collections.Generic;
using Domain.Interfaces;
using Domain;

namespace Client
{
    static class Program
    {
        static IContext context;
        static readonly Func<String, String> prompt = s => {
            Console.Write($"{s}> ");
            return Console.ReadLine();
        };
        static bool finished = false;
        static void Main(string[] _args)
        {
            context = ContextDBBacked.Context;
            context.GetToppings();
            ActionDict actions = new ActionDict();
            #region required
            foreach (var command in new string[] { "login", "signin" })
            { 
            actions.Add(command, Login);
            }
            foreach (var command in new string[] { "ls", "locs", "locations" }) {
                actions.Add(command, Locations);
            }
            foreach (var command in new string[] { "loc", "location" })
            {
                actions.Add(command, SelectorGenerator(context.GetStores, context.SetStore, "store"));
            }
            actions.Add("new", Order);
            actions.Add("history", History);
            foreach (var command in new string[] { "logout", "signout" })
            {
                actions.Add(command, context.Logout);
            }
            foreach (var command in new string[] { "quit", "exit", "end" })
            {
                actions.Add(command, Quit);
            }
            #endregion
            #region optional
            actions.Add("register", Register);
            actions.Add("sales", Sales);
            actions.Add("users", Users);
            actions.Add("inventory", SelectorGenerator(Inventory, s => { Console.WriteLine(context.GetInventory(s)); }, "topping"));
            #endregion
            Console.WriteLine("Welcome to Revature Pizza Portal");
            Console.WriteLine("Valid commands are listed below.");
            actions.Help();
            string input;
            while (!finished && (input = prompt(
            #region uglyPrompt
                $"{((context.LoggedIn!=null)?context.LoggedIn.Username:"Logged out")}{((context.Location!=null)?$"@{context.Location.Name}":"")}"
            #endregion
                ))!=null){
                string[] sep = input.Split(null, 2);
                sep[0] = sep[0].ToLower();
                try
                {
                    actions[sep[0]](sep.ElementAtOrDefault(1));
                } catch (KeyNotFoundException)
                {
                    InvalidCommand(sep[0], actions);
                } catch (InvalidOperationException e)
                {
                    Console.WriteLine(e.Message);
                } 
                catch (PizzaBoxException e)
                {
                    Console.WriteLine(e.Message);
                }
                catch (NotImplementedException)
                {
                    Console.WriteLine($"The functionality of {sep[0]} is not available yet. Please try again in the future.");
                }
            }
        }

        private static IEnumerable<string> Inventory()
        {
            if (context.LoggedIn == null || !context.LoggedIn.IsStore)
            {
                throw new InvalidOperationException("You must be logged in as a store to view inventory");
            }
            return context.GetToppings();
        }

        private static void Sales(string modifier)
        {
            if (context.LoggedIn == null || !context.LoggedIn.IsStore)
            {
                throw new InvalidOperationException("You must be logged in as a store to view sales");
            }
            ActionDict actions = new ActionDict();

            foreach (var command in new string[] { "day", "d" })
            {
                actions.Add(command, SalesByDay);
            }
            foreach (var command in new string[] { "month", "m" })
            {
                actions.Add(command, SalesByMonth);
            }
            actions.Add("cancel", () => { });
            string []sep;
            if(modifier == null)
            {
                sep = prompt("{[m]onth|[d]ay} (count)").Split(null, 2);
            } else { sep = modifier.Split(null, 2); }
            while (true)
            {
                sep[0] = sep[0].ToLower();
                try
                {
                    actions[sep[0]](sep.ElementAtOrDefault(1));
                    break;
                }
                catch (KeyNotFoundException)
                {
                    InvalidCommand(sep[0], actions);
                }
                catch (InvalidOperationException e)
                {
                    Console.WriteLine(e.Message);
                }
                catch (PizzaBoxException e)
                {
                    Console.WriteLine(e.Message);
                }
                catch (NotImplementedException)
                {
                    Console.WriteLine($"The functionality of {sep[0]} is not available yet. Please try again in the future.");
                }
                sep = prompt("{[m]onth|[d]ay} (count)").Split(null, 2);
            }
        }

        private static void SalesByMonth(string months)
        {
            int monthCount;
            try
            {
                monthCount = Int32.Parse(months);
            } catch (FormatException)
            {
                monthCount = 12;
            } catch (ArgumentNullException)
            {
                monthCount = 12;
            }
            Console.WriteLine("Month\tValues\tPizzas");
            foreach (var sales in context.GetSalesMonths(monthCount))
            {
                Console.WriteLine($"{sales.Time.ToString("yyyy-MM")}\t{sales.Value}\t{sales.NumPizzas}");
            }
        }

        private static void SalesByDay(string days)
        {
            int dayCount;
            try
            {
                dayCount = Int32.Parse(days);
            }
            catch (FormatException)
            {
                dayCount = 30;
            }
            catch (ArgumentNullException)
            {
                dayCount = 30;
            }
            Console.WriteLine("Date\tValues\tPizzas");
            foreach (var sales in context.GetSalesDays(dayCount))
            {
                Console.WriteLine($"{sales.Time.ToString("yyyy-MM-dd")}\t{sales.Value}\t{sales.NumPizzas}");
            }
        }

        private static void Users()
        {
            IEnumerable<User> users = context.GetUsers();
            if (users == null)
            {
                return;
            }
            foreach(User user in users)
            {
                Console.WriteLine(user.Username);
            }
        }

        private static void Preview()
        {
            IOrder order = context.PreviewOrder();
            if (order != null) {
            Console.WriteLine($"{order.Price}");
            foreach (var pizza in order.Pizzas)
            {
                Console.WriteLine(pizza.ToString());
            }
        } else
            {
                Console.WriteLine("Not currently ordering.");
            }
        }

        private static void PreviewPizza()
        {
            IPizza pizza = context.PreviewPizza();
            if(pizza != null)
            {
                Console.WriteLine(pizza.ToString());
            } else
            {
                Console.WriteLine("Not currently editing a pizza.");
            }
        }

        private static void Register(string uname)
        {
            if (context.LoggedIn != null)
            {
                Console.WriteLine($"You are already logged in as {context.LoggedIn.Username}");
                return;
            }
            if (uname == null)
            {
                uname = prompt("Enter Username");
            }
            string pass = prompt("Enter Password"); // TODO: Mask password, hash password
            context.Register(uname, pass);
            context.Login(uname, pass);
        }

        private static void InvalidCommand(string command, ActionDict actions)
        {
            if (command != "help")
            {
                Console.WriteLine($"{((command.Length > 0) ? $"Invalid input: {command}. " : "")}Valid inputs are:");
            }
            actions.Help();
        }
        private static void Login(string uname)
        {
            if (context.LoggedIn != null)
            {
                Console.WriteLine($"You are already logged in as {context.LoggedIn.Username}");
                return;
            }
            if(uname == null)
            {
                uname = prompt("Enter Username");
            }
            string pass = prompt("Enter Password"); // TODO: Mask password, hash password
            context.Login(uname, pass);
        }
        private static void Locations()
        {
            var locationList = context.GetStores();
            foreach (var location in locationList)
            {
                Console.WriteLine(location);
            }
        }
        private static void Order()
        {
            if (context.Location == null)
            {
                Console.WriteLine("Please select a location before creating a new order.");
                return;
            }
            if (context.LoggedIn ==null || !context.LoggedIn.IsUser)
            {
                Console.WriteLine("Please login as a user before creating a new order.");
                return;
            }
            ActionDict actions = new ActionDict();
            foreach (var command in new string[] { "p", "prebuilt" })
            {
                actions.Add(command, s=> { SelectorGenerator(context.GetPresets, context.PresetPizza, "preset")(s); PizzaBuilder(); });
            }
            foreach (var command in new string[] { "c", "custom" })
            {
                actions.Add(command, Custom);
            }
            actions.Add("preview", Preview);
            actions.Add("confirm", Confirm);
            actions.Add("cancel", Cancel);
            context.NewOrder();
            IOrder preview;
            while (context.InOrder)
            {
                preview = context.PreviewOrder();
                string[] sep = prompt($"{preview.Pizzas.Count()} Pizzas @ {preview.Price:C}").Split(null,2);
                sep[0] = sep[0].ToLower();
                try
                {
                    actions[sep[0]](sep.ElementAtOrDefault(1));
                }
                catch (KeyNotFoundException)
                {
                    InvalidCommand(sep[0],actions);
                }
                catch (InvalidOperationException e)
                {
                    Console.WriteLine(e.Message);
                }

                catch (PizzaBoxException e)
                {
                    Console.WriteLine(e.Message);
                }
                catch (NotImplementedException)
                {
                    Console.WriteLine($"The functionality of {sep[0]} is not available yet. Please try again in the future.");
                }
            }
        }

        private static void Cancel()
        {
            context.CancelOrder();
        }

        private static void Confirm()
        {
            ActionDict actions = new ActionDict
            {
                { "y", context.PlaceOrder },
                { "n", () => { } }
            };
            Preview();
            string confirm;
            while (true)
            {
                confirm = prompt("Is this order good? Y/n").ToLower().Trim();
                if (confirm == "")
                {
                    confirm = "y";
                }
                try
                {
                    actions[confirm](null);
                    break;
                }
                catch (KeyNotFoundException)
                {
                    InvalidCommand(confirm, actions);
                }
                catch (InvalidOperationException e)
                {
                    Console.WriteLine(e.Message);
                }

                catch (PizzaBoxException e)
                {
                    Console.WriteLine(e.Message);
                }
                catch (NotImplementedException)
                {
                    Console.WriteLine($"The functionality of {confirm} is not available yet. Please try again in the future.");
                }
            }
        }
        private static void ConfirmPizza()
        {
            ActionDict actions = new ActionDict
            {
                { "y", context.AddPizzaToOrder },
                { "n", () => { } }
            };
            PreviewPizza();
            string confirm;
            while (true)
            {
                confirm = prompt("Is this pizza good? Y/n (or count)").ToLower().Trim();
                if (confirm == "")
                {
                    confirm = "y";
                }
                try
                {
                    uint count = UInt32.Parse(confirm);
                    context.AddPizzaToOrder(count);
                }
                catch (System.FormatException) { }
                catch (ArgumentOutOfRangeException) { }
                try
                {
                    actions[confirm](null);
                    break;
                }
                catch (KeyNotFoundException)
                {
                    InvalidCommand(confirm, actions);
                }
                catch (InvalidOperationException e)
                {
                    Console.WriteLine(e.Message);
                }
                catch (PizzaBoxException e)
                {
                    Console.WriteLine(e.Message);
                }
                catch (NotImplementedException)
                {
                    Console.WriteLine($"The functionality of {confirm} is not available yet. Please try again in the future.");
                }
            }
        }
        private static void Custom()
        {
            context.NewPizza();
            PizzaBuilder();
        }

        private static void Quit()
        {
            finished = true;
        }

        private static void History()
        {
            if (context.LoggedIn == null)
            {
                throw new InvalidOperationException("You need to log in before you can view history");
            }
            bool isUser = context.LoggedIn.IsUser;
            int i = 0;
            Console.WriteLine($"Price\t\t|#Pizzas\t|{((isUser) ? "Store" : "User")}");
            foreach(var order in context.OrderHistory())
            {
                Console.WriteLine($"{order.Price}\t\t|{order.Pizzas.Count()}\t\t|{((isUser)?order.Store.Name:order.User.Username)}");
                i++;
                if (i > 20) { break; }
            }
        }

        private static void PizzaBuilder()
        {
            if (!context.InPizza)
            {
                return;
            }
            ActionDict actions = new ActionDict();
            foreach (var command in new string[] { "topping", "add" })
            {
                actions.Add(command, SelectorGenerator(context.GetToppings, context.AddTopping, "topping"));
            }
            foreach (var command in new string[] { "s", "size" })
            {
                actions.Add(command, SelectorGenerator(context.GetSizes, context.SetSize, "size"));
            }
            foreach (var command in new string[] { "c", "crust" })
            {
                actions.Add(command, SelectorGenerator(context.GetCrusts, context.SetCrust, "crust"));
            }
            actions.Add("remove", SelectorGenerator(()=>from topping in context.PreviewPizza().Toppings select topping.Name, context.RemoveTopping, "topping"));
            actions.Add("confirm", ConfirmPizza);
            actions.Add("preview", PreviewPizza);
            actions.Add("cancel", context.CancelPizza);
            IPizza preview;
            while (context.InPizza)
            {
                preview = context.PreviewPizza();
                string[] sep = prompt($"{preview.Toppings.Count()} Topping {preview.Size.Name} Pizza @ {preview.Price:C}").Split(null, 2);
                sep[0] = sep[0].ToLower();
                try
                {
                    actions[sep[0]](sep.ElementAtOrDefault(1));
                }
                catch (KeyNotFoundException)
                {
                    InvalidCommand(sep[0], actions);
                }
                catch (InvalidOperationException e)
                {
                    Console.WriteLine(e.Message);
                }
                catch (PizzaBoxException e)
                {
                    Console.WriteLine(e.Message);
                }
                catch (NotImplementedException)
                {
                    Console.WriteLine($"The functionality of {sep[0]} is not available yet. Please try again in the future.");
                }
            }
        }

        private static Action<string> SelectorGenerator(Func<IEnumerable<string>> inFunc, Action<string> outFunc, string type)
        {
            return new Action<string>(selection => {
                IEnumerable<string> vals = inFunc();
                ActionDict actions = new ActionDict();
                foreach (string val in vals)
                {
                    actions.Add(val.ToLower(), s => outFunc(val));
                }
                if (selection == null)
                {
                    actions.Help();
                    selection = prompt($"Select a {type} from the above list or cancel").ToLower().Trim();
                }
                do
                {
                    try
                    {
                        actions[selection](null);
                        break;
                    }
                    catch (KeyNotFoundException)
                    {
                        if (selection == "cancel")
                        {
                            break;
                        }
                        else
                        {
                            InvalidCommand(selection, actions);
                        }
                    }
                    catch (InvalidOperationException e)
                    {
                        Console.WriteLine(e.Message);
                    }
                    catch (PizzaBoxException e)
                    {
                        Console.WriteLine(e.Message);
                    }
                    catch (NotImplementedException)
                    {
                        Console.WriteLine($"The functionality of {selection} is not available yet. Please try again in the future.");
                    }
                    selection = prompt($"Select a {type} or cancel").ToLower().Trim();
                } while (true);
            });
        }
    }
}