# Loan Approval Risk Assessment and Modeling

## Task Description

In this project, we work with the **Loan Approval** dataset, a modified version of a synthetic dataset for **Risk Assessment and Loan Approval Modeling**. The dataset consists of 20,000 records, including personal, demographic, and financial information. The high-level goal is to build predictive models to classify whether a loan applicant will be approved or denied for a loan based on the provided features.

### Objectives
1. **Data Preprocessing and Cleaning**: Clean and preprocess the dataset to ensure that it is suitable for training machine learning models.
2. **Logistic Regression Model**: Train and evaluate a logistic regression model to predict loan approval.
3. **K-Nearest Neighbors (KNN) Model**: Train and evaluate a KNN model to predict loan approval.
4. **Feature Selection Using Recursive Feature Elimination (RFE)**: Identify key features to enhance model performance and reduce complexity.
5. **Model Performance Evaluation**: Compare and evaluate the models using metrics such as accuracy, F1-score, and overfitting analysis.

---

## Data Overview

The dataset includes a variety of features related to applicants' demographic and financial profiles, such as:

|Column|Description|
|:-----|:----------|
|ApplicationDate| Loan application date|
|Age| Applicant's age|
|AnnualIncome| Yearly income|
|CreditScore| Creditworthiness score|
|EmploymentStatus| Job situation|
|EducationLevel| Highest education attained|
|LoanAmount| Requested loan size|
|LoanDuration| Loan repayment period|
|MaritalStatus| Applicant's marital status|
|...| *and many more financial metrics...* |
|LoanApproved| Target column indicating whether the loan was approved or not|

---

## Algorithms Applied

### 1. **Logistic Regression**
   - A classification algorithm used to predict the loan approval outcome.
   - Evaluation Metrics: **Accuracy** and **F1-score**.
   - Results:
     - Training Accuracy: 92.79%
     - Testing Accuracy: 93.14%
     - Training F1-Score: 84.28%
     - Testing F1-Score: 85.49%

     **Conclusion**: The model is generalizing well, with no signs of overfitting, as the performance on the training and testing sets is consistent.

### 2. **K-Nearest Neighbors (KNN)**
   - A non-parametric algorithm that classifies loan approval based on the similarity of applicant records.
   - KNN was evaluated with different values of `k` and distance metrics (Euclidean, Manhattan, and Cosine).
   - Results for the best-performing model (K=11, Manhattan distance):
     - Test Accuracy: 89.67%
     - Test F1-Score: 75.92%

     **Conclusion**: The KNN model with Manhattan distance metric and `k=11` provided the best performance, balancing both precision and recall.

---

## Feature Selection with Recursive Feature Elimination (RFE)

### Performance:
- **Accuracy**: Ranges from 83.89% to 93.24%, stabilizing around 93.14% with 26 or more features.
- **F1-Score**: Peaks at 0.8565 with 26 features.
  
  **Selected Key Features**:
  - Age, AnnualIncome, CreditScore, LoanAmount, BankruptcyHistory
  - Categorical features like EmploymentStatus, EducationLevel, and MaritalStatus

  **Conclusion**: Using 26 features strikes a balance between performance (F1 score and accuracy) and model simplicity, making it the ideal feature set.

---

## Overfitting Analysis

- **Logistic Regression**: No overfitting detected; model performed consistently well on both training and testing sets.
- **KNN with K=1**: Overfitting detected due to perfect training accuracy (100%) but significant drop in testing performance.
- **KNN with K=11**: Best balance between bias and variance, providing good generalization with a testing accuracy of 89.67% and an F1 score of 75.92%.

---

## Key Takeaways

1. **Model Evaluation**:
   - Logistic Regression showed strong performance with balanced accuracy and F1-score, making it a solid model for predicting loan approval.
   - KNN performed well when fine-tuned, with the Manhattan distance metric and `k=11` providing the best balance between precision and recall.
   
2. **Feature Selection**:
   - Recursive Feature Elimination (RFE) helped reduce complexity while maintaining accuracy and F1-score. 26 features were selected as optimal for the models.

3. **Overfitting Considerations**:
   - Careful tuning of the models, particularly KNN, helped mitigate overfitting and improved generalization to unseen data.

---

## Future Improvements
- Further fine-tuning of hyperparameters, particularly in KNN models, could enhance performance.
- Exploration of other classification algorithms like Decision Trees, Random Forest, or Gradient Boosting could offer additional insights.
- Incorporating cross-validation techniques could improve model robustness.

---
