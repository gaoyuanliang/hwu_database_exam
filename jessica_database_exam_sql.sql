DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
cid INT NOT NULL,
name varchar(255),
PRIMARY KEY (cid)
);
INSERT INTO Customers VALUES (1, 'Anne');
INSERT INTO Customers VALUES (2, 'Bob');
INSERT INTO Customers VALUES (3, 'Carol');
select * from Customers;

DROP TABLE IF EXISTS Boats;
CREATE TABLE Boats (
bid INT NOT NULL,
bname varchar(255),
colour varchar(255),
PRIMARY KEY (bid)
);
INSERT INTO Boats VALUES (9001, 'Edinburgh', 'red');
INSERT INTO Boats VALUES (9002, 'Dubai', 'blue');
INSERT INTO Boats VALUES (9003, 'Malaysia', 'yellow') 
select * from Boats;

DROP TABLE IF EXISTS Reserves;
CREATE TABLE Reserves (
cid INT NOT NULL,
bid INT NOT NULL,
day date
);
INSERT INTO Reserves VALUES (1, 9002, '2020-12-01');
INSERT INTO Reserves VALUES (3, 9002, '2020-12-11');
INSERT INTO Reserves VALUES (1, 9001, '2020-12-03');
INSERT INTO Reserves VALUES (3, 9001, '2020-12-03');
INSERT INTO Reserves VALUES (3, 9001, '2020-12-03');
INSERT INTO Reserves VALUES (1, 9001, '2020-12-03');
INSERT INTO Reserves VALUES (3, 9001, '2020-12-03');
select * from Reserves;

select Customers.name
from Reserves, Customers, Boats
where Reserves.cid = Customers.cid
and Reserves.bid = Boats.bid
and Boats.colour = "blue";

select Customers.name
from Customers
left join Reserves
on Reserves.cid = Customers.cid
where Reserves.cid is null;

select bid, day, count(*) as reservation_number
from Reserves
group by bid, day;

select convert(varchar, '2020-12-03', 103)

select bname as boat_name, 
concat(substr(day, 9,2), '-', 
	substr(day, 6,2), '-', 
	substr(day, 1,4)) as date_EUROPEAN_style,
reservation_number as boat_hired_time_number
from (
	select Reserves.bid, cast(day as varchar(100)) as day, 
	Boats.bname, count(*) as reservation_number
	from Reserves, Boats
	where Boats.bid = Reserves.bid
	group by bid, day
) a 
where reservation_number > 4;