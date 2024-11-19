# Assignment 01: Customer Shopping Data Analysis

**Author**: Pradyot Jain  
**Student ID**: 48479985  
**Assignment Number**: 01  

## Project Overview

In this project, I analyze customer shopping data to uncover insights into consumer behavior, demographics, and purchasing patterns. The data spans various attributes, such as customer demographics, purchase categories, payment methods, and shopping mall locations. This analysis is part of an academic assignment, where I explore and process data to generate meaningful insights. Through this notebook, I aim to address specific questions about customer behavior and transaction patterns using Python.

## Dataset Details

The dataset used is `customer_shopping_data.csv`, and each column is described below:

- **invoice_no**: A nominal identifier for each transaction, comprising the letter 'I' followed by a 6-digit integer.
- **customer_id**: A unique nominal identifier for each customer, comprising the letter 'C' followed by a 6-digit integer.
- **gender**: Gender of the customer, represented as a string.
- **age**: Age of the customer, represented as a positive integer.
- **category**: Category of the purchased product, represented as a string (e.g., Clothing, Shoes).
- **quantity**: Quantity of items purchased in each transaction, represented as a numeric value.
- **price**: Unit price of the product in Turkish Liras (TL), represented as a numeric value.
- **payment_method**: Payment method used for the transaction, represented as a string (options include cash, credit card, or debit card).
- **invoice_date**: Date of the transaction, represented as a string in day-month-year format.
- **shopping_mall**: Name of the shopping mall where the transaction took place, represented as a string.

## Libraries Used

In this analysis, I used the following Python libraries:

- **pandas**: For data loading, manipulation, and basic analysis tasks.
- **numpy**: For numerical operations and data handling.
- **matplotlib**: For creating visualizations to better understand the data.
- **seaborn**: For advanced statistical data visualization and enhanced plots.

## Notebook Sections

### 1. **Data Loading**
   - I started by importing necessary libraries and loading the `customer_shopping_data.csv` file. Using `pandas`, I read the CSV file and displayed a few rows to understand the dataset's structure.

### 2. **Data Exploration**
   - I conducted initial data exploration by checking column names, data types, and inspecting unique values for categorical fields like `gender`, `category`, and `payment_method`.

### 3. **Analysis and Insights**
   - As I delve deeper into the assignment, I plan to analyze specific aspects of the data. This may include customer demographics, spending patterns based on age and gender, and a breakdown of purchases across different product categories and shopping malls. Additionally, I will investigate payment method preferences and how these vary across different customer groups and transaction types.

### 4. **Visualization**
   - I use `matplotlib` and `seaborn` for visualizing trends and patterns in the data, providing graphical insights into aspects like age distribution, spending patterns, and category-wise sales.

## Usage Instructions

To replicate this analysis, follow these steps:

1. Install required libraries:

   ```bash
   pip install pandas numpy matplotlib seaborn
2. Run each code cell in sequence. The notebook first loads the data, and subsequent cells explore and analyze various aspects of the dataset.

3. Load and inspect the dataset. You can start by examining the first few rows and proceed with further analysis.
