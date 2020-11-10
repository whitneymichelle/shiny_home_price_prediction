

#set working directory
#setwd("C:/Users/whitneymichelle/OneDrive/Documents/Data Everything/House Prices Predictive Model")

#clean env
#rm(list = ls())

#load libraries
library(tidyverse)
library(skimr)
library(janitor)
library(tidymodels)
library(vip)
library(xgboost)
library(openxlsx)

#read in data files
df <- read_csv('house_prices_df.csv')

#split data into test and training sets
set.seed(345)
split <- initial_split(df, prop = .80)
train_df <- training(split)
test_df <- testing(split)

#clean data column names
test_df <- test_df %>% clean_names()
train_df <- train_df %>% clean_names()

#variable exploration
#str(test_df)
#str(train_df)
#skim(train_df)

#create recipe and roles--preprocessing for the model
recipe <-
  recipe(sale_price ~ ., data = train_df) %>%
  step_rm(utilities) %>%
  update_role(id, new_role = "ID") %>%
  step_dummy(all_predictors(), -all_numeric()) %>%
  step_zv(all_predictors()) %>%
  step_center(all_predictors(), -all_nominal()) %>%
  step_scale(all_predictors(), -all_nominal()) %>%
  step_meanimpute(all_predictors(), -all_nominal()) 

#set model parameters
mod <-
  boost_tree(trees = 100,
             min_n = tune(),
             tree_depth = tune(),
             learn_rate = tune(),
             loss_reduction = tune()) %>%
  set_engine('xgboost') %>%
  set_mode("regression")

#workflow
set.seed(345)
wf <- workflow() %>%
  add_model(mod) %>%
  add_recipe(recipe)

#create cross validtion folds and hyperparameter grid
set.seed(345)
folds <- vfold_cv(train_df)
grid <- grid_regular( min_n(),tree_depth(),learn_rate(),loss_reduction(),levels = 4)

#fit the model
wff <- wf %>%
  tune_grid(resamples = folds, grid = grid)

#choose final model
final <- wff %>%
  select_best("rmse")
  #fit(data  = train_df)

#save final model parameters to csv
write_csv(final, paste0("model_output_files/", engine_input, "final_model_parameters.csv"))

#save results of all model runs
metrics <- wff %>%
  collect_metrics()

#save results of all model runs to csv
write_csv(metrics, paste0("model_output_files/", engine_input, "models_performances.csv"))

#predictions with training set
predictions_train <- predict(final, train_df) %>%
  bind_cols(train_df %>% select_all)

#test data predictions merged with test data
predictions_test <- predict(final, test_df) %>%
  bind_cols(test_df %>% select_all())

# Performance Measures---------

# rmse of train data
train_rmse <- predictions_train %>%
  rmse(truth = sale_price, .pred)

# rmse on test data
test_rmse <- predictions_test %>%
  rmse(truth = sale_price, .pred)

# variable imporantance plot
imp_img <- final %>%
  pull_workflow_fit() %>%
  vip(num_features = 30)
 








