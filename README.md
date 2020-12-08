# Home Sale Price Prediction Model & Shiny App
#### Primary objective: show model demployment in Shiny app

#### Home sale price predictive model and deployment in R shiny dashboard.

The training dataset from House Prices: Advanced Regression Techniques Kaggle competition was used for this project and is referred to as `home_price_prediction_app/house_prices_df.csv` in this repository.

For more information on the Kaggle competition, go here: https://www.kaggle.com/c/house-prices-advanced-regression-techniques

## Requirements

### Libraries
- shiny
-	shinyWidgets
-	scales
-	grid
-	gridExtra
-	tidyverse
-	skimr
-	janitor
-	tidymodels
-	vip
-	xgboost
-	openxlsx

### From the Repository

Run `home_price_prediction_app/app.R` to deploy model predictions within the shiny app, changing working directory to your desired local directory where you have saved repository files. All files needed to run the shiny app are in the `home_price_prediction_app` folder. Descriptions of those files within the folder, model script and shiny app script and data, are below:

**Final Model Script**
- `home_price_prediction_app/model_main.R`

In this script, the data is imported, preprocessed, and the model fitted using tidymodels package. The fitted model parameters and hyperparameters were finalized in this script after several model iterations. Model iterations were set up in `model_iteration.R`, and the performance of each model is shown here in `model_output_files/xgboostmodels_performances.csv`. The parameters of the best model were saved in `model_output_files/xgboostfinal_model_parameters.csv`. The final model is saved as an object, `model_output_files/final_model.rds`. 

The `model_out_files/model_output` shows final model output, showing the test and training dataframe with predictions along with overall rmse for the training and test datasets. A visualization of the test data error is in `model_output_files/error_plot.png`, showing error by decile. 

Predictors used in the model were pared down to top 10 most important variables. To see visual representation of top 10 most important variables' influence on the model, go here: `model_output_files/imp_var_plot.png`. Description of all data variables, including those inputted in the model before the model was finalized, are here: `data_description.txt`.

**Shiny App UI and Server**
- `home_price_prediction_app/app.R`

The app takes in user inputs, the model's predictors. The model is used to predict the home's sale price from these user inputs. 

**Data File**
`home_price_prediction_app/house_prices_df.csv`

The training dataset from House Prices: Advanced Regression Techniques Kaggle competition was used for this project. Description of all data variables, including those inputted in the model before model was finalized, are here: `data_description.txt`. 

## Shiny Dashboard
Link to live dashboard: https://whitneymichelle.shinyapps.io/home_price_prediction_app/

![alt text](https://github.com/whitneymichelle/home-sale-price-prediction/blob/main/home_price_prediction_app/dashboard_screenshot.png)

## R Session Information

- Session info -------------------------------------------------------------------------------------------------------------------
 setting  value                       
 version  R version 3.6.1 (2019-07-05)
 os       Windows >= 8 x64            
 system   x86_64, mingw32             
 ui       RStudio                     
 language (EN)                        
 collate  English_United States.1252  
 ctype    English_United States.1252  
 tz       America/Chicago             
 date     2020-11-08                  

- Packages -----------------------------------------------------------------------------------------------------------------------
 package     * version date       lib source        
 assertthat    0.2.1   2019-03-21 [1] CRAN (R 3.6.3)
 cli           2.0.2   2020-02-28 [1] CRAN (R 3.6.3)
 crayon        1.3.4   2017-09-16 [1] CRAN (R 3.6.3)
 digest        0.6.25  2020-02-23 [1] CRAN (R 3.6.3)
 fansi         0.4.1   2020-01-08 [1] CRAN (R 3.6.3)
 fastmap       1.0.1   2019-10-08 [1] CRAN (R 3.6.3)
 glue          1.4.2   2020-08-27 [1] CRAN (R 3.6.3)
 htmltools     0.5.0   2020-06-16 [1] CRAN (R 3.6.3)
 httpuv        1.5.4   2020-06-06 [1] CRAN (R 3.6.3)
 later         1.1.0.1 2020-06-05 [1] CRAN (R 3.6.3)
 magrittr      1.5     2014-11-22 [1] CRAN (R 3.6.3)
 mime          0.9     2020-02-04 [1] CRAN (R 3.6.2)
 promises      1.1.1   2020-06-09 [1] CRAN (R 3.6.3)
 R6            2.4.1   2019-11-12 [1] CRAN (R 3.6.3)
 Rcpp          1.0.5   2020-07-06 [1] CRAN (R 3.6.3)
 rlang         0.4.7   2020-07-09 [1] CRAN (R 3.6.3)
 rstudioapi    0.11    2020-02-07 [1] CRAN (R 3.6.3)
 sessioninfo * 1.1.1   2018-11-05 [1] CRAN (R 3.6.3)
 shiny         1.5.0   2020-06-23 [1] CRAN (R 3.6.3)
 withr         2.2.0   2020-04-20 [1] CRAN (R 3.6.3)
 xtable        1.8-4   2019-04-21 [1] CRAN (R 3.6.3)
 yaml          2.2.1   2020-02-01 [1] CRAN (R 3.6.3)

