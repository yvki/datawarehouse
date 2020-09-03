Create CarSales OLTP;

Create Table Offices (
	officeCode VarChar(10) Not Null Primary Key,
	city VarChar(50) Not Null,
	phone VarChar(50) Not Null,
	addressLine1 VarChar(50) Not Null,
	addressLine2 VarChar(50) Null,
	state VarChar(50) Null,
	country VarChar(50) Not Null,
	postalCode VarChar(15) Not Null,
	territory VarChar(10) Null
)
Go

Create Table Employees (
	employeeNumber Integer Not Null Primary Key,
	lastName VarChar(50) Not Null,
	firstName VarChar(50) Not Null,
	extension VarChar(10) Not Null,
	email VarChar(100) Not Null,
	officeCode VarChar(10) Not Null,
	reportsTo Integer Null,
	jobTitle VarChar(50) Not Null,
	Foreign Key (officeCode) References Offices(officeCode)
)
Go

Create Table Customers (
	customerNumber Integer Not Null Primary Key,
	customerName VarChar(50) Not Null,
	contactLastName VarChar(50) Not Null,
	contactFirstName VarChar(50) Not Null,
	phone VarChar(50) Not Null,
	addressLine1 VarChar(50) Not Null,
	addressLine2 VarChar(50) Null,
	city VarChar(50) Not Null,
	state VarChar(50) Null,
	postalCode VarChar(15) Null,
	country VarChar(50) Not Null,
	salesRepEmployeeNumber Integer Null,
	creditLimit Float(53) Not Null,
	Foreign Key (salesRepEmployeeNumber) References Employees(employeeNumber)
)
Go

Create Table Payments (
	customerNumber Integer Not Null,
	checkNumber VarChar(50) Not Null,
	PaymentDate DateTime Not Null,
	amount Float Not Null,
	Primary Key (customerNumber,checkNumber),
	Foreign Key (customerNumber) References Customers(customerNumber)
)
Go

Create Table Orders (
	orderNumber Integer Not Null Primary Key,
	orderDate DateTime Not Null,
	requiredDate DateTime Not Null,
	shippedDate DateTime Null,
	status VarChar(15) Not Null,
	comments Text Null,
	customerNumber Integer Not Null,
	Foreign Key (customerNumber) References Customers(customerNumber)
)
Go

Create Table ProductLines (
	productLine VarChar(50) Not Null Primary Key,
	textDescription Text Null,
	htmlDescription Text Null
)
Go

Create Table Products (
	productCode VarChar(15) Not Null Primary Key,
	productName VarChar(70) Not Null,
	productLine VarChar(50) Not Null,
	productScale VarChar(10) Not Null,
	productVendor VarChar(50) Not Null,
	productDescription Text Not Null,
	quantityInStock Integer Not Null,
	buyPrice Float(53) Not Null,
	MSRP Float(53) Not Null,
	Foreign Key (productLine) References ProductLines(productLine)
)
Go

Create Table OrderDetails (
	orderNumber Integer Not Null,
	productCode VarChar(15) Not Null,
	quantityOrdered Integer Not Null,
	priceEach Float(53) Not Null,
	orderLineNumber SmallInt Not Null,
	Primary Key (orderNumber,productCode),
	Foreign Key (orderNumber) References Orders(orderNumber),
	Foreign Key (productCode) References Products(productCode)
)
Go

Alter table Customers nocheck Constraint all 
Alter table employees nocheck Constraint all
Alter table orderdetails nocheck Constraint all