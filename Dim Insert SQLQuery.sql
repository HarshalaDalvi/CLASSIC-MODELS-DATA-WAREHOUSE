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


INSERT INTO [dbo].Dim_customers (customerNumber,customerName,contactLastName,contactFirstName,city,country,creditLimit) 
 
SELECT DISTINCT customerNumber,customerName,contactLastName,contactFirstName,city,country,creditLimit 
 
FROM [cm_dw].[dbo].[Dim_customers] 





CREATE TABLE  Dim_employees  
(
   employeeNumber int NOT NULL identity,
   lastName  varchar(50) NOT NULL,
   firstName  varchar(50) NOT NULL,
  PRIMARY KEY ( employeeNumber )
)


Insert into [dbo].Dim_employees(employeeNumber,lastName,firstName)
select distinct employeeNumber,lastName,firstName
from [cm_dw].[dbo].[Dim_customers]






CREATE TABLE  Dim_offices  (
   officeCode  int NOT NULL identity,
   city  varchar(50) NOT NULL,
   state_name  varchar(50) DEFAULT NULL,
   country  varchar(50) NOT NULL,
  PRIMARY KEY ( officeCode )
)


insert into [dbo].Dim_offices(officeCode,city,state_name,country)
select distinct officeCode,city,state_name,country 
from [cm_dw].[dbo].[Dim_offices]



CREATE TABLE  Dim_products  (
   productCode  varchar(50) NOT NULL,
   productName  varchar(MAX) NOT NULL,
   productLine varchar(MAX) NOT NULL,
   quantityInStock int NOT NULL,
   buyPrice  decimal(10,2) NOT NULL,
   MSRP  decimal(10,2) NOT NULL,
  PRIMARY KEY ( productCode )
  
)

insert into[dbo].Dim_products(productCode,productName,productLine,quantityInStock,buyPrice,MSRP)
select distinct productCode,productName,productLine,quantityInStock,buyPrice,MSRP
from [cm_dw].[dbo].Dim_products

create table Dim_ProductLines
(
p_id int not null identity,
productLine varchar(MAX),

constraint pid_PK primary key(p_id)
)

insert into[dbo].Dim_ProductLines(p_id,productLine)
select distinct p_id,productLine
from [cm_dw].[dbo].Dim_ProductLines

CREATE TABLE  Dim_orders  
(
   orderNumber int NOT NULL identity,
   orderDate  date NOT NULL,
   requiredDate  date NOT NULL,
   shippedDate  date DEFAULT NULL,
   status_name  varchar(MAX) NOT NULL,
  PRIMARY KEY ( orderNumber )
)

insert into [dbo].Dim_orders(orderNumber,orderDate,requiredDate,shippedDate,status_name)
select distinct 
o.orderNumber,
orderDate,
requiredDate,
shippedDate,
status_name
from [cm_dw].[dbo].Dim_orders















CREATE TABLE  Dim_orderdetails  
(
   order_id int NOT NULL identity,
   productCode  varchar(50) NOT NULL,
   quantityOrdered int NOT NULL,
   priceEach  decimal(10,2) NOT NULL,
  PRIMARY KEY ( order_id )
  )

insert into [dbo].Dim_orderdetails(order_id,productCode,quantityOrdered,priceEach)
select distinct order_id,productCode,quantityOrdered,priceEach
from[cm_dw].[dbo].Dim_orderdetails

  CREATE TABLE  Dim_payments  
  (
   checkNumber  varchar(50) NOT NULL,
   paymentDate  date NOT NULL,
   amount  decimal(10,2) NOT NULL,
  PRIMARY KEY ( checkNumber )
)

insert into [dbo].Dim_payments(checkNumber,paymentDate,amount)
select distinct checkNumber,paymentDate,amount
from [cm_dw].[dbo].Dim_payments


create table ProductFact
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


constraint productfact_compositeKey Primary key clustered(customerNumber,employeeNumber,officeCode,productCode,p_id,orderNumber,order_id,checkNumber)
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
