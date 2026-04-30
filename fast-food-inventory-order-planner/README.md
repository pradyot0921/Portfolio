# Excel Inventory Order Planner

## Project Overview

This project is an Excel-based inventory order planner designed for a fast-food or retail store environment. The workbook calculates recommended order quantities based on current stock, incoming ordered stock, delivery schedule, expected demand, usage rates, and buffer requirements.

The main aim of this project is to reduce stock shortages, avoid unnecessary over-ordering, and make the stock ordering process more structured and consistent.

This is a portfolio version of the workbook. It uses anonymised product names and synthetic sales data, so it does not contain confidential workplace, supplier, customer, or financial information.

---

## Project Files

- [Download the Excel Workbook](fast-food-inventory-order-planner/Fast_Food_Inventory_Order_Planner.xlsx)
- [View Workbook Logic Summary](fast-food-inventory-order-planner/documentation/workbook_logic_summary.pdf)

---

## Workbook Preview

### Order Planner

![Order Planner Preview](fast-food-inventory-order-planner/images/order_planner_preview.png)

### Forecast Model

![Forecast Model Preview](fast-food-inventory-order-planner/images/forecast_preview.png)

### Setup

![Setup Preview](fast-food-inventory-order-planner/images/setup_preview.png)

### Usage Rates

![Usage Rates Preview](fast-food-inventory-order-planner/images/usage_rates_preview.png)

---

## Business Problem

Fast-food and retail stores often need to place stock orders before the next delivery arrives. If ordering is done manually, it can lead to two common problems:

- Under-ordering, which increases the risk of stockouts
- Over-ordering, which increases waste, storage pressure, and unnecessary purchasing

This workbook solves the problem by using a structured Excel model that considers:

- Current stock on hand
- Stock already ordered but not yet received
- Expected demand before delivery
- Expected demand after delivery
- Delivery coverage days
- Demand profile
- Buffer stock requirement

The result is a clear recommended order quantity for each item.

---

## Workbook Features

- Automated order quantity calculation
- Stocktake day and delivery day planning
- Current stock and incoming ordered stock inputs
- Pre-delivery demand calculation
- Delivery coverage demand calculation
- Buffer stock adjustment
- Demand profile logic: Low, Normal, and High
- Forecast-based demand profile selection
- Item status classification: URGENT, ORDER, and OK
- Synthetic historical sales data
- Anonymised product names
- Data validation dropdowns
- Protected formula cells
- User instruction sheet
- Structured Excel tables
- Portfolio-safe workbook design

---

## Workbook Sheets

### 1. Instructions

The Instructions sheet explains how to use the workbook. It provides guidance on which fields should be edited, how to enter stock information, and how to interpret the recommended order quantities.

It also states that the workbook uses anonymised product names and synthetic sales data for portfolio demonstration.

### 2. Order_Planner

The Order_Planner sheet is the main user-facing sheet. Users enter current stock and incoming ordered quantities for each item. The workbook then calculates the required order quantity automatically.

Key inputs include:

- Stocktake Day
- Delivery Day
- Include Delivery Day in Pre-Demand
- Current Stock
- Incoming Ordered

Key outputs include:

- Pre-Delivery Demand
- Coverage Demand
- Adjusted Buffer
- Total Required
- Order Qty
- Status
- Stock Runway
- Projected Stock at Delivery

### 3. Data_Sales

The Data_Sales sheet contains synthetic historical sales data used for demand forecasting. Missing dates represent store-closed days and are intentionally excluded from demand forecasting.

### 4. Usage_Rates

The Usage_Rates sheet stores expected item usage by weekday and demand profile. Each item has usage assumptions for Low, Normal, and High demand conditions.

### 5. Setup

The Setup sheet stores the main planning rules used in the workbook, including delivery days, delivery coverage flags, weekday lists, demand profile multipliers, and profile rules.

### 6. Forecast_Model

The Forecast_Model sheet calculates forecasted weekly demand, compares it with historical baseline sales, and supports demand profile selection.

---

## Workbook Logic

The workbook calculates the recommended order quantity using the following logic:

```text
Projected Stock at Delivery = Current Stock + Incoming Ordered - Pre-Delivery Demand

Total Required = Coverage Demand + Adjusted Buffer

Order Qty = MAX(0, Total Required - Projected Stock at Delivery)
