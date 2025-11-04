# 🚗 Car Price Prediction — Gradient Boosting Ensemble Approach

### 📘 Overview
This project presents an **end-to-end machine learning workflow** for predicting used car prices using **ensemble regression models**.  
It applies a structured pipeline involving **data preprocessing**, **feature engineering**, **hyperparameter tuning**, **early stopping**, and **ensemble blending** of three gradient boosting algorithms:

- **XGBoost**
- **LightGBM**
- **HistGradientBoosting (HGB)**

The final blended model achieved a **validation RMSE ≈ 4,121**, outperforming each individual model and demonstrating strong generalisation.

---

## 🧠 Machine Learning Pipeline

### 1️⃣ Data Preprocessing
- Removed irrelevant object columns and ensured all features were numeric or boolean.
- Handled **missing values** and corrected **data types**.
- Identified and treated **skewed numeric columns** (|skew| > 1) using `log1p` transformation.
- Applied **IQR-based clipping** to reduce the effect of extreme outliers.
- Ensured column alignment between training and test datasets.

### 2️⃣ Feature Engineering
- **One-hot encoding** for categorical variables.
- Converted boolean fields like `leather_interior`, `is_new`, and `luxury_flag`.
- Retained key geolocation-based features (`latitude`, `longitude`).
- Created a consistent feature schema for both training and test data.

### 3️⃣ Model Tuning and Validation
Each model was tuned using **5-Fold Cross-Validation** (`scoring='neg_root_mean_squared_error'`).

| Model | CV RMSE | Validation RMSE | Validation R² | Best Iteration |
|--------|----------|----------------|----------------|----------------|
| **XGBoost** | 5452.26 | 4204.59 | 0.936 | 1779 |
| **LightGBM** | 5586.75 | 4316.25 | 0.933 | 1779 |
| **HGB** | 5460.36 | 4236.53 | 0.935 | 1000 |

---

### 4️⃣ Model Ensembling
A weighted blending approach was used where weights were proportional to the inverse of RMSE².

| Model | Weight |
|--------|--------|
| XGBoost | 0.34 |
| LightGBM | 0.32 |
| HGB | 0.34 |

**Final Blended RMSE:** `4,121.75`

This ensemble outperformed all individual models by combining their strengths and reducing prediction variance.

---

### 5️⃣ Final Model Refit
Each tuned model was refitted on the **entire training dataset** with optimal parameters.

| Model | Final Parameters Used |
|--------|-----------------------|
| **XGBoost** | `n_estimators=1028`, `learning_rate=0.04`, `max_depth=9`, regularised |
| **LightGBM** | `n_estimators=1779`, `learning_rate=0.07`, `max_depth=6`, `subsample=0.7` |
| **HGB** | `max_iter=1000`, `learning_rate=0.05`, `l2_regularization=0.1` |

**Output:**  
Final blended predictions were saved as **`submission_ensemble.csv`**.

---

## 📊 Dataset Information

The dataset was provided as part of the  
👉 **[ASBA Predictive Analytics Competition (S2 2025) on Kaggle](https://www.kaggle.com/competitions/asba-predictive-analytics-competition-s-2-2025/data)**

### **Target Variable**
- `price`: Listed price of the car (in USD)

### **Feature Description**

| Feature | Type | Description |
|----------|------|-------------|
| **vin** | String | Vehicle Identification Number — unique identifier for each car. |
| **back_legroom** | String | Rear seat legroom (inches). |
| **body_type** | String | Vehicle body type (Sedan, Hatchback, SUV, etc.). |
| **city** | String | City where the vehicle is listed. |
| **city_fuel_economy** | Float | Fuel economy in city traffic (km/l). |
| **daysonmarket** | Integer | Days since the vehicle was first listed. |
| **dealer_zip** | Integer | Dealer’s postal ZIP code. |
| **engine_displacement** | Float | Total cylinder volume of the engine. |
| **engine_type** | String | Engine configuration (e.g., I4, V6). |
| **exterior_color** | String | Vehicle’s exterior color. |
| **franchise_dealer** | Boolean | True if dealer is a franchise. |
| **front_legroom** | String | Front seat legroom (inches). |
| **fuel_type** | String | Type of fuel used (Gasoline, Diesel, etc.). |
| **height** | String | Vehicle height (inches). |
| **highway_fuel_economy** | Float | Fuel economy on highways (km/l). |
| **horsepower** | Float | Engine power output. |
| **interior_color** | String | Interior color of the vehicle. |
| **leather_interior** | Boolean | True if the car has leather interiors. |
| **luxury_flag** | Boolean | True if the vehicle is luxury. |
| **is_new** | Boolean | True if the vehicle is less than 2 years old. |
| **latitude** | Float | Dealer’s latitude coordinate. |
| **listed_date** | String | Listing date of the vehicle. |
| **listing_color** | String | Dominant color group. |
| **longitude** | Float | Dealer’s longitude coordinate. |
| **make_name** | String | Manufacturer (e.g., Toyota, BMW). |
| **maximum_seating** | String | Maximum number of seats. |
| **mileage** | Float | Miles driven before listing. |
| **model_name** | String | Vehicle model. |
| **power** | String | Maximum engine power and RPM. |
| **savings_amount** | Integer | Amount saved in USD. |
| **seller_rating** | Float | Seller or dealer rating. |
| **torque** | String | Maximum torque and RPM. |
| **transmission** | String | Transmission type (A, M, CVT, Dual Clutch). |
| **transmission_display** | String | Gear details and transmission type. |
| **wheel_system** | String | Drive system (AWD, FWD, 4WD, etc.). |
| **wheelbase** | String | Distance between front and rear axles. |
| **width** | String | Vehicle width (inches). |
| **year** | Integer | Release year of the vehicle. |
| **price** | Float | Listed price of the vehicle (target variable). |

---

## ⚙️ Technologies Used
- **Python 3.10**
- **Pandas / NumPy** – Data wrangling and numerical operations  
- **Scikit-learn** – Preprocessing, model evaluation, and HGB  
- **XGBoost / LightGBM** – Advanced gradient boosting algorithms  
- **Matplotlib / Seaborn** – Exploratory data visualisation  
- **Joblib / Parallel Backend** – Safe parallel model training (Windows support)

---

## 📈 Key Results

| Model | Validation RMSE | Validation R² |
|--------|----------------|----------------|
| **XGBoost** | 4204.59 | 0.936 |
| **LightGBM** | 4316.25 | 0.933 |
| **HGB** | 4236.53 | 0.935 |
| **Final Ensemble** | **4121.75** | **≈ 0.94** |

- The ensemble achieved the **lowest RMSE (4121)**, confirming performance improvement over standalone models.
- The model generalises well across different splits, maintaining a strong R² around **0.94**.

---

## 📤 Output

**Final Submission File:**  
`submission_ensemble.csv`

**Columns:**
| Column | Description |
|---------|--------------|
| **vin** | Vehicle Identification Number |
| **price** | Predicted listed price  |

---

## 📚 References
- [XGBoost Documentation](https://xgboost.readthedocs.io/)
- [LightGBM Documentation](https://lightgbm.readthedocs.io/)
- [Scikit-learn HistGradientBoostingRegressor](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.HistGradientBoostingRegressor.html)
- [AutoCheck: VIN Basics](https://www.autocheck.com/vehiclehistory/vin-basics)
- [ASBA Predictive Analytics Competition (Kaggle)](https://www.kaggle.com/competitions/asba-predictive-analytics-competition-s-2-2025/data)

---

## ✨ Author
**Pradyot Jain**  
Master of Business Analytics, Macquarie University  
*Data Science & Machine Learning Portfolio Project*  
