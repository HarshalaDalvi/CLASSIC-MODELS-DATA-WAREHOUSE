select customerNumber,ordernumber,productcode,order_id from (
select customers.customerNumber,orders.orderNumber,cast(products.productCode as varchar) as productCode,orderdetails.order_id,products.quantityInStock,customers.creditLimit
 from customers_t customers
inner join orders_t orders on customers.customerNumber = orders.customerNumber
inner join ordetails_t orderdetails on orders.orderNumber = orderdetails.orderNumber
inner join products_t products on orderdetails.productCode = products.productCode
) a group by customerNumber,ordernumber,productcode,order_id having count(*) > 1 


select * into temp_fact from (
select customers.customerNumber,orders.orderNumber,cast(products.productCode as varchar) as productCode,orderdetails.order_id,products.quantityInStock,customers.creditLimit
from customers_t customers
inner join orders_t orders on customers.customerNumber = orders.customerNumber
inner join ordetails_t orderdetails on orders.orderNumber = orderdetails.orderNumber
inner join products_t products on orderdetails.productCode = products.productCode
)

