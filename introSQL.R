---
title: "Introduction SQL in RStudio, part 1, student version"
date: May 2019
author: Antoinette Littel
number_sections: true
output: html_notebook

---



<h2> Connecting to the database </h2>

The first chunk in this Notebook will run automatically when you make the SQL statements. It loads the libraries you need and connects to the database 'WPC.db' that should be in your folder. 

```{r setup, , results='hide'}
library(tidyverse)
library(readxl)
library(DBI)

#enable other connections
# dbDisconnect(con)

# connect to CapeCodd
con <- DBI::dbConnect(RSQLite::SQLite(), "WPC.db")
#

#
# use the database connection for all SQL chunks in this notebook 
knitr::opts_chunk$set(connection = "con", echo=TRUE)
```


<h2> Using SQL to produce new data and R for visualization </h1>

You start every SQL chunk with the tag <code>{sql}</code>. See the chunks provided in your Notebook. The SQL statement <code>SELECT *</code> shows all rows in the table 'Project'. Using captital for the SQL keywords is common. It is not necessary. The semi-column is necessary in various databases. R will run without the semi-column, but make a habit our of it to end every SQL statement with the semi-column.

```{sql, connection=con, echo=TRUE}
SELECT
ProjectID, MaxHours
FROM
 Project;
```

We can capture the result of this sql code chunk in a R dataframe. We use <code> {sql, output.var = "df_result"}</code> at the beginning of the chunk to capture the results in the dateframe 'df_result'.


```{sql, connection=con, output.var = "df_result", echo=TRUE}
SELECT *
FROM Project;
```

Proceeding we can use this dataframe as input for ggplot. Use the <code>{r}</code> tag in your chunk to switch to regular R again. Let's visualize the MaxHours per project.

```{r, echo=TRUE}
ggplot(df_result, aes(ProjectID, MaxHours)) +
  geom_col()
```


<h2> database design </h2>

Below is the design of the database. You should have this picture in the images folder of your workdirectory. You can open the picture next to your Notebook, so that you can see the design while creating your queries.




<h2> learn about SQL </h2>
Besides the slides, more information can be found on:
https://www.w3schools.com/sql/
and https://bookboon.com/en/database-design-and-implementation-ebook

<h2> Assignments </h2>
Make a SQL query for the following questions. The desired result is printed below each question. Use ggplot visualization where asked. 

A.	What projects are in the PROJECT table? Show all information for each project.

```{sql, connection=con }

```
<br>
B.	What are the ProjectID, Name, StartDate, and EndDate values of projects in the PROJECT table?


```{sql, connection=con }

```
<br>
C.	What projects in the PROJECT table started before August 1, 2008? Show all the information for each project. (a date has format YYYY-MM-DD and is placed between single quotes)

```{sql, connection=con}

```
<br>
D.	What projects in the PROJECT table have not been completed? Show all the information for each project.


```{sql, connection=con }

```
<br>
E.	Which projects contain the word 'Q3' in the project name and have been started in august 2008? Show the project ID, project Name and Start Date. (Wildcards in SQLite are % for 0 or more characters and _ to match 1 character)


```{sql, connection=con }

```
<br>


F.	Make a list of all different first names of employees. Order them alphabetically from Z to A.

```{sql, connection=con }

```
<br>
G. Which employees work for the Administration, Accounting, Production and Legal departments? Show the employee number, first name, last name and department name. Order the results in alphabetical order of the department name and then in alphabetical order of the employee's last name

```{sql, connection=con }


```
<br>
H. How many projects are being run by the marketing department? Be sure to assign an appropriate column name to the computed results.

```{sql, connection=con }

```
<br>
I. What is the total MaxHours of projects being run by the marketing department? Be sure to assign an appropriate column name to the computed results

```{sql, connection=con }

```
<br>
J. What is the average MaxHours of projects being run by the marketing department? Be sure to assign an appropriate column name to the computed results.

```{sql, connection=con }


```
<br>
K. How many projects are being run by each department? Be sure to display each DepartmentName and to assign an appropriate column name to the computed results.

```{sql, connection=con }


```
<br>
L. Which employees have been assigned to at least 2 projects in which he or she has worked at least 20 hours? List the employee number and the number of those projects.

```{sql, connection=con }



```
<br>
M. Which projects are run by a department which uses the budgetcode 'BC-700-10'. Use a subquery.

```{sql, connection=con }



```
<br>

N. Which projects are run by a department with phone number 360-285-8400. Use a subquery.

```{sql, connection=con }



```
<br>
O. What is the minimum and the maximum amount of hours worked by an employee, for each project? List the projectID, the minimum amount of hours worked and the maximum amount of hours worked 

```{sql, connection=con }



```
<br>

P. Which employees are working for office number BLDG01-300? List the employee number, first name and last name. Use a sub-query to solve this exercise.

```{sql, connection=con }


```

<br>
Q. Who are the employees assigned to each project? Show ProjectID, Employee-Number, LastName, FirstName, and Phone.

```{sql, connection=con }



```
<br>
R. Who are the employees assigned to each project? Show the ProjectID, Name, and Department. Show EmployeeNumber, LastName, FirstName, and Phone.

```{sql, connection=con }



```
<br>
S. Who are the employees assigned to each project? Show ProjectID, Name, Department, and Department Phone. Show EmployeeNumber, LastName, FirstName, and Employee Phone. Sort by ProjectID in ascending order.

```{sql, connection=con }


```
<br>
T. Who are the employees assigned to projects run by the marketing department? Show ProjectID, Name, Departmentname (of the employee), and Department Phone. Show EmployeeNumber, LastName, FirstName, and Employee Phone. Sort by ProjectID in ascending order.

```{sql, connection=con }


```
<br>
U. Which employees have been assigned to a project? Show the employee number, first name and last name. Make 2 different queries to solve this problem!

```{sql, connection=con}


```
<br>

```{sql, connection=con }


```
<br>
V. List the employees that have worked in total more than 100 hours for marketing projects. List the employee number, last name, first name and the total amount of hours worked for marketing projects

```{sql, connection=con }


```
<br>
<h2> Extra assignments to practice more</h2>
Per topic are extra assignments.
<br>
<h3>subqueries</h3>
E1. List the emailadresses of employees working in the department with phone '360-285-8400'
```{sql, connection=con }



```

E2. List the StartDate of projects that were assigned to employees with the firstname 'Tom'. 

```{sql, connection=con  }



```
<br>
<h3>GROUP BY</h3>
E3. Count the number of projects per department.

```{sql, connection=con }


```
<br>
E4. Count the number of employees per project.

```{sql, connection=con  }



```

E5. Give the total hours worked per project.

```{sql, connection=con  }



```

<h2> Challenging assignments</h2>



C1. Now use the query results of assignment R to visualize the number of project per department with <code> ggplot </code>. Make two chunks: a sql chunk and a R chunk.

```{sql, connection=con, output.var = "df_result", }



```
Remember to use the <code>{r}</code> tag in your chunk to switch to regular R again. 

```{r}

```
<br>
C1. Visualize the output of query W. Below is an example, but you may decide how to visualize.


<br>
