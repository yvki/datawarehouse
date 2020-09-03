CREATE DATABASE CarSalesDW;

CREATE TABLE CustomerDIM(
	CustomerNumber INT PRIMARY KEY NOT NULL,
	customerName VARCHAR(50) NOT NULL,
	contactLastname VARCHAR(50) NOT NULL,
	contactFirstname VARCHAR(50) NOT NULL,
	Phone VARCHAR(50) NOT NULL,
	addressLine1 VARCHAR(50) NOT NULL,
	addressLine2 VARCHAR(50) NULL,
	city VARCHAR(50) NOT NULL,
	state VARCHAR(50) NULL,
	postalCode VARCHAR(15) NULL,
	country VARCHAR(50) NOT NULL,
);

CREATE TABLE CustomerPaymentDIM(
	customerNumber INT NULL,
	creditLimit FLOAT(53) NOT NULL,
	checkNumber VARCHAR(60) NULL,
	paymentDate DATE NULL,
	FOREIGN KEY (CustomerNumber) REFERENCES CustomerDIM(CustomerNumber)
)

CREATE TABLE OrderDIM (
	orderNumber INT PRIMARY KEY NOT NULL,
	orderDate DATETIME NOT NULL,
	requiredDate DATETIME NOT NULL,
	shippedDate DATETIME NULL,
	status VARCHAR(15) NOT NULL,
	comments TEXT NULL
);

CREATE TABLE OrderLineDIM(
	orderNumber INT NULL,
	orderLineNumber INT NOT NULL,
	FOREIGN KEY (orderNumber) REFERENCES OrderDIM(orderNumber)
);
	
CREATE TABLE ProductDIM (
	productCode VARCHAR(15) NOT NULL PRIMARY KEY,
	productName VARCHAR(70) NOT NULL,
	productLine VARCHAR(50) NOT NULL,
	productScale VARCHAR(10) NOT NULL,
	productVendor VARCHAR(50) NOT NULL,
	productDescription TEXT NOT NULL,
	quantityInStock INT NOT NULL,
	buyPrice FLOAT(53) NOT NULL,
	MSRP FLOAT(53) NOT NULL,
	textDescription TEXT NULL,
	htmlDescription TEXT NULL,
);

CREATE TABLE EmployeeDIM(
	employeeNumber INT NOT NULL PRIMARY KEY,
	lastName VARCHAR(50) NOT NULL,
	firstName VARCHAR(50) NOT NULL,
	extension VARCHAR(10) NOT NULL,
	email VARCHAR(100) NOT NULL,
	reportsTo INT NULL,
	jobTitle VARCHAR(50) NOT NULL
);

CREATE TABLE OfficeDIM (
	officeCode VARCHAR(10) NOT NULL PRIMARY KEY,
	city VARCHAR(50) NOT NULL,
	phone VARCHAR(50) NOT NULL,
	addressLine1 VARCHAR(50) NOT NULL,
	addressLine2 VARCHAR(50) NULL,
	state VARCHAR(50) NULL,
	country VARCHAR(50) NOT NULL,
	postalCode VARCHAR(15) NOT NULL,
	territory VARCHAR(10) NULL
)

CREATE TABLE	TimeDim
	(	[TimeKey] INT primary key, 
		[Date] DATETIME,
		[FullDateUK] CHAR(10), -- Date in dd-MM-yyyy format
		[FullDateUSA] CHAR(10),-- Date in MM-dd-yyyy format
		[DayOfMonth] VARCHAR(2), -- Field will hold day number of Month
		[DaySuffix] VARCHAR(4), -- Apply suffix as 1st, 2nd ,3rd etc
		[DayName] VARCHAR(9), -- Contains name of the day, Sunday, Monday 
		[DayOfWeekUSA] CHAR(1),-- First Day Sunday=1 and Saturday=7
		[DayOfWeekUK] CHAR(1),-- First Day Monday=1 and Sunday=7
		[DayOfYear] VARCHAR(3),
		[WeekOfMonth] VARCHAR(1),-- Week Number of Month 
		[WeekOfQuarter] VARCHAR(2), --Week Number of the Quarter
		[WeekOfYear] VARCHAR(2),--Week Number of the Year
		[Month] VARCHAR(2), --Number of the Month 1 to 12
		[MonthName] VARCHAR(9),--January, February etc
		[MonthOfQuarter] VARCHAR(2),-- Month Number belongs to Quarter
		[Quarter] CHAR(1),
		[QuarterName] VARCHAR(9),--First,Second..
		[Year] CHAR(4),-- Year value of Date stored in Row
		[YearName] CHAR(7), --CY 2012,CY 2013
		[MonthYear] CHAR(10), --Jan-2013,Feb-2013
		[MMYYYY] CHAR(6),
		[FirstDayOfMonth] DATE,
		[LastDayOfMonth] DATE,
		[FirstDayOfQuarter] DATE,
		[LastDayOfQuarter] DATE,
		[FirstDayOfYear] DATE,
		[LastDayOfYear] DATE,
		[IsHolidayUSA] BIT,-- Flag 1=National Holiday, 0-No National Holiday
		[IsWeekday] BIT,-- 0=Week End ,1=Week Day
		[HolidayUSA] VARCHAR(50),--Name of Holiday in US
		[IsHolidayUK] BIT Null,
		[HolidayUK] VARCHAR(50) Null --Name of Holiday in UK
);

CREATE TABLE SalesFacts(
	timeKey INT,
	CustomerNumber INT NOT NULL,
	productCode VARCHAR(15) NOT NULL,
	employeeNumber INT NOT NULL,
	officeCode VARCHAR(10) NOT NULL,
	orderNumber INT NOT NULL,
	Sales MONEY NULL,
	Quantity INT NULL,
	Price FLOAT NULL,
	CONSTRAINT SalesKey PRIMARY KEY (timeKey, CustomerNumber, productCode, employeeNumber, officeCode, orderNumber));

ALTER TABLE SalesFacts  ADD FOREIGN KEY (timeKey) REFERENCES TimeDIM(timeKey);
ALTER TABLE SalesFacts  ADD FOREIGN KEY (CustomerNumber) REFERENCES CustomerDIM(CustomerNumber);
ALTER TABLE SalesFacts  ADD FOREIGN KEY (productCode) REFERENCES ProductDIM(productCode);
ALTER TABLE SalesFacts  ADD FOREIGN KEY (employeeNumber) REFERENCES EmployeeDIM(employeeNumber);
ALTER TABLE SalesFacts  ADD FOREIGN KEY (officeCode) REFERENCES OfficeDIM(officeCode);
ALTER TABLE SalesFacts  ADD FOREIGN KEY (orderNumber) REFERENCES OrderDIM(orderNumber);

/*
DROP TABLE CustomerDIM;
DROP TABLE OrderDIM;
DROP TABLE ProductDIM;
DROP TABLE EmployeeDIM;
DROP TABLE OfficeDIM;
DROP TABLE TimeDIM;
DROP TABLE SalesFacts;
*/
