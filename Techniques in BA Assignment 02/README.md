# Koala’s Physical Characteristics Analysis

**Author**: Pradyot Jain  
**Student Number**: 48479985  
**Assignment Number**: 02  
**Word Count**: 1912  

## Project Overview

In this project, I perform an in-depth analysis of koalas' physical characteristics to understand patterns and adaptations based on environmental factors. This analysis covers data cleaning, exploratory data analysis, handling outliers, and performing statistical tests. Additionally, I explore relationships between physical traits, using visualization and predictive modeling to derive insights about koala health and habitat-specific adaptations.

## Dataset Details

The dataset used includes various physical measurements and identifiers for individual koalas. Here are the main columns:

- **koala_id**: Unique identifier for each koala.
- **gender**: Gender of the koala.
- **age**: Age of the koala in years.
- **habitat**: Habitat type, categorized by region (e.g., QLD, VIC).
- **paw_size**: Paw size measurement in centimeters.
- **head_length**: Length of the head in centimeters.
- **ear_size**: Size of the ear in centimeters.
- **skull_width**: Width of the skull in centimeters.
- **eye_diameter**: Diameter of the eye in centimeters.
- **chest_circumference**: Chest circumference measurement.
- **belly_circumference**: Belly circumference measurement.

## Analysis Steps

1. **Exploratory Data Analysis**: 
   - **Missing Values**: Filled missing values based on central tendencies within categories like gender, habitat, and region.
   - **Duplicate Rows**: Verified uniqueness of koala IDs to ensure data integrity.
   - **Data Type Conversions**: Converted non-numeric columns (e.g., `gender`, `habitat`) to categorical types.

2. **Outlier Analysis**:
   - Applied interquartile range (IQR) methods and reviewed distributions via boxplots and histograms.
   - Retained biologically plausible outliers but removed values that were likely data entry errors, ensuring that outlier management did not distort biological trends.

3. **Data Visualization**:
   - **Boxplots**: Used to compare physical attributes like total length across genders.
   - **Heatmaps**: Displayed correlations between physical traits, highlighting relationships between attributes like head length, skull width, and chest circumference.

4. **Statistical Analysis**:
   - Conducted t-tests to assess mean differences in attributes (e.g., head length across genders).
   - Built predictive models using Ordinary Least Squares (OLS) regression to predict koala length based on other traits, obtaining moderate R-squared values that suggest further variables may improve predictive power.

5. **Environmental Influence Analysis**:
   - Analyzed variations in physical traits across habitats using group statistics and violin plots, which revealed environmental adaptation patterns in traits like paw size, chest circumference, and head length.

## Libraries Used

- **pandas**: For data manipulation and cleaning.
- **numpy**: For numerical operations and handling missing values.
- **matplotlib** and **seaborn**: For data visualization, including histograms, boxplots, and heatmaps.
- **scipy**: For conducting statistical tests, including t-tests.
- **statsmodels**: For performing OLS regression analysis to assess predictors of koala length.

## Key Findings

- **Outliers**: Outliers in variables like head length and ear size were removed when deemed biologically implausible, whereas plausible high values were retained.
- **Sexual Dimorphism**: Male koalas generally have larger body lengths, supporting dimorphic characteristics.
- **Environmental Impact**: Koalas in different habitats exhibit adaptations in paw size and chest circumference, likely due to environmental factors.
- **Predictive Modeling**: Head length, skull width, and chest circumference are significant predictors of total koala length.

## Conservation Insights

The analysis indicates distinct adaptations in koalas based on habitat, suggesting the need for region-specific conservation strategies. Conservation efforts should focus on habitat preservation, food supply assurance, and minimizing habitat fragmentation. Monitoring physical traits offers a practical approach to assess population health and guide conservation strategies.

## Usage Instructions

1. Install the required libraries:

   ```bash
   pip install pandas numpy matplotlib seaborn scipy statsmodels
2. Run the notebook cells sequentially. Each step includes data loading, cleaning, analysis, and visualization to examine the dataset and perform statistical testing.

3. Analyze visualizations and model outputs to interpret koala traits across different environmental settings.

## Acknowledgments
I used GPT-based tools for drafting and proofreading this assignment as permitted in the assignment instructions.
