Declare @Product varchar(max)
Select @Product = BulkColumn
	from OPENROWSET(BULK 'CA2_Data\Products.json', SINGLE_BLOB) JSON

INSERT INTO Products 
	Select * from OpenJSON(@Product, '$')
	with (
		productCode VarChar(15) '$.productCode',
		productName VarChar(70) '$.productName',
		productLine VarChar(50) '$.productLine',
		productScale VarChar(10) '$.productScale',
		productVendor VarChar(50) '$.productVendor',
		productDescription VarChar(255) '$.productDescription',
		quantityInStock Integer '$.quantityInStock',
		buyPrice Float(53) '$.buyPrice',
		MSRP Float(53) '$.MSRP'
	)