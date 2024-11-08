# LuminaTech Lighting: Data-Driven Insights into Sales, Profitability, and Customer Retention

**Group Number**: 46  
**Members**:  
- Pradyot Jain (48479985)  
- Rakshitha Kundapura Raghavendra (48355631)  
- Harshit Arora (47971614)  

## Project Overview

This project analyzes LuminaTech Lighting’s data across multiple dimensions, including sales, customer retention, product profitability, and predictive modeling. Our goal was to derive actionable insights for strategic decision-making, leveraging data from 2012 and 2013 to inform inventory, marketing, and customer engagement strategies for 2014 and beyond.

## Data Source

The dataset for this analysis can be accessed and downloaded from the following link:  
[Data Source](https://drive.google.com/drive/folders/1QhezmGDCDBspTEbGedXrDX_XXNnBssMQ?usp=drive_link)

## Project Sections

### 1. Data Cleaning and Preparation
- **Dropping Unnecessary Columns**: Removed columns with irrelevant information for sales and customer analysis.
- **Handling Missing and Duplicate Values**: Addressed missing values and standardized data fields.
- **Currency Standardization**: Converted all financial data to AUD for consistency.
- **Data Type Conversion**: Adjusted data types to improve processing efficiency.
- **Outlier Treatment and Skewness Adjustment**: Used log transformations and IQR to manage skewed data and remove extreme outliers.

### 2. Exploratory Insights
- **Top-Selling Products**: Identified top products by revenue and quantity sold, providing insights for inventory management.
- **Product Profitability**: Analyzed profitability by product groups, helping management focus on the most lucrative items.
- **Sales Trends Over Time**: Compared monthly sales for 2012 and 2013 to detect seasonal patterns and inform inventory planning.
- **Customer Retention Rate**: Calculated retention rates, highlighting strong customer loyalty with opportunities for re-engagement.
- **Profitability by Customer District**: Identified high-profit districts, guiding targeted marketing and resource allocation.

### 3. Statistical Analysis
- **District Profit Analysis**: Tested for differences in profitability between high-performing and low-performing districts.
- **Price and Sales Volume Analysis**: Examined if pricing impacts sales volume, supporting optimal pricing strategy decisions.

### 4. Inference
- What are the primary factors that drive sales revenue?
- What factors influence the variability in unit price across different transactions?

### 5. Predictive Modeling
- **Sales Prediction for 2014**: Developed a Random Forest Regressor to predict 2014 sales, achieving high accuracy and enabling data-driven planning.

### 6. Customer Churn Analysis
- **Churn Definition**: Defined churn based on a 60-day inactivity threshold. However, findings suggest revisiting this timeframe for more accurate churn identification.
- **Churn Prediction**: Trained a model to predict churn factors, identifying features influencing customer attrition.

## Libraries Used

The following Python libraries were utilized in this analysis:

- **pandas**: For data cleaning and manipulation.
- **numpy**: For numerical operations and handling missing data.
- **matplotlib** and **seaborn**: For data visualization.
- **scipy**: For statistical testing.
- **statsmodels**: For OLS regression in revenue and pricing analysis.
- **sklearn**: For machine learning models, including Random Forests and data encoding.

## Key Findings

- **High Retention and Profitability in Core Products**: Specific products and districts consistently contributed to high sales and profitability, suggesting focal areas for resource allocation.
- **Seasonal Sales Patterns**: Mid-year peaks indicate opportunities for targeted sales and marketing campaigns.
- **Pricing and Volume**: Higher-priced items generally showed lower sales volume, validating the need for competitive pricing in certain segments.
- **Predictive Accuracy**: The Random Forest model proved effective for forecasting sales, supporting proactive planning.

## Future Recommendations

1. **Refine Churn Threshold**: Extend the churn threshold to better capture infrequent purchasing patterns.
2. **Expand Predictive Models**: Continue exploring additional variables to further enhance predictive accuracy.
3. **Focus on High-Profit Segments**: Prioritize high-demand products and regions, ensuring optimized resource allocation and marketing efforts.

## Usage Instructions

1. **Install Required Libraries**:
   ```bash
   pip install pandas numpy matplotlib seaborn scipy statsmodels scikit-learn
2. Run the Analysis:
  - Follow the project notebook steps to load, clean, analyze, and visualize data.
  - Review key insights in sections related to sales trends, customer retention, and profitability.

Acknowledgments
This project was completed as part of an academic requirement, leveraging OpenAI GPT-based tools for drafting and proofreading. Special thanks to our group members for their collaboration and contributions.

