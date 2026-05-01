# Dashboard Methodology

## Project Objective

The objective of this dashboard is to analyse South Australian electricity market performance across selected generation technologies from July 2022 to June 2024.

The dashboard evaluates how different generation technologies performed in terms of revenue, generation volume, dispatch-weighted capture price, market benchmark price comparison, utilisation, revenue volatility, negative price exposure, dispatch timing and estimated carbon emissions.

The analysis focuses on five generation technologies:

- Natural Gas
- Wind
- Solar
- Battery Storage
- Diesel

The final dashboard is designed as an executive-style Power BI portfolio project that demonstrates data preparation, DAX modelling, data visualisation and business insight communication.

---

## Dashboard Structure

The Power BI dashboard is structured into four pages:

1. **Market Overview**
2. **Technology Risk**
3. **Dispatch and Emissions**
4. **Key Findings and Strategic Insights**

Each page answers a different analytical question.

### 1. Market Overview

This page provides a high-level summary of the South Australian electricity market performance during the analysis period.

It includes:

- Total revenue
- Total generation
- Time-weighted average price
- Market volume-weighted price
- Negative price intervals
- Dispatch-weighted capture price by technology
- Monthly revenue trends
- Annual revenue by technology
- Generation mix by technology

### 2. Technology Risk

This page compares technology-level performance, utilisation and risk.

It includes:

- Revenue risk vs return profile
- Capacity factor by technology
- Negative price exposure by technology
- Capture ratio by technology
- Selected revenue, generation, capture price and negative exposure KPIs

### 3. Dispatch and Emissions

This page analyses hourly dispatch behaviour and estimated emissions impact.

It includes:

- Hourly dispatch timing vs market price
- Estimated total carbon emissions by technology
- Carbon emission intensity by technology
- Selected emissions, revenue, generation and capture price KPIs

### 4. Key Findings and Strategic Insights

This page summarises the key insights and recommendations from the analysis.

It focuses on:

- Revenue concentration in dispatchable generation
- Premium price capture by diesel and battery storage
- Negative price exposure for solar and wind
- Relationship between utilisation and revenue
- Emissions impact of natural gas and diesel
- Strategic role of flexible dispatch and storage

---

## Data Source and Scope

The analysis uses interval-level South Australian electricity market data covering the period:

```text
1 July 2022 to 30 June 2024
```

The dataset includes market price, demand, generation dispatch values and technology-level calculations for selected generators. The analysis period covers two financial years:

- FY2022-23
- FY2023-24

The final analysis table contains:

- 210,527 interval-level records

The dataset was prepared in Excel and modelled in Power BI.

---

## Data Preparation

The dataset was cleaned and structured before importing into Power BI. The final cleaned table was used as the main fact table for the dashboard.

Key preparation steps included:

- Ensuring settlement date fields were correctly formatted as date/time values.
- Creating date, year, month, quarter and financial year fields.
- Grouping generator-level columns into technology-level categories.
- Converting dispatch from MW into MWh.
- Calculating revenue using dispatch MWh and South Australian spot price.
- Creating technology-level generation and revenue measures.
- Creating market price benchmark measures.
- Creating emissions estimates using technology-level emissions intensity assumptions.

### Energy Conversion Method

The dataset uses five-minute interval dispatch data. Dispatch values in MW were converted into MWh using the following formula:

```text
MWh = MW × 5 / 60
```

This converts power output into energy generated during each five-minute dispatch interval.

### Revenue Calculation

Technology revenue was calculated by multiplying technology-level dispatch energy by the South Australian market price.

```text
Revenue = MWh × SA1 Price
```

This calculation was applied at interval level before aggregating revenue by technology, month, financial year and dashboard filter context.

---

## Core Data Model

The Power BI model uses the cleaned interval-level table as the main fact table.

Main tables used:

| Table | Purpose |
|---|---|
| tbl_CleanedData | Main interval-level fact table |
| DateTable | Date, month, quarter and financial year filtering |
| TechnologyTable | Disconnected technology selector table |
| tbl_Capacity | Capacity factor values |
| tbl_EmissionData | Emission intensity assumptions |
| tbl_risk | Revenue risk and return summary |
| tbl_AnnualSummary | Annual summary validation and comparison |
| tbl_MonthlySummary | Monthly summary validation and comparison |

The main relationship used in the model is:

```text
DateTable[Date] 1 → * tbl_CleanedData[Date]
```

The TechnologyTable was used as a disconnected selector table because the cleaned dataset was structured in wide format, with separate MWh columns for each technology.

Technology-specific measures were created using SUMX, VALUES and SWITCH logic so that visuals and slicers could respond correctly to technology selections.

### Date Table

A custom date table was created in Power BI to support date-based filtering, fiscal year slicing and correct month sorting.

Example DAX:

```dax
DateTable =
ADDCOLUMNS(
    CALENDAR(
        MIN(tbl_CleanedData[Date]),
        MAX(tbl_CleanedData[Date])
    ),
    "Year", YEAR([Date]),
    "Month_No", MONTH([Date]),
    "Month_Name", FORMAT([Date], "MMM"),
    "YearMonth", FORMAT([Date], "MMM yyyy"),
    "YearMonth_No", YEAR([Date]) * 100 + MONTH([Date]),
    "Quarter", "Q" & FORMAT([Date], "Q"),
    "YearQuarter", FORMAT([Date], "YYYY") & "-Q" & FORMAT([Date], "Q"),
    "Fiscal_Year",
        IF(
            MONTH([Date]) >= 7,
            "FY" & RIGHT(YEAR([Date]), 2) & "-" & RIGHT(YEAR([Date]) + 1, 2),
            "FY" & RIGHT(YEAR([Date]) - 1, 2) & "-" & RIGHT(YEAR([Date]), 2)
        )
)
```

The YearMonth field was sorted by YearMonth_No to ensure months appeared in chronological order rather than alphabetical order.

### Technology Table

A disconnected technology table was created to enable technology-level slicers, legends and axis categories.

```dax
TechnologyTable =
DATATABLE(
    "Technology", STRING,
    {
        {"Battery Storage"},
        {"Diesel"},
        {"Natural Gas"},
        {"Solar"},
        {"Wind"}
    }
)
```

This table was intentionally kept disconnected from tbl_CleanedData because the main table was in wide format rather than long format.

---

## Key DAX Measures

### Total Revenue

```dax
Total Revenue =
SUMX(
    tbl_CleanedData,
    (
        tbl_CleanedData[Battery_Total_MWh]
        + tbl_CleanedData[Diesel_Total_MWh]
        + tbl_CleanedData[Gas_Total_MWh]
        + tbl_CleanedData[Solar_Total_MWh]
        + tbl_CleanedData[Wind_Total_MWh]
    )
    * tbl_CleanedData[SA1_Price]
)
```

### Total Generation MWh

```dax
Total Generation MWh =
SUM(tbl_CleanedData[Battery_Total_MWh])
+ SUM(tbl_CleanedData[Diesel_Total_MWh])
+ SUM(tbl_CleanedData[Gas_Total_MWh])
+ SUM(tbl_CleanedData[Solar_Total_MWh])
+ SUM(tbl_CleanedData[Wind_Total_MWh])
```

### Time-Weighted Average Price

The time-weighted average price was calculated as the simple average of all interval-level South Australian spot prices.

```dax
Time Weighted Avg Price =
AVERAGE(tbl_CleanedData[SA1_Price])
```

### Market Volume-Weighted Price

The market volume-weighted price was calculated by weighting South Australian spot price by South Australian demand.

```dax
Market Volume Weighted Price =
DIVIDE(
    SUMX(
        tbl_CleanedData,
        tbl_CleanedData[SA1_Price] * tbl_CleanedData[SA1_Demand]
    ),
    SUM(tbl_CleanedData[SA1_Demand])
)
```

### Technology Generation

```dax
Technology Generation =
SUMX(
    VALUES(TechnologyTable[Technology]),
    VAR SelectedTechnology = TechnologyTable[Technology]
    RETURN
        SWITCH(
            SelectedTechnology,
            "Battery Storage", SUM(tbl_CleanedData[Battery_Total_MWh]),
            "Diesel", SUM(tbl_CleanedData[Diesel_Total_MWh]),
            "Natural Gas", SUM(tbl_CleanedData[Gas_Total_MWh]),
            "Solar", SUM(tbl_CleanedData[Solar_Total_MWh]),
            "Wind", SUM(tbl_CleanedData[Wind_Total_MWh]),
            0
        )
)
```

### Technology Revenue

```dax
Technology Revenue =
SUMX(
    VALUES(TechnologyTable[Technology]),
    VAR SelectedTechnology = TechnologyTable[Technology]
    RETURN
        SWITCH(
            SelectedTechnology,
            "Battery Storage",
                SUMX(
                    tbl_CleanedData,
                    tbl_CleanedData[Battery_Total_MWh] * tbl_CleanedData[SA1_Price]
                ),
            "Diesel",
                SUMX(
                    tbl_CleanedData,
                    tbl_CleanedData[Diesel_Total_MWh] * tbl_CleanedData[SA1_Price]
                ),
            "Natural Gas",
                SUMX(
                    tbl_CleanedData,
                    tbl_CleanedData[Gas_Total_MWh] * tbl_CleanedData[SA1_Price]
                ),
            "Solar",
                SUMX(
                    tbl_CleanedData,
                    tbl_CleanedData[Solar_Total_MWh] * tbl_CleanedData[SA1_Price]
                ),
            "Wind",
                SUMX(
                    tbl_CleanedData,
                    tbl_CleanedData[Wind_Total_MWh] * tbl_CleanedData[SA1_Price]
                ),
            0
        )
)
```

### Technology Capture Price

Dispatch-weighted capture price was calculated as technology revenue divided by technology generation.

```dax
Technology Capture Price =
DIVIDE(
    [Technology Revenue],
    [Technology Generation]
)
```

### Capture Ratio

Capture ratio compares each technology's capture price against the market time-weighted average price.

```dax
Capture Ratio =
DIVIDE(
    [Technology Capture Price],
    [Time Weighted Avg Price]
)
```

A capture ratio above 1.00 indicates that the technology earned above the average market price. A capture ratio below 1.00 indicates that the technology earned below the average market price.

---

## Selected KPI Measures

Flexible KPI measures were created so that KPI cards would work when no technology, one technology or multiple technologies were selected.

### Selected Revenue

```dax
Selected Revenue =
[Technology Revenue]
```

### Selected Generation MWh

```dax
Selected Generation MWh =
[Technology Generation]
```

### Selected Capture Price

```dax
Selected Capture Price =
COALESCE(
    DIVIDE(
        [Selected Revenue],
        [Selected Generation MWh]
    ),
    0
)
```

### Selected Negative MWh

```dax
Selected Negative MWh =
SUMX(
    VALUES(TechnologyTable[Technology]),
    VAR SelectedTechnology = TechnologyTable[Technology]
    RETURN
        SWITCH(
            SelectedTechnology,
            "Battery Storage",
                CALCULATE(
                    SUM(tbl_CleanedData[Battery_Total_MWh]),
                    tbl_CleanedData[SA1_Price] < 0
                ),
            "Diesel",
                CALCULATE(
                    SUM(tbl_CleanedData[Diesel_Total_MWh]),
                    tbl_CleanedData[SA1_Price] < 0
                ),
            "Natural Gas",
                CALCULATE(
                    SUM(tbl_CleanedData[Gas_Total_MWh]),
                    tbl_CleanedData[SA1_Price] < 0
                ),
            "Solar",
                CALCULATE(
                    SUM(tbl_CleanedData[Solar_Total_MWh]),
                    tbl_CleanedData[SA1_Price] < 0
                ),
            "Wind",
                CALCULATE(
                    SUM(tbl_CleanedData[Wind_Total_MWh]),
                    tbl_CleanedData[SA1_Price] < 0
                ),
            0
        )
)
```

### Selected Negative Exposure %

```dax
Selected Negative Exposure % =
COALESCE(
    DIVIDE(
        [Selected Negative MWh],
        [Selected Generation MWh]
    ),
    0
)
```

---

## Negative Price Exposure

Negative price exposure measures the proportion of technology generation dispatched during intervals where the South Australian spot price was below zero.

```text
Negative Price Exposure % = Negative Price MWh / Total Technology MWh
```

This metric was used to assess how exposed each technology was to low or negative wholesale price conditions.

Solar had the highest negative price exposure, reflecting the concentration of solar generation during midday periods when prices are more likely to be low or negative.

---

## Capacity Factor

Capacity factor was used to compare how intensively each technology was utilised relative to available capacity.

```text
Capacity Factor = Actual Generation / Maximum Possible Generation
```

This helped distinguish between technologies with high energy output and technologies with high market value.

Wind and solar showed higher utilisation, while diesel and battery storage had lower utilisation but higher price capture.

---

## Revenue Risk and Return

Revenue risk was assessed using the coefficient of variation of monthly revenue.

```text
Revenue CV = Standard Deviation of Monthly Revenue / Average Monthly Revenue
```

A higher coefficient of variation indicates higher revenue volatility.

The risk-return visual compared:

- Average monthly revenue
- Revenue coefficient of variation
- Average capture price

This allowed technologies to be positioned according to revenue stability and market return.

---

## Dispatch Timing Analysis

Hourly dispatch timing was analysed to understand how technology output aligned with market prices during the day.

The dashboard compared:

- Average hourly dispatch
- Average market price

This helped explain why some technologies achieved higher capture prices than others.

Dispatchable technologies such as battery storage, diesel and natural gas were better able to operate during higher-price periods. Solar output was concentrated during daylight hours, which increased exposure to lower or negative price periods.

---

## Emissions Methodology

Estimated emissions were calculated by multiplying technology generation by assumed emissions intensity factors.

```text
Estimated Emissions = Technology MWh × Emission Intensity Factor
```

The following emissions factors were used:

| Technology | Emission Intensity |
|---|---|
| Diesel | 0.74 tCO₂-e/MWh |
| Natural Gas | 0.60 tCO₂-e/MWh |
| Solar | 0.048 tCO₂-e/MWh |
| Wind | 0.011 tCO₂-e/MWh |
| Battery Storage | 0.00 tCO₂-e/MWh |

### Selected Emissions

```dax
Selected Emissions =
SUMX(
    VALUES(TechnologyTable[Technology]),
    VAR SelectedTechnology = TechnologyTable[Technology]
    VAR SelectedMWh =
        SWITCH(
            SelectedTechnology,
            "Battery Storage", SUM(tbl_CleanedData[Battery_Total_MWh]),
            "Diesel", SUM(tbl_CleanedData[Diesel_Total_MWh]),
            "Natural Gas", SUM(tbl_CleanedData[Gas_Total_MWh]),
            "Solar", SUM(tbl_CleanedData[Solar_Total_MWh]),
            "Wind", SUM(tbl_CleanedData[Wind_Total_MWh]),
            0
        )
    VAR EmissionFactor =
        SWITCH(
            SelectedTechnology,
            "Diesel", 0.74,
            "Natural Gas", 0.60,
            "Solar", 0.048,
            "Wind", 0.011,
            "Battery Storage", 0,
            0
        )
    RETURN
        SelectedMWh * EmissionFactor
)
```

---

## Dashboard Design Approach

The dashboard was designed using an executive briefing style.

Design choices included:

- Light grey page background
- White rounded visual containers
- Subtle shadows
- Consistent KPI cards
- Clear page titles and subtitles
- Technology-consistent colour palette
- Limited slicers to avoid clutter
- Business-focused chart titles
- Concise strategic insight page

### Technology Colour Palette

| Technology | Colour |
|---|---|
| Natural Gas | Orange |
| Wind | Green |
| Solar | Yellow |
| Battery Storage | Dark Blue |
| Diesel | Grey |

This colour scheme was used consistently across dashboard pages to improve readability and technology recognition.

---

## Key Findings

The dashboard produced the following major findings:

1. Natural gas generated the highest total wholesale revenue across the analysis period.
2. Diesel and battery storage achieved the highest dispatch-weighted capture prices.
3. Wind and solar contributed significant generation volume but achieved lower capture prices.
4. Solar experienced the highest negative price exposure.
5. Wind and solar had higher capacity factors, but this did not directly translate into the highest revenue.
6. Natural gas produced the largest estimated total emissions.
7. Diesel had the highest emissions intensity per MWh but lower total emissions due to limited generation volume.
8. Battery storage showed strategic value because of its ability to align dispatch with higher-price periods.

---

## Strategic Recommendations

Based on the analysis, the dashboard supports the following recommendations:

1. Prioritise flexible dispatch and storage integration to improve price capture and reduce renewable price exposure.
2. Manage solar negative price risk through storage, curtailment, contracting or demand-side flexibility.
3. Evaluate technologies using capture price, capture ratio, negative exposure and revenue volatility, not only generation volume.
4. Balance revenue performance with emissions impact, particularly when assessing natural gas.
5. Use battery storage and demand-side flexibility to support renewable integration and improve market value.

---

## Limitations

This dashboard should be interpreted with the following limitations:

- The analysis focuses on selected generators and technologies, not every generator in the South Australian market.
- Emissions are estimated using assumed emissions intensity factors and should be treated as indicative rather than audited emissions values.
- Battery storage emissions were treated as zero direct operational emissions.
- Capture price and revenue calculations depend on the available interval-level price and dispatch data.
- The model uses a wide-format dataset, which required technology-specific DAX measures rather than a fully normalised long-format fact table.

---

## Conclusion

The analysis shows that South Australian electricity market performance was shaped by dispatch timing, price exposure, technology flexibility and emissions intensity.

Dispatchable technologies such as diesel, battery storage and natural gas captured higher prices because they operated during more valuable market intervals. In contrast, wind and solar contributed significant generation volume but faced lower capture prices and higher negative price exposure, especially solar during midday periods.

The results highlight the strategic importance of flexibility. Battery storage and demand-side flexibility can help shift renewable energy toward higher-price periods, reduce negative price exposure and improve market value. At the same time, emissions results show that high-revenue technologies can also carry higher carbon impacts, particularly natural gas.

Future electricity market strategy should therefore balance revenue optimisation, technology risk, renewable integration and emissions reduction rather than relying on generation volume alone.
