install.packages('DBI')
install.packages('odbc')
install.packages("RODBC")
library(DBI)
library(odbc)
library(RODBC)
library(ggplot2)

#Visualization 1 :

sql_con <- odbcConnect("SQL")
A1 <- sqlQuery(sql_con,"select * from cm_db.dbo.customers") # assign A1 for Customers table
View(A1)
df<- data.frame(customer<-A1$customerNumber,country<- A1$country) #create data frame and assign variables to it
head(df) # View Data frame
g1<- ggplot(data = df,aes(x=country,y=customer,fill=country))#Using ggplot library for visualization
+geom_bar(stat = 'identity')+theme_minimal()
g1 # View Graph


#Visualization 2 :

D1 <- sqlQuery(sql_con,"select * from cm_db.dbo.orderdetails") # assign D1 for orderdetails table
View(D1)
df<- data.frame(OrderID<- D1$order_id, OrderQuantity <- D1$quantityOrdered) # create data frame and assign variable to it.
head(df) #View Data Frame
p11<- ggplot(data = df,aes(x=OrderQuantity,y=OrderID,fill=OrderQuantity))
+geom_bar(stat = 'identity')+theme_minimal() #Using ggplot library for visualization
p11# View Graph


#Visualization 3:

Em<- sqlQuery(sql_con,"select * from cm_db.dbo.orders") # assign Em for orders table
View(Em)
df<-data.frame(ProductStatus<-Em$status_name,CustomerNumber<- Em$customerNumber)# create data frame and assign variable to it.
head(df)#View Data Frame
dm<- ggplot(data = df,aes(x=ProductStatus,y=CustomerNumber,fill=ProductStatus))
+geom_bar(stat = 'identity')+theme_minimal()#Using ggplot library for visualization
d m# View Graph


#Visualization 4 :

###VisuZ04
Ships=length(which(pro$productLine=='Ships'))
ClassicCars=length(which(pro$productLine=='Classic Cars'))
Motorcycles=length(which(pro$productLine=='Motorcycles'))
Planes=length(which(pro$productLine=='Planes'))
Trains=length(which(pro$productLine=='Trains'))
TnB=length(which(pro$productLine=='Trucks and Buses'))
Vcars=length(which(pro$productLine=='Vintage Cars'))
pline=c('Ships','ClassicCars','Motorcycles','Planes','Trains','TnB','Vcars')
pline=c(Ships,ClassicCars,Motorcycles,Planes,Trains,TnB,Vcars)
pie(pline)

pie(c(length(which(pro$productLine=='Ships')),
      length(which(pro$productLine=='Classic Cars')),
      length(which(pro$productLine=='Motorcycles')),
      length(which(pro$productLine=='Planes')),
      length(which(pro$productLine=='Trains')),
      length(which(pro$productLine=='Trucks and Buses')),
      length(which(pro$productLine=='Vintage Cars')),
      labels=('Ships','ClassicCars','Motorcycles','Planes','Trains','TnB','Vcars')))

####pie(pline,labels=c('Ships','ClassicCars','Motorcycles','Planes','Trains','TnB','Vcars'))   


