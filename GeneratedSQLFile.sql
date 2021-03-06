USE [master]
GO
/****** Object:  Database [PizzaDb]    Script Date: 2020-01-24 12:22:45 ******/
CREATE DATABASE [PizzaDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PizzaDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PizzaDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PizzaDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PizzaDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [PizzaDb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PizzaDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PizzaDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PizzaDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PizzaDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PizzaDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PizzaDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [PizzaDb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PizzaDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PizzaDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PizzaDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PizzaDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PizzaDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PizzaDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PizzaDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PizzaDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PizzaDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PizzaDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PizzaDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PizzaDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PizzaDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PizzaDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PizzaDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PizzaDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PizzaDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PizzaDb] SET  MULTI_USER 
GO
ALTER DATABASE [PizzaDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PizzaDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PizzaDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PizzaDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PizzaDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PizzaDb] SET QUERY_STORE = OFF
GO
USE [PizzaDb]
GO
/****** Object:  Schema [Logic]    Script Date: 2020-01-24 12:22:45 ******/
CREATE SCHEMA [Logic]
GO
/****** Object:  Schema [Orders]    Script Date: 2020-01-24 12:22:45 ******/
CREATE SCHEMA [Orders]
GO
/****** Object:  Schema [Pizza]    Script Date: 2020-01-24 12:22:45 ******/
CREATE SCHEMA [Pizza]
GO
/****** Object:  Schema [Store]    Script Date: 2020-01-24 12:22:45 ******/
CREATE SCHEMA [Store]
GO
/****** Object:  Schema [Users]    Script Date: 2020-01-24 12:22:45 ******/
CREATE SCHEMA [Users]
GO
/****** Object:  Table [Logic].[Logins]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logic].[Logins](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](128) NOT NULL,
	[password] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Orders].[Orders]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Orders].[Orders](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[storeid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[price] [smallmoney] NOT NULL,
	[ordertime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Orders].[Pizza]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Orders].[Pizza](
	[orderId] [bigint] NOT NULL,
	[pizzaNum] [int] NOT NULL,
	[crustId] [smallint] NOT NULL,
	[size] [smallint] NOT NULL,
	[price] [smallmoney] NOT NULL,
 CONSTRAINT [PK_OrderedPizza] PRIMARY KEY CLUSTERED 
(
	[orderId] ASC,
	[pizzaNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Orders].[PizzaToppings]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Orders].[PizzaToppings](
	[orderId] [bigint] NOT NULL,
	[pizzaNum] [int] NOT NULL,
	[toppingId] [smallint] NOT NULL,
	[amount] [tinyint] NOT NULL,
 CONSTRAINT [PK_PizzaToppings] PRIMARY KEY CLUSTERED 
(
	[orderId] ASC,
	[pizzaNum] ASC,
	[toppingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Pizza].[Crust]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Pizza].[Crust](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [char](30) NOT NULL,
	[description] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Pizza].[Prebuilt]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Pizza].[Prebuilt](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[crustId] [smallint] NOT NULL,
	[name] [char](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Pizza].[PrebuiltToppings]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Pizza].[PrebuiltToppings](
	[prebuiltId] [smallint] NOT NULL,
	[toppingId] [smallint] NOT NULL,
	[amount] [tinyint] NOT NULL,
 CONSTRAINT [PK_COMPOSITE] PRIMARY KEY CLUSTERED 
(
	[prebuiltId] ASC,
	[toppingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Pizza].[Size]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Pizza].[Size](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Pizza].[Topping]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Pizza].[Topping](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [char](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Store].[CrustInventory]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[CrustInventory](
	[StoreId] [int] NOT NULL,
	[Crustid] [smallint] NOT NULL,
	[amount] [int] NULL,
 CONSTRAINT [PK_StorexCrust] PRIMARY KEY CLUSTERED 
(
	[StoreId] ASC,
	[Crustid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Store].[Location]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[Location](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Store].[Prebuilt]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[Prebuilt](
	[StoreId] [int] NOT NULL,
	[PrebuiltId] [smallint] NOT NULL,
 CONSTRAINT [AK_Prebuilt_Column] PRIMARY KEY CLUSTERED 
(
	[StoreId] ASC,
	[PrebuiltId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Store].[Store]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[Store](
	[id] [int] NOT NULL,
	[name] [varchar](128) NOT NULL,
	[location] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Store].[ToppingInventory]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[ToppingInventory](
	[StoreId] [int] NOT NULL,
	[ToppingId] [smallint] NOT NULL,
	[amount] [int] NULL,
 CONSTRAINT [PK_StorexTopping] PRIMARY KEY CLUSTERED 
(
	[StoreId] ASC,
	[ToppingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Users].[Users]    Script Date: 2020-01-24 12:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Users].[Users](
	[id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [Logic].[Logins] ON 

INSERT [Logic].[Logins] ([id], [username], [password]) VALUES (1, N'pizzaPizza', N'pizza')
INSERT [Logic].[Logins] ([id], [username], [password]) VALUES (2, N'jacobdf', N'password')
INSERT [Logic].[Logins] ([id], [username], [password]) VALUES (3, N'bento', N'12345')
INSERT [Logic].[Logins] ([id], [username], [password]) VALUES (5, N'jeritzaPizza', N'mercedes')
INSERT [Logic].[Logins] ([id], [username], [password]) VALUES (6, N'human', N'being')
SET IDENTITY_INSERT [Logic].[Logins] OFF
SET IDENTITY_INSERT [Orders].[Orders] ON 

INSERT [Orders].[Orders] ([id], [storeid], [userid], [price], [ordertime]) VALUES (5, 1, 2, 12.0000, CAST(N'2020-01-22T09:58:49.433' AS DateTime))
INSERT [Orders].[Orders] ([id], [storeid], [userid], [price], [ordertime]) VALUES (7, 1, 3, 10.0000, CAST(N'2020-01-23T11:18:40.257' AS DateTime))
INSERT [Orders].[Orders] ([id], [storeid], [userid], [price], [ordertime]) VALUES (8, 1, 2, 10.0000, CAST(N'2020-01-23T23:44:34.513' AS DateTime))
INSERT [Orders].[Orders] ([id], [storeid], [userid], [price], [ordertime]) VALUES (9, 1, 2, 20.0000, CAST(N'2020-01-24T00:22:19.340' AS DateTime))
INSERT [Orders].[Orders] ([id], [storeid], [userid], [price], [ordertime]) VALUES (10, 1, 2, 22.0000, CAST(N'2020-01-24T00:23:06.847' AS DateTime))
INSERT [Orders].[Orders] ([id], [storeid], [userid], [price], [ordertime]) VALUES (11, 1, 2, 18.0000, CAST(N'2020-01-24T11:30:01.350' AS DateTime))
SET IDENTITY_INSERT [Orders].[Orders] OFF
INSERT [Orders].[Pizza] ([orderId], [pizzaNum], [crustId], [size], [price]) VALUES (5, 1, 1, 4, 12.0000)
INSERT [Orders].[Pizza] ([orderId], [pizzaNum], [crustId], [size], [price]) VALUES (7, 1, 1, 4, 10.0000)
INSERT [Orders].[Pizza] ([orderId], [pizzaNum], [crustId], [size], [price]) VALUES (8, 1, 1, 4, 10.0000)
INSERT [Orders].[Pizza] ([orderId], [pizzaNum], [crustId], [size], [price]) VALUES (9, 1, 1, 4, 10.0000)
INSERT [Orders].[Pizza] ([orderId], [pizzaNum], [crustId], [size], [price]) VALUES (9, 2, 1, 4, 10.0000)
INSERT [Orders].[Pizza] ([orderId], [pizzaNum], [crustId], [size], [price]) VALUES (10, 1, 1, 4, 11.0000)
INSERT [Orders].[Pizza] ([orderId], [pizzaNum], [crustId], [size], [price]) VALUES (10, 2, 1, 4, 11.0000)
INSERT [Orders].[Pizza] ([orderId], [pizzaNum], [crustId], [size], [price]) VALUES (11, 1, 1, 4, 8.0000)
INSERT [Orders].[Pizza] ([orderId], [pizzaNum], [crustId], [size], [price]) VALUES (11, 2, 1, 4, 10.0000)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (5, 1, 118, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (5, 1, 119, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (7, 1, 118, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (7, 1, 119, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (8, 1, 118, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (8, 1, 119, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (9, 1, 118, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (9, 1, 119, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (9, 2, 118, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (9, 2, 119, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (10, 1, 7, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (10, 1, 118, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (10, 1, 119, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (10, 2, 7, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (10, 2, 118, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (10, 2, 119, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (11, 2, 118, 1)
INSERT [Orders].[PizzaToppings] ([orderId], [pizzaNum], [toppingId], [amount]) VALUES (11, 2, 119, 1)
SET IDENTITY_INSERT [Pizza].[Crust] ON 

INSERT [Pizza].[Crust] ([id], [name], [description]) VALUES (1, N'Regular                       ', N'Regular crust, extraordinary pizza')
INSERT [Pizza].[Crust] ([id], [name], [description]) VALUES (2, N'Thin                          ', N'Thin, crispy crust')
INSERT [Pizza].[Crust] ([id], [name], [description]) VALUES (3, N'Deep-dish                     ', N'Deep-dish pan pizza')
INSERT [Pizza].[Crust] ([id], [name], [description]) VALUES (4, N'Sicilian                      ', N'Thick crust baked in a rectangular pan')
SET IDENTITY_INSERT [Pizza].[Crust] OFF
SET IDENTITY_INSERT [Pizza].[Prebuilt] ON 

INSERT [Pizza].[Prebuilt] ([id], [crustId], [name]) VALUES (1, 1, N'Cheese                        ')
INSERT [Pizza].[Prebuilt] ([id], [crustId], [name]) VALUES (2, 1, N'Pepperoni                     ')
INSERT [Pizza].[Prebuilt] ([id], [crustId], [name]) VALUES (3, 2, N'Patience                      ')
SET IDENTITY_INSERT [Pizza].[Prebuilt] OFF
INSERT [Pizza].[PrebuiltToppings] ([prebuiltId], [toppingId], [amount]) VALUES (1, 118, 1)
INSERT [Pizza].[PrebuiltToppings] ([prebuiltId], [toppingId], [amount]) VALUES (1, 119, 1)
INSERT [Pizza].[PrebuiltToppings] ([prebuiltId], [toppingId], [amount]) VALUES (2, 13, 1)
INSERT [Pizza].[PrebuiltToppings] ([prebuiltId], [toppingId], [amount]) VALUES (2, 118, 1)
INSERT [Pizza].[PrebuiltToppings] ([prebuiltId], [toppingId], [amount]) VALUES (2, 119, 1)
INSERT [Pizza].[PrebuiltToppings] ([prebuiltId], [toppingId], [amount]) VALUES (3, 107, 1)
INSERT [Pizza].[PrebuiltToppings] ([prebuiltId], [toppingId], [amount]) VALUES (3, 118, 1)
INSERT [Pizza].[PrebuiltToppings] ([prebuiltId], [toppingId], [amount]) VALUES (3, 119, 1)
SET IDENTITY_INSERT [Pizza].[Size] ON 

INSERT [Pizza].[Size] ([id], [name]) VALUES (5, N'Large')
INSERT [Pizza].[Size] ([id], [name]) VALUES (4, N'Medium')
INSERT [Pizza].[Size] ([id], [name]) VALUES (2, N'Personal')
INSERT [Pizza].[Size] ([id], [name]) VALUES (1, N'Slice')
INSERT [Pizza].[Size] ([id], [name]) VALUES (3, N'Small')
SET IDENTITY_INSERT [Pizza].[Size] OFF
SET IDENTITY_INSERT [Pizza].[Topping] ON 

INSERT [Pizza].[Topping] ([id], [name]) VALUES (1, N'Alfalfa Sprouts               ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (85, N'Almonds                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (84, N'Anchovies                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (83, N'Artichoke hearts              ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (82, N'Avocado                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (80, N'Baby leeks                    ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (79, N'Bacon                         ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (78, N'Basil                         ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (77, N'Bay Leaf                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (81, N'BBQ Chicken                   ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (76, N'Beef                          ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (75, N'Beetroot                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (74, N'Black Beans                   ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (73, N'Blue Cheese                   ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (72, N'Brie                          ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (71, N'Broccoli                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (70, N'Cajun Chicken                 ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (69, N'Cajun Prawn                   ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (68, N'Camembert                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (67, N'Capers                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (66, N'Capicolla                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (65, N'Cardamon                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (64, N'Carrot                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (63, N'Cheddar                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (119, N'Cheese                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (62, N'Cherry tomatoes               ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (61, N'Chicken Masala                ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (86, N'Chicken Tikka                 ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (87, N'Chives                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (88, N'Chorizo                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (89, N'Cilantro                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (115, N'Colby                         ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (114, N'Coriander                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (113, N'Crayfish                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (112, N'Cumin                         ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (111, N'Dill                          ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (110, N'Dried Chili                   ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (109, N'Dried tomatoes                ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (108, N'Duck                          ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (107, N'Eggplant                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (106, N'Feta                          ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (105, N'Fresh Chili                   ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (104, N'Fungi                         ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (116, N'Fungi carciofi                ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (103, N'Garlic                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (101, N'Goat Cheese                   ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (100, N'Gorgonzola                    ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (99, N'Green peppers                 ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (98, N'Ham                           ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (97, N'Honey Cured Ham               ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (96, N'Jalapeno Peppers              ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (95, N'Kalamata olives               ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (94, N'Laurel                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (93, N'Lettuce                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (92, N'Limburger                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (91, N'Lobster                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (90, N'Manchego                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (60, N'Marjoram                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (102, N'Meatballs                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (59, N'Methi Leaves                  ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (43, N'Monterey Jack                 ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (26, N'Mozzarella                    ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (25, N'Muenster                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (24, N'Mushrooms                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (23, N'Olives                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (22, N'Onions                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (21, N'Oregano                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (20, N'Oysters                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (18, N'Parmesan                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (19, N'Parsley                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (17, N'Peanuts                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (16, N'Peas                          ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (15, N'Pecans                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (14, N'Pepper                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (13, N'Pepperoni                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (12, N'Pine Nuts                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (11, N'Pistachios                    ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (10, N'Porcini mushrooms             ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (9, N'Port de Salut                 ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (8, N'Portobello Mushrooms          ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (7, N'Prawns                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (6, N'Proscuitto                    ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (5, N'Provolone                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (4, N'Red beans                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (3, N'Red onions                    ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (2, N'Red peppers                   ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (27, N'Ricota                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (28, N'Roast cauliflower             ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (30, N'Roasted eggplant              ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (29, N'Roasted Garlic                ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (56, N'Roasted peppers               ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (55, N'Romano                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (54, N'Roquefort                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (53, N'Rosemary                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (52, N'Salami                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (51, N'Salmon                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (118, N'Sauce                         ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (50, N'Sausage                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (49, N'Scallions                     ')
GO
INSERT [Pizza].[Topping] ([id], [name]) VALUES (48, N'Serrano Ham                   ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (47, N'Shallots                      ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (46, N'Shrimps                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (45, N'Smoked Gouda                  ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (57, N'Smoked Salmon                 ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (44, N'Snow peas                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (42, N'Spinach                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (41, N'Squid                         ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (40, N'Sun dried tomatoes            ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (39, N'Sweet corn                    ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (38, N'Tuna                          ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (37, N'Turkey                        ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (36, N'Venison                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (35, N'Walnuts                       ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (34, N'Watercress                    ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (33, N'Whitebait                     ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (32, N'Wild mushrooms                ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (31, N'Yellow peppers                ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (58, N'Yellow squash                 ')
INSERT [Pizza].[Topping] ([id], [name]) VALUES (117, N'Zucchini                      ')
SET IDENTITY_INSERT [Pizza].[Topping] OFF
INSERT [Store].[Prebuilt] ([StoreId], [PrebuiltId]) VALUES (1, 1)
INSERT [Store].[Prebuilt] ([StoreId], [PrebuiltId]) VALUES (1, 2)
INSERT [Store].[Prebuilt] ([StoreId], [PrebuiltId]) VALUES (5, 1)
INSERT [Store].[Prebuilt] ([StoreId], [PrebuiltId]) VALUES (5, 2)
INSERT [Store].[Prebuilt] ([StoreId], [PrebuiltId]) VALUES (5, 3)
INSERT [Store].[Store] ([id], [name], [location]) VALUES (1, N'Pizza Pizza', NULL)
INSERT [Store].[Store] ([id], [name], [location]) VALUES (5, N'Jeritza''s Pizza', NULL)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 1, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 2, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 3, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 4, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 5, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 6, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 7, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 8, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 9, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 10, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 11, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 12, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 13, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 14, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 15, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 16, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 17, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 18, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 19, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 20, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 21, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 22, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 23, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 24, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 25, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 26, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 27, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 28, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 29, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 30, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 31, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 32, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 33, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 34, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 35, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 36, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 37, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 38, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 39, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 40, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 41, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 42, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 43, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 44, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 45, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 46, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 47, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 48, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 49, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 50, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 51, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 52, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 53, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 54, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 55, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 56, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 57, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 58, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 59, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 60, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 61, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 62, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 63, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 64, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 65, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 66, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 67, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 68, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 69, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 70, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 71, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 72, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 73, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 74, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 75, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 76, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 77, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 78, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 79, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 80, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 81, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 82, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 83, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 84, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 85, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 86, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 87, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 88, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 89, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 90, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 91, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 92, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 93, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 94, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 95, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 96, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 97, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 98, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 99, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 100, 100)
GO
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 101, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 102, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 103, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 104, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 105, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 106, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 107, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 108, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 109, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 110, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 111, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 112, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 113, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 114, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 115, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 116, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 117, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 118, 99)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (1, 119, 99)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 1, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 2, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 3, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 4, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 5, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 6, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 7, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 8, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 9, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 10, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 11, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 12, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 13, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 14, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 15, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 16, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 17, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 18, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 19, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 20, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 21, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 22, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 23, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 24, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 25, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 26, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 27, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 28, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 29, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 30, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 31, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 32, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 33, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 34, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 35, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 36, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 37, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 38, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 39, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 40, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 41, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 42, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 43, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 44, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 45, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 46, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 47, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 48, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 49, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 50, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 51, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 52, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 53, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 54, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 55, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 56, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 57, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 58, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 59, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 60, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 61, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 62, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 63, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 64, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 65, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 66, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 67, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 68, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 69, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 70, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 71, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 72, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 73, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 74, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 75, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 76, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 77, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 78, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 79, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 80, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 81, 100)
GO
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 82, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 83, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 84, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 85, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 86, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 87, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 88, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 89, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 90, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 91, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 92, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 93, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 94, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 95, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 96, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 97, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 98, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 99, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 100, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 101, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 102, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 103, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 104, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 105, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 106, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 107, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 108, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 109, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 110, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 111, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 112, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 113, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 114, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 115, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 116, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 117, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 118, 100)
INSERT [Store].[ToppingInventory] ([StoreId], [ToppingId], [amount]) VALUES (5, 119, 100)
INSERT [Users].[Users] ([id]) VALUES (2)
INSERT [Users].[Users] ([id]) VALUES (3)
INSERT [Users].[Users] ([id]) VALUES (6)
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Logins__F3DBC572B8B99515]    Script Date: 2020-01-24 12:22:45 ******/
ALTER TABLE [Logic].[Logins] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Crust__5276644BFB8081D2]    Script Date: 2020-01-24 12:22:45 ******/
ALTER TABLE [Pizza].[Crust] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Prebuilt__77F0C7699B577683]    Script Date: 2020-01-24 12:22:45 ******/
ALTER TABLE [Pizza].[Prebuilt] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Size__72E12F1B937A3E6F]    Script Date: 2020-01-24 12:22:45 ******/
ALTER TABLE [Pizza].[Size] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Topping__51D2CD4C96653413]    Script Date: 2020-01-24 12:22:45 ******/
ALTER TABLE [Pizza].[Topping] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Location__72E12F1B245B0490]    Script Date: 2020-01-24 12:22:45 ******/
ALTER TABLE [Store].[Location] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tmp_ms_x__72E12F1B0B83ABE1]    Script Date: 2020-01-24 12:22:45 ******/
ALTER TABLE [Store].[Store] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Orders].[Orders] ADD  DEFAULT (getdate()) FOR [ordertime]
GO
ALTER TABLE [Orders].[PizzaToppings] ADD  DEFAULT ((1)) FOR [amount]
GO
ALTER TABLE [Pizza].[Crust] ADD  DEFAULT ('') FOR [description]
GO
ALTER TABLE [Pizza].[PrebuiltToppings] ADD  CONSTRAINT [DF_PrebuiltToppings_amount]  DEFAULT ((1)) FOR [amount]
GO
ALTER TABLE [Orders].[Orders]  WITH CHECK ADD FOREIGN KEY([storeid])
REFERENCES [Store].[Store] ([id])
GO
ALTER TABLE [Orders].[Orders]  WITH CHECK ADD FOREIGN KEY([userid])
REFERENCES [Users].[Users] ([id])
GO
ALTER TABLE [Orders].[Pizza]  WITH CHECK ADD FOREIGN KEY([crustId])
REFERENCES [Pizza].[Crust] ([id])
GO
ALTER TABLE [Orders].[Pizza]  WITH CHECK ADD FOREIGN KEY([orderId])
REFERENCES [Orders].[Orders] ([id])
GO
ALTER TABLE [Orders].[Pizza]  WITH CHECK ADD FOREIGN KEY([size])
REFERENCES [Pizza].[Size] ([id])
GO
ALTER TABLE [Orders].[PizzaToppings]  WITH CHECK ADD FOREIGN KEY([toppingId])
REFERENCES [Pizza].[Topping] ([id])
GO
ALTER TABLE [Orders].[PizzaToppings]  WITH CHECK ADD  CONSTRAINT [FK_Pizza] FOREIGN KEY([orderId], [pizzaNum])
REFERENCES [Orders].[Pizza] ([orderId], [pizzaNum])
GO
ALTER TABLE [Orders].[PizzaToppings] CHECK CONSTRAINT [FK_Pizza]
GO
ALTER TABLE [Pizza].[Prebuilt]  WITH CHECK ADD FOREIGN KEY([crustId])
REFERENCES [Pizza].[Crust] ([id])
GO
ALTER TABLE [Pizza].[PrebuiltToppings]  WITH CHECK ADD FOREIGN KEY([prebuiltId])
REFERENCES [Pizza].[Prebuilt] ([id])
GO
ALTER TABLE [Pizza].[PrebuiltToppings]  WITH CHECK ADD FOREIGN KEY([toppingId])
REFERENCES [Pizza].[Topping] ([id])
GO
ALTER TABLE [Store].[CrustInventory]  WITH CHECK ADD FOREIGN KEY([Crustid])
REFERENCES [Pizza].[Crust] ([id])
GO
ALTER TABLE [Store].[CrustInventory]  WITH CHECK ADD FOREIGN KEY([StoreId])
REFERENCES [Store].[Store] ([id])
GO
ALTER TABLE [Store].[Prebuilt]  WITH CHECK ADD FOREIGN KEY([PrebuiltId])
REFERENCES [Pizza].[Prebuilt] ([id])
GO
ALTER TABLE [Store].[Prebuilt]  WITH CHECK ADD FOREIGN KEY([StoreId])
REFERENCES [Store].[Store] ([id])
GO
ALTER TABLE [Store].[Store]  WITH CHECK ADD FOREIGN KEY([location])
REFERENCES [Store].[Location] ([id])
GO
ALTER TABLE [Store].[Store]  WITH CHECK ADD  CONSTRAINT [FK_Store_ToLogin] FOREIGN KEY([id])
REFERENCES [Logic].[Logins] ([id])
GO
ALTER TABLE [Store].[Store] CHECK CONSTRAINT [FK_Store_ToLogin]
GO
ALTER TABLE [Store].[ToppingInventory]  WITH CHECK ADD FOREIGN KEY([StoreId])
REFERENCES [Store].[Store] ([id])
GO
ALTER TABLE [Store].[ToppingInventory]  WITH CHECK ADD FOREIGN KEY([ToppingId])
REFERENCES [Pizza].[Topping] ([id])
GO
ALTER TABLE [Users].[Users]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [Logic].[Logins] ([id])
GO
ALTER TABLE [Orders].[PizzaToppings]  WITH CHECK ADD CHECK  (([amount]>(0)))
GO
ALTER TABLE [Pizza].[PrebuiltToppings]  WITH CHECK ADD  CONSTRAINT [CK_ToppingAtLeast1] CHECK  (([amount]>=(1)))
GO
ALTER TABLE [Pizza].[PrebuiltToppings] CHECK CONSTRAINT [CK_ToppingAtLeast1]
GO
ALTER TABLE [Store].[CrustInventory]  WITH CHECK ADD CHECK  (([amount]>=(0)))
GO
ALTER TABLE [Store].[ToppingInventory]  WITH CHECK ADD CHECK  (([amount]>=(0)))
GO
USE [master]
GO
ALTER DATABASE [PizzaDb] SET  READ_WRITE 
GO
