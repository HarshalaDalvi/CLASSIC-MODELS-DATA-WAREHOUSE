use[cm_dw]
go

CREATE TABLE  Dim_customers  
(
   customerNumber int NOT NULL identity,
   customerName  varchar(50) NOT NULL,
   contactLastName  varchar(50) NOT NULL,
   contactFirstName  varchar(50) NOT NULL,
   city  varchar(50) NOT NULL,
   country  varchar(50) NOT NULL,
   creditLimit  decimal(10,2) DEFAULT NULL,
  PRIMARY KEY ( customerNumber )
 
)

CREATE TABLE  Dim_employees  
(
   employeeNumber int NOT NULL identity,
   lastName  varchar(50) NOT NULL,
   firstName  varchar(50) NOT NULL,
  PRIMARY KEY ( employeeNumber )
)

CREATE TABLE  Dim_offices  (
   officeCode  int NOT NULL identity,
   city  varchar(50) NOT NULL,
   state_name  varchar(50) DEFAULT NULL,
   country  varchar(50) NOT NULL,
  PRIMARY KEY ( officeCode )
)


CREATE TABLE  Dim_products  (
   productCode  varchar(50) NOT NULL,
   productName  varchar(MAX) NOT NULL,
   productLine varchar(MAX) NOT NULL,
   quantityInStock int NOT NULL,
   buyPrice  decimal(10,2) NOT NULL,
   MSRP  decimal(10,2) NOT NULL,
  PRIMARY KEY ( productCode )
  
)

create table Dim_ProductLines
(
p_id int not null identity,
productLine varchar(MAX),

constraint pid_PK primary key(p_id)
)

CREATE TABLE  Dim_orders  
(
   orderNumber int NOT NULL identity,
   orderDate  date NOT NULL,
   requiredDate  date NOT NULL,
   shippedDate  date DEFAULT NULL,
   status_name  varchar(MAX) NOT NULL,
  PRIMARY KEY ( orderNumber )
  
)

CREATE TABLE  Dim_orderdetails  
(
   order_id int NOT NULL identity,
   productCode  varchar(50) NOT NULL,
   quantityOrdered int NOT NULL,
   priceEach  decimal(10,2) NOT NULL,
  PRIMARY KEY ( order_id )
  )


  CREATE TABLE  Dim_payments  
  (
   checkNumber  varchar(50) NOT NULL,
   paymentDate  date NOT NULL,
   amount  decimal(10,2) NOT NULL,
  PRIMARY KEY ( checkNumber )
)

use[cm_dw]
go

create table ProductsFact
(
customerNumber int not null,
productCode varchar(50) not null,
orderNumber int not null,
order_id int not null,
TopExpensiveProducts varchar(MAX),
AvailableQuantityOfProducts varchar(MAX),
creditLimitpercust varchar(MAX),


constraint productfact_compositeKey Primary key clustered(customerNumber,productCode,orderNumber,order_id)
)


create table TempProductFact
(
customerNumber int not null,
employeeNumber int not null,
officeCode int not null,
productCode varchar(50) not null,
p_id int not null,
orderNumber int not null,
order_id int not null,
checkNumber varchar(50) not null,
TopProductBuyer varchar(MAX),
ExpensiveProducts varchar(MAX),
PopularProducts varchar(MAX),
ProductDemand varchar(MAX),

constraint tempfact_compositeKey Primary key clustered(customerNumber,employeeNumber,officeCode,productCode,p_id,orderNumber,order_id,checkNumber)

)




select * from Dim_customers;
select * from Dim_employees;
select * from Dim_offices;
select * from Dim_orderdetails;
select * from Dim_orders;
select * from Dim_payments;
select * from Dim_ProductLines;
select  * from Dim_products;


/*  
-----query to populate DimTables-----

 select distinct customerNumber,customerName,contactLastName,contactFirstName,city,country,creditLimit from customers;
 select distinct employeeNumber,firstname,lastname from employees;
 select distinct officeCode,city,state_name,country from offices;
 select distinct productCode,productName,productLine,quantityInStock,buyPrice,MSRP from products;
 select distinct p_id,productLine from ProductLines;
 select distinct orderNumber,orderDate ,requiredDate ,shippedDate,status_name from orders;
 select distinct  order_id,productCode,quantityOrdered,priceEach from orderdetails;
 select distinct checkNumber,paymentDate,amount from payments;
 */



 ---- query to populate FactTable ------
 /*
Select p.productCode,    
    
(Select count(order_id) from [cm_dw].[dbo].[Dim_orderdetails] where productCode=p.productCode ) as NumberOfOrders 
				
				from [cm_dw].[dbo].[Dim_products] as p  
				    Join  [cm_dw].[dbo].[Dim_orderdetails] as o      on o.productCode = p.productCode


					SELECT Dim_products.productCode, Dim_products.MSRP, Dim_customers.customerName, Dim_customers.country, Dim_orderdetails.order_id, Dim_orderdetails.productCode AS Expr1, Dim_orderdetails.quantityOrdered
FROM     Dim_products INNER JOIN
                  Dim_orderdetails ON Dim_products.productCode = Dim_orderdetails.productCode CROSS JOIN
                  Dim_customers



	--select Top 3 MSRP from [cm_dw].[dbo].[Dim_products] where productCode = productCode
     -- group by productCode having count(MSRP)>=90 order by max(MSRP) 




INSERT INTO [dbo].[ProductFact]
 (
customerNumber ,
employeeNumber,
officeCode,
productCode ,
p_id ,
orderNumber,
order_id ,
checkNumber ,
TopProductBuyer,
ExpensiveProducts,
PopularProducts,
ProductDemand,
)
SELECT 	
		 d_customers.customerNumber
        ,d_employees.employeeNumber
        ,d_offices.officeCode
        ,d_orderdetails.order_id
        ,d_orders.orderNumber
		,d_payments.checkNumber
		,d_ProductLines.p_id
		,d_products.productCode
From (

SELECT  
				 c.customerNumber
				,e.employeeNumber
				,offi.officeCode
				,od.order_id 
				,o.orderNumber
				,pay.checkNumber
				,pl.p_id
				,p.productCode

		from Dim_products p
			
			join Dim_products p				on p.productCode	= p.productCode	
			join Dim_orderdetails od		on od.order_id		= od.productCode
			join Dim_orders o				on o.orderid		= od.orderid
			join Dim_customers c			on c.customerNumber		= o.customerid
			join Dim_employees e            on o.employeeid     =e.employeeid
			join Dim_offices offi		    on c.customerid		= o.customerid
			join Dim_payments pay            on o.employeeid     =e.employeeid
			join Dim_ProductLines pl          on o.employeeid     =e.employeeid
 )
as odb
        join Dim_customers d_customers 	    on d_customers.customerNumber		= odb.customerNumber
		join Dim_products d_products        on d_products.productCode       = odb.productCode
		join Dim_employees d_employees         on d_employees.employeeNumber        = odb.employeeNumber
        join Dim_offices d_offices 	           on d_offices.officeCode	= odb.officeCode
		join Dim_orderdetails d_orderdetails            on  d_orderdetails.order_id	         = odb.order_id
		join Dim_orders d_orders                  on  d_orders.orderNumber	         = odb.orderNumber
	    join Dim_payments d_payments            on  d_payments.checkNumber         = odb.checkNumber
	    join Dim_ProductLines d_productLines            on  d_productLines.p_id	         = odb.p_id
	   join Dim_products d_products           on  d_products.productCode	         = odb.productCode		;	





use[cm_dw]
go


----Expensive Product
Select *  FROM     Dim_orderdetails






SELECT TOP (3) Dim_products.MSRP, Dim_products.productCode, Dim_products.productName, Dim_orderdetails.order_id, Dim_orderdetails.quantityOrdered
FROM     Dim_orderdetails INNER JOIN
                  Dim_products ON Dim_orderdetails.productCode = Dim_products.productCode





---- top product buyer

*/



--Fact table  query---

insert into [cm_dw].[dbo].[ProductsFact]
([customerNumber],[orderNumber],[order_id],[productCode],[TopExpensiveProducts],
[AvailableQuantityOfProducts],
[creditLimitpercust]

)

select p.productCode,
(select top 3 MSRP from [cm_dw].[dbo].[Dim_products] where productCode=p.productCode
 group by productCode having  count(quantityInStock)>1 order by max(quantityInStock)desc
 as expensiveproduct,

 (select count(order_id ) from[cm_dw].[dbo].[Dim_orderdetails] where productCode=p.productCode)
   as  NumberOfOrders,


   (select count(quantityInStock)
   from[cm_dw].[dbo].[Dim_products]
   where productCode=p.productCode
   as availableqtyofproducts,
 
 )







 