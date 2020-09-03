INSERT INTO 
	CarSalesDW..SalesFacts(timeKey, CustomerNumber, productCode, employeeNumber, officeCode, orderNumber, Quantity, Price, Sales)
    
SELECT
	replace(CONVERT(DATE,ord.OrderDate, 112),'-',''),
	 c.customerNumber, 
	 p.productCode, 
	 e.employeeNumber, 
	 o.officeCode, 
	 ord.orderNumber, 
	 od.quantityOrdered, 
	 od.priceEach,
	 (od.quantityOrdered*od.priceEach)

FROM 
CarSalesOLTP..[OrderDetails] od INNER JOIN CarSalesOLTP..[Orders] ord ON od.orderNumber = ord.orderNumber
INNER JOIN CarSalesOLTP..[Customers] c on ord.customerNumber = c.customerNumber
INNER JOIN CarSalesDW..[ProductDIM] p on od.productCode = p.productCode
INNER JOIN CarSalesOLTP..[Employees] e on c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN CarSalesDW..[OfficeDIM] o on o.officeCode = e.officeCode

select * from SalesFacts

select * from TimeDim


--delete from SalesFacts 


