# Diabetes Risk Prediction and Feature Analysis

## Objective

In this project, I worked on two key objectives:
1. **Predicting Diabetes Risk Using Regression and Neural Network Models with Cross-Validation, Feature Selection, and KNN Optimization.**
2. **Identifying Key Risk Factors for Diabetes Using GaussianNB, CategoricalNB, and Bayesian Network Analysis.**

## Data Source and Description

The Diabetes prediction dataset is a collection of medical and demographic data from patients, along with their diabetes status (positive or negative). The data includes features such as age, gender, body mass index (BMI), hypertension, heart disease, smoking history, HbA1c level, and blood glucose level. This dataset can be used to build machine learning models to predict diabetes in patients based on their medical history and demographic information.

**Data Source**: The dataset was obtained from the [diabetes_prediction_dataset (Kaggle)](https://www.kaggle.com/datasets/iammustafatz/diabetes-prediction-dataset).

The dataset consists of 9 columns and 100000 rows. The data set includes the following columns:

| Column Name          | Description                                                                                         |
|----------------------|-----------------------------------------------------------------------------------------------------|
| `gender`             | The gender of the individual, with values 'Male', 'Female' and 'Other'.                              |
| `age`                | The age of the individual in years.                                                                  |
| `hypertension`       | Indicates if the individual has hypertension (1) or not (0).                                         |
| `heart_disease`      | Indicates if the individual has a history of heart disease (1) or not (0).                           |
| `smoking_history`    | The smoking history of the individual, with categories such as 'never', 'current', 'No Info', etc.   |
| `bmi`                | The Body Mass Index (BMI) of the individual, representing their weight-to-height ratio.              |
| `HbA1c_level`        | The level of Hemoglobin A1c, a measure of blood sugar levels over time.                              |
| `blood_glucose_level`| The level of blood glucose, an indicator of current blood sugar level.                               |
| `diabetes`           | Indicates whether the individual has diabetes (1) or not (0).                                        |

## Algorithms Applied

Several machine learning models and techniques were applied to predict diabetes risk and identify key factors contributing to diabetes:

1. **Linear Regression**: Used as a baseline model for diabetes risk prediction.
2. **Polynomial Regression**: Captured non-linear relationships between the variables.
3. **K-Nearest Neighbors (KNN)**: Applied for both regression and classification tasks, with hyperparameter tuning using GridSearchCV.
4. **Neural Networks**: Provided the best accuracy in predicting diabetes risk by capturing complex non-linear relationships.
5. **Gaussian Naive Bayes (GaussianNB)**: Applied for continuous features, offering probabilistic interpretations.
6. **Categorical Naive Bayes (CategoricalNB)**: Applied for categorical features, though it struggled with class imbalance.
7. **Bayesian Network Analysis**: Revealed dependencies between different risk factors, offering insights into their collective influence on diabetes.

## How to Deploy/Run the files
1. Make sure to install all the necessary libraries required.
2. Download the dataset from the data source given.
3. Next, Run the file

## Key Takeaways

- **Neural Networks**: Provided the highest accuracy in predicting diabetes risk, thanks to their ability to capture complex, non-linear relationships between features.
- **Gaussian Naive Bayes**: Performed well with continuous features such as age, blood glucose levels, and HbA1c levels, showing high predictive power with an AUC score of 0.9214.
- **Categorical Naive Bayes**: Struggled with categorical data due to class imbalance, resulting in poor precision and recall scores.
- **Bayesian Network Analysis**: Revealed important dependencies between features, such as age, smoking history, and blood glucose levels, offering a probabilistic understanding of diabetes risk.
- **Recursive Feature Elimination (RFE)**: Helped refine model performance by selecting the most important features and reducing overfitting.
- **KNN Models**: Showed solid performance but required careful hyperparameter tuning to balance accuracy and avoid overfitting.

## Conclusion

This project demonstrated how various machine learning models, including regression techniques, KNN, and neural networks, can effectively predict diabetes risk based on medical and demographic data. Neural networks stood out as the most effective model for prediction, while probabilistic models like Gaussian Naive Bayes and Bayesian Networks provided valuable insights into the relationships between different features. By identifying key risk factors, such as age, HbA1c levels, and smoking history, these models can assist healthcare professionals in early detection and prevention strategies for diabetes. The combination of predictive accuracy and feature analysis reinforces the importance of data-driven approaches in healthcare.
