# Project Background
One of my modules for Year 2 is **Data Engineering (aka DENG)** where I had to **design 3 databases from scratch over 2 months** based on a given problem statement...

## Problem Statement
Classic Cars Pte Ltd is a retailer of toys specializing in scale car models. Currently, they are using an **OLTP** system in their day-to-day operations and recently, the CEO has decided to setup a data warehouse for analysis purpose, and he wants you to **design a star/snowflake schema, setup the OLTP database and create a data warehouse that can generate meaningful insights in the areas of Sales, Staff/Offices, Seasons of Sales and Orders/Customer**.

## Database Features

It consists of 8 tables: 
- Offices
- Employees
- Orders
- Order Details
- Payments
- Products
- Product Lines
- Customers

## Project Setup

### In Microsoft SQL Server,

1. Download the zipped files.

2. Click on **Connect** and **right click on Databases** to create a **new schema** called `CarSalesOLTP` to represent the OLTP database.

3. **Right click on Databases** again to create another **new schema** called `CarSalesDW` to represent the data warehouse.

4. **Double click on** `CarSalesOLTP` to make it the working database and run the SQL statements by clicking on **Execute**.

5. **Double click on** `CarSalesDW` to make it the working database and run the SQL statements by clicking on **Execute**.

### In Databricks,

1. Download the zipped files.

2. Click on **Clusters > Create New Cluster**. Give it a meaningful name and **select the default choice as the Databricks Runtime Version**. Wait for abotut 3 minutes for the cluster to connect with the server.

3. Click on **Workspace and right click again to create a new folder**. Attach the folder to the previously created cluster.

### Snowflake Schema

Explanation for ```CarSalesDW.erd```: 

> The initial design was that of a star schema, however after encountering errors related to duplicated records in the customer and orders dimension tables, these two tables are identified as the ones that need to be **primary dimension tables that have secondary dimension tables** called CustomerPayment and OrderLine to insert data such as cheque payment and order line details respectively.

> The **participation constraints between the CustomerDIM to CustomerPaymentDIM is optional** as not every customer owes the company payment. However, the **participation constraints between the OrderDIM to OrderLineDIM is compulsory** as every order will belong to a certain order line. The remaining 4 dimension tables are called Office, Employee, Product and Time and exist only as primary dimension tables.

Although the **time taken to execute the SQL queries will be longer due to the use of more JOIN clauses**, a snowflake schema is still more suitable when building a data warehouse as it **prevent duplication errors in the long run**.

### Other Notes

1. Order of SQL for **both OLTP database and Data Warehouse**: `Create > Insert > Select`.

2. For `Insert` to **OLTP database**, insert in the order: `Customers.csv > Assignment_INSERT_data_partial_OLTP.sql > Products.json`. 

3. For `Insert` to **Data Warehouse**, insert in the order: `Data Warehouse Create > Time Create > Data to Dimension Table > Data to Fact Table`.

4. This project has **no association to Classic Cars Pte Ltd in real life**.
