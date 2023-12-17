# mintclassics_db_analysis
# Mint Classics Inventory Analysis Project

## Overview

This project involves conducting an exploratory data analysis for Mint Classics Company, aimed at supporting inventory-related business decisions that may lead to the closure of a storage facility. As an entry-level data analyst, you'll leverage MySQL Workbench to analyze a relational database, identify insights, and formulate recommendations based on the provided data.

## Project Scenario

Mint Classics, a retailer specializing in classic model cars and vehicles, is considering the closure of one of their storage facilities. To make an informed decision, they seek suggestions for inventory reorganization or reduction while ensuring timely service to customers.

as a data analyst, I will:

- Explore the current inventory.
- Identify factors influencing inventory management.
- Generate insights and recommendations using data analysis.

### Objectives

1. Explore the existing inventory.
2. Determine key factors impacting inventory reorganization.
3. Provide data-driven insights and recommendations.

### Challenge

I'll perform exploratory data analysis using SQL queries to uncover patterns in the provided database. By answering critical questions related to inventory, sales, and product movement, I'll formulate suggestions for inventory reduction and storage facility closure.

## Project Structure

- `data/`: Contains the provided database files.
- `queries/`: Includes SQL queries used for data analysis.
- `reports/`: Documents summarizing findings and recommendations.

## Contributing

Feel free to contribute by suggesting improvements, providing insights, or extending the analysis. Fork this repository, make changes, and submit a pull request.

# Description of data sources  

In this analysis, I am using the provided "mintclassicsDB" from the Coursera project "Analyze Data in a Model Car Database with MySQL Workbench".   
This is a fictional database for learning purposes.  

Previewing the included tables:  

* warehouses - lists the 4 warehouses  
* products - contains information about different model products  
* productlines - descriptions of different product lines  
* orderdetails - order id's, products, quantity, and price  
* orders - also contains order id's, relevant dates, status, and customer id's  
* customers - customer id's with contact information  
* payments - customer id, check id, payment date, amount  
* employees - list of employee information  
* offices - list of 7 offices  

The relevant tables for this project will be:  

- warehouses  

- products  

- orderdetails (more financial information than orders, more descriptive)  

