/* office dim */
INSERT INTO 
	CarSalesDW..OfficeDIM(officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
SELECT 
	officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory
FROM
	CarSalesOLTP..Offices;

/* employee dim */
INSERT INTO 
	CarSalesDW..EmployeeDIM(employeeNumber, lastName, firstName, extension, email, reportsTo, jobTitle)
SELECT 
	employeeNumber, lastName, firstName, extension, email, reportsTo, jobTitle
FROM
	CarSalesOLTP..Employees;

/* product dim */
INSERT INTO
	CarSalesDW..ProductDIM(productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP, textDescription, htmlDescription)
SELECT
	P.productCode, P.productName, L.productLine, P.productScale, P.productVendor, P.productDescription, P.quantityInStock, P.buyPrice, P.MSRP, L.textDescription, L.htmlDescription
FROM 
	CarSalesOLTP..Products P, CarSalesOLTP..ProductLines L
WHERE 
	P.productLine = L.productLine;

/* order dim */
INSERT INTO 
	CarSalesDW..OrderDIM(orderNumber, orderDate, requiredDate, shippedDate, status, comments)
SELECT 
	O.orderNumber, O.orderDate, O.requiredDate, O.shippedDate, O.status, O.comments
FROM 
	CarSalesOLTP..Orders O;

/* order line dim */
INSERT INTO 
	CarSalesDW..OrderLineDIM(orderLineNumber)
SELECT 
	D.orderLineNumber
FROM 
	CarSalesOLTP..OrderDetails D;

/* customer dim */
INSERT INTO 
	CarSalesDW..CustomerDIM(CustomerNumber, customerName, contactLastname, contactFirstname, Phone, addressLine1, addressLine2, city, state , postalCode, country)
SELECT 
	C.CustomerNumber, C.customerName, C.contactLastname, C.contactFirstname, C.Phone, C.addressLine1, C.addressLine2, C.city, C.state , C.postalCode, C.country
FROM 
	CarSalesOLTP..Customers C;

/* customer payment dim */
INSERT INTO 
	CarSalesDW..CustomerPaymentDIM(creditLimit, checkNumber, paymentDate)
SELECT 
	C.creditLimit, P.checkNumber, P.paymentDate
FROM 
	CarSalesOLTP..Customers C, CarSalesOLTP..Payments P
WHERE 
	C.customerNumber = P.customerNumber;