use[cm_db]
go


create table ProductLines
(
p_id int not null identity,
productLine varchar(MAX),
textDescription varchar(MAX),
constraint pid_PK primary key(p_id)
)
go


CREATE TABLE  products  (
   productCode  varchar(50) NOT NULL,
   productName  varchar(MAX) NOT NULL,
   p_id int NOT NULL,
   productLine varchar(MAX) NOT NULL,
   productScale  varchar(MAX) NOT NULL,
   productVendor  varchar(MAX) NOT NULL,
   productDescription  text NOT NULL,
   quantityInStock int NOT NULL,
   buyPrice  decimal(10,2) NOT NULL,
   MSRP  decimal(10,2) NOT NULL,
  PRIMARY KEY ( productCode ),
  CONSTRAINT  products_FK  FOREIGN KEY ( p_id ) REFERENCES  productLines ( p_id )
)

CREATE TABLE  payments  (
   customerNumber int NOT NULL,
   checkNumber  varchar(50) NOT NULL,
   paymentDate  date NOT NULL,
   amount  decimal(10,2) NOT NULL,
  PRIMARY KEY ( checkNumber ),
  CONSTRAINT  payments_ibfk_1  FOREIGN KEY ( customerNumber ) REFERENCES  customers  ( customerNumber )
)


CREATE TABLE  orders  (
   orderNumber int NOT NULL identity,
   orderDate  date NOT NULL,
   requiredDate  date NOT NULL,
   shippedDate  date DEFAULT NULL,
   status_name  varchar(MAX) NOT NULL,
   customerNumber int NOT NULL,
  PRIMARY KEY ( orderNumber ),
  
  CONSTRAINT  cust_FK  FOREIGN KEY (customerNumber) REFERENCES  customers  (customerNumber)
)

CREATE TABLE  orderdetails  (
   orderNumber int NOT NULL,
   productCode  varchar(50) NOT NULL,
   quantityOrdered int NOT NULL,
   priceEach  decimal(10,2) NOT NULL,
  PRIMARY KEY ( order_id ),
  order_id int NOT NULL identity,
  CONSTRAINT  orderdetails_ibfk_1  FOREIGN KEY (orderNumber) REFERENCES  orders (orderNumber),
  CONSTRAINT  orderdetails_ibfk_2  FOREIGN KEY (productCode) REFERENCES  products  (productCode)
)

CREATE TABLE  offices  (
   officeCode  int NOT NULL identity,
   city  varchar(50) NOT NULL,
   phone  varchar(50) NOT NULL,
   addressLine1  varchar(50) NOT NULL,
   state_name  varchar(50) DEFAULT NULL,
   country  varchar(50) NOT NULL,
  PRIMARY KEY ( officeCode )
)

CREATE TABLE  employees  (
   employeeNumber int NOT NULL identity,
   lastName  varchar(50) NOT NULL,
   firstName  varchar(50) NOT NULL,
   email  varchar(100) NOT NULL,
   officeCode  int ,
   reportsTo int DEFAULT NULL,
   jobTitle  varchar(50) NOT NULL,
  PRIMARY KEY ( employeeNumber ),

  CONSTRAINT  employees_ibfk_2  FOREIGN KEY ( officeCode ) REFERENCES offices ( officeCode )
)

CREATE TABLE  customers  
(
   customerNumber int NOT NULL identity,
   customerName  varchar(50) NOT NULL,
   contactLastName  varchar(50) NOT NULL,
   contactFirstName  varchar(50) NOT NULL,
   phone  varchar(50) NOT NULL,
   addressLine1  varchar(50) NOT NULL,
   city  varchar(50) NOT NULL,
   country  varchar(50) NOT NULL,
   employeeNumber  int DEFAULT NULL,
   creditLimit  decimal(10,2) DEFAULT NULL,
  PRIMARY KEY ( customerNumber ),
 
  CONSTRAINT  customers_ibfk_1  FOREIGN KEY (employeeNumber) REFERENCES employees (employeeNumber)
)


-----Select Query-----
use[cm_db]
go

select * from customers;
select * from employees;
select * from offices;
select * from orderdetails;
select * from orders;
select * from payments;
select * from ProductLines;
select * from products;