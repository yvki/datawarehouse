Create Table tempCustomers (
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
	salesRepEmployeeNumber varchar(255) Null,
	creditLimit Float(53) Not Null
)

BULK INSERT tempCustomers 
FROM  'CA2_Data\Customers.csv'
WITH (
	format='CSV',
	fieldquote='"',
	fieldterminator=',',
	rowterminator='\n'
)

Update tempCustomers 
set addressLine2 = NULL
where addressLine2 like 'NULL'

Update tempCustomers 
set state = NULL
where state like 'NULL'

Update tempCustomers 
set salesRepEmployeeNumber = NULL
where salesRepEmployeeNumber like 'NULL'

INSERT INTO Customers Select * from tempCustomers

Drop table tempCustomers