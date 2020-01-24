-- This file contains commented out code that was more of an as-you-go construction of the sql db

--create database PizzaDb;

--create Schema Pizza;
--create Schema Store;
--create Schema Logic;
--create Schema Users;
--create Schema Orders;

--drop table Pizza.Topping;
--create table Pizza.Topping(
--	id smallint identity(1,1) primary key,
--	name char(30) unique not null,
--);
--Truncate table Pizza.Topping;

--select * from Pizza.Topping;

--create table Pizza.Prebuilt(
--	id smallint identity(1,1) primary key,
--	crustId smallint foreign key references Pizza.Crust(Id) not null,
--	name char(30) unique not null,
--)

--create table Pizza.Crust(
--	id smallint identity(1,1) primary key,
--	name char(30) unique not null,
--	description varchar(max) not null,
--	)

--update Pizza.Crust
--set description = 'Thick crust baked in a rectangular pan'
--where id = 4;
--select * from pizza.crust;

--create table Pizza.PrebuiltToppings(
--	prebuiltId smallint foreign key references Pizza.Prebuilt(Id) not null,
--	toppingId smallint foreign key references Pizza.Topping(Id) not null,
--)

--create table Pizza.Size(
--	id smallint primary key identity(1,1),
--	name varchar(32) unique not null
--	)

--create table Orders.Orders(
--	id bigint primary key identity(1,1),
--	storeid int foreign key references store.store(id),
--	userid int foreign key references users.users(id)
--)

--create table Orders.Pizza(
--	orderId bigint foreign key references orders.orders(id),
--	pizzaNum int not null,
--	crustId smallint not null foreign key references pizza.crust(id),
--	size smallint not null foreign key references pizza.size(id),
--	constraint [PK_OrderedPizza] primary key clustered (orderid, pizzaNum)
--)

--create table Orders.PizzaToppings(
--	orderId bigint not null,
--	pizzaNum int not null,
--	toppingId smallint not null foreign key references Pizza.Topping(id),
--	amount tinyint not null default(1) check(amount>0),
--	constraint [FK_Pizza] foreign key (orderId, pizzaNum) references Orders.Pizza(orderId, pizzaNum),
--	constraint [PK_PizzaToppings] primary key (orderid, pizzanum)
--)

--create table Store.Location(
--	id int primary key identity(1,1),
--	name varchar(128) unique not null
--)

--create table Store.Store(
--	id int primary key foreign key references Logic.Logins(id),
--	name varchar(128) unique not null,
--	location int foreign key references Store.Location(id)
--)

--create table Store.ToppingInventory(
--	StoreId int foreign key references Store.Store(id),
--	ToppingId smallint foreign key references Pizza.Topping(id),
--	amount int check(amount >= 0) not null
--)

--create table Store.CrustInventory(
--	StoreId int foreign key references Store.Store(id),
--	Crustid smallint foreign key references Pizza.Crust(id),
--	amount int check(amount >= 0) not null
--)

--create Table Store.Prebuilt(
--	StoreId int foreign key references Store.Store(id),
--	PrebuiltId smallint foreign key references Pizza.Prebuilt(id),
--)

--create table Logic.Logins(
--	id int primary key,
--	username varchar(128) unique not null,
--	password varchar(128) not null,
--)

--create table Users.Users(
--	id int primary key foreign key references Logic.Logins(id),
--)