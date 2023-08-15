library(DBI)
library(RSQLite)
library(sqldf)
# Choose a name of my database and supply the filename to dbConnect()
# To create a new SQLite database, we need to use the dbConnect() function.
Tiny_Clothes <- dbConnect(RSQLite::SQLite(), "Tiny_Clothes.sqlite")

# Import all files into RStudio
CUSTOMER <- read.csv("/Users/sarah/Documents/notes/PSTAT 10 HW/Tinyclothes Database Files-20230228/CUSTOMER.txt")
EMPLOYEE <- read.csv("/Users/sarah/Documents/notes/PSTAT 10 HW/Tinyclothes Database Files-20230228/EMPLOYEE.txt")
DEPARTMENT <- read.csv("/Users/sarah/Documents/notes/PSTAT 10 HW/Tinyclothes Database Files-20230228/DEPARTMENT.txt")
PRODUCT <- read.csv("/Users/sarah/Documents/notes/PSTAT 10 HW/Tinyclothes Database Files-20230228/PRODUCT.txt")
SALES_ORDER <- read.csv("/Users/sarah/Documents/notes/PSTAT 10 HW/Tinyclothes Database Files-20230228/SALES_ORDER.txt")
SALES_ORDER_LINE <- read.csv("/Users/sarah/Documents/notes/PSTAT 10 HW/Tinyclothes Database Files-20230228/SALES_ORDER_LINE.txt")
INVOICES <- read.csv("/Users/sarah/Documents/notes/PSTAT 10 HW/Tinyclothes Database Files-20230228/INVOICES.txt")
EMPLOYEE_PHONE <- read.csv("/Users/sarah/Documents/notes/PSTAT 10 HW/Tinyclothes Database Files-20230228/EMPLOYEE_PHONE.txt")
STOCK_TOTAL <- read.csv("/Users/sarah/Documents/notes/PSTAT 10 HW/Tinyclothes Database Files-20230228/STOCK_TOTAl.txt")

# Write all R data frames into my SQLite database with dbWriteTable()
dbWriteTable(Tiny_Clothes,"DEPARTMENT", DEPARTMENT) 
dbWriteTable(Tiny_Clothes,"CUSTOMER", CUSTOMER) 
dbWriteTable(Tiny_Clothes,"EMPLOYEE", EMPLOYEE) 
dbWriteTable(Tiny_Clothes,"PRODUCT", PRODUCT) 
dbWriteTable(Tiny_Clothes,"SALES_ORDER", SALES_ORDER) 
dbWriteTable(Tiny_Clothes,"SALES_ORDER_LINE", SALES_ORDER_LINE) 
dbWriteTable(Tiny_Clothes,"INVOICES", INVOICES) 
dbWriteTable(Tiny_Clothes,"EMPLOYEE_PHONE", EMPLOYEE_PHONE) 
dbWriteTable(Tiny_Clothes,"STOCK_TOTAL", STOCK_TOTAL) 

# List the tables in your database using dbListTables()
dbListTables(Tiny_Clothes)

# How many rows are in each table? 
dbGetQuery(Tiny_Clothes, "select count(*) as numrows from DEPARTMENT")
dbGetQuery(Tiny_Clothes, "select count(*) as numrows from CUSTOMER")
dbGetQuery(Tiny_Clothes, "select count(*) as numrows from EMPLOYEE")
dbGetQuery(Tiny_Clothes, "select count(*) as numrows from PRODUCT")
dbGetQuery(Tiny_Clothes, "select count(*) as numrows from SALES_ORDER")
dbGetQuery(Tiny_Clothes, "select count(*) as numrows from SALES_ORDER_LINE")
dbGetQuery(Tiny_Clothes, "select count(*) as numrows from INVOICES")
dbGetQuery(Tiny_Clothes, "select count(*) as numrows from EMPLOYEE_PHONE")
dbGetQuery(Tiny_Clothes, "select count(*) as numrows from STOCK_TOTAL")

# OPTIONAL QUESTIONS 
# 1) Retrieve all distinct employee names of employees 
dbGetQuery(Tiny_Clothes, "select NAME as NAME from EMPLOYEE")
# dbGetQuery(Tiny_Clothes,'SELECT NAME FROM EMPLOYEE WHERE NAME')

# 2) Find the name of all the departments that begin with the letter 'S' 
# and contain the letter 'r'. Will the query give the same result if you use "R"
# instead of 'r'? 

# The LIKE Operator: % wildcard
# p% pattern will match any strings that begin with p
## the %al partment matches any string that ends with al 
dbGetQuery(Tiny_Clothes, 'SELECT NAME FROM DEPARTMENT
           WHERE NAME LIKE "S%" AND NAME LIKE "%r%"')
# same if you use caps and lowercase for 'R' and 'r' 
dbGetQuery(Tiny_Clothes, 'SELECT NAME FROM DEPARTMENT 
          WHERE NAME LIKE "S%" AND NAME LIKE "%R%"')

dbGetQuery(Tiny_Clothes, 'SELECT NAME FROM DEPARTMENT 
          WHERE NAME LIKE "S%R%"') # same

# 3) Does ‘Tiny clothes’ sell white socks?
dbGetQuery(Tiny_Clothes, 'SELECT NAME, COLOR FROM PRODUCT 
           WHERE (NAME IS "SOCKS") AND (COLOR IS "WHITE")')
# yes, it sells white socks 

# 3) Does ‘Tiny clothes’ sell white socks?
dbGetQuery(Tiny_Clothes, 'select NAME, COLOR from PRODUCT 
           where (NAME is "SOCKS") and (COLOR is "WHITE")')
# comma is necessary so it select the NAME and the COLOR 

# 4) How old is the employee named 'BROWN'? 
dbGetQuery(Tiny_Clothes,'SELECT AGE FROM EMPLOYEE 
           WHERE (NAME is "BROWN") ')

# 5) Find the employee numbers of all employees whose name
# contains the letter "R" 
dbGetQuery(Tiny_Clothes, 'SELECT EMP_NO FROM EMPLOYEE
           WHERE NAME LIKE "%R%"')

# 6)  Find the name, age and employee numbers of 
# all employees except those whose age is 21.
dbGetQuery(Tiny_Clothes,'SELECT NAME, AGE, EMP_NO 
FROM EMPLOYEE WHERE (AGE IS NOT "21")')

dbGetQuery(Tiny_Clothes,'SELECT NAME, AGE, EMP_NO 
FROM EMPLOYEE WHERE (AGE <> "21")') #same

dbGetQuery(Tiny_Clothes,'SELECT NAME, AGE, EMP_NO 
FROM EMPLOYEE WHERE (AGE != "21")') #same

# 7) What are the names of the departments in 'Tiny Clothes'?
dbGetQuery(Tiny_Clothes, 'SELECT NAME FROM DEPARTMENT ')

# 8) On what date did customer C3 place their order?
dbGetQuery(Tiny_Clothes,'SELECT DATE FROM SALES_ORDER 
           WHERE (CUST_NO IS "C3")')  
# Customer C3 placed their order on 7/9/19

# 9) Which products are available in white?
dbGetQuery(Tiny_Clothes,'SELECT NAME FROM PRODUCT WHERE (COLOR = "WHITE") ')  
# SOCKS and SHIRTS are available in white.

## 10. Which office does employee E2 occupy?
dbGetQuery(Tiny_Clothes,'SELECT OFFICE FROM EMPLOYEE_PHONE WHERE (EMP_NO IS "E2")')  
# The employee E2 occupies R10 office.