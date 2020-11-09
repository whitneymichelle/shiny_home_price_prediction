

# Set working directory
#setwd("C:/Users/whitneymichelle/OneDrive/Documents/Data Everything/House Prices Predictive Model")

# Clean env
#rm(list = ls())

#load libraries
library(tidyverse)
library(skimr)
library(janitor)
library(tidymodels)
library(vip)
library(xgboost)
library(openxlsx)

# Read in data files
df <- read_csv('train.csv')

#  Clean data column names
df <- df %>% clean_names() %>%
# Selecting 10 most important variables found after training
  select(sale_price, overall_qual, gr_liv_area, garage_cars, bsmt_fin_sf1, total_bsmt_sf,
         x1st_flr_sf, lot_area, garage_area, full_bath, year_built)

# Split data into test and training sets
set.seed(345)
split <- initial_split(df, prop = .80)
train_df <- training(split)
test_df <- testing(split)

# Create recipe and roles--preprocessing for the model
recipe <-
  recipe(sale_price ~ ., data = train_df) %>%
  step_dummy(all_predictors(), -all_numeric()) %>%
  step_zv(all_predictors()) %>%
  step_center(all_predictors(), -all_nominal()) %>%
  step_scale(all_predictors(), -all_nominal()) %>%
  step_meanimpute(all_predictors(), -all_nominal()) 

# Model, with hyperparameters chosen from best performing model after tuning models
mod <-
  boost_tree(trees = 100,
             min_n = 27,
             tree_depth = 5,
             learn_rate = 0.1,
             loss_reduction = 1.00E-10) %>%
  set_engine('xgboost') %>%
  set_mode("regression")

# Workflow
set.seed(345)
wf <- workflow() %>%
  add_model(mod) %>%
  add_recipe(recipe)

final <-wf %>%
  fit(data  = train_df)


# Predictions with training set
predictions_train <- predict(final, train_df) %>%
  bind_cols(train_df %>% select_all)

# Test data predictions merged with test data
predictions_test <- predict(final, test_df) %>%
  bind_cols(test_df %>% select_all())
# 
# # Performance Measures and Modell Print Outputs Below---------
# 
# # Rmse of train data
# train_rmse <- predictions_train %>%
#   rmse(truth = sale_price, .pred)
# 
# # Rmse on test data
# test_rmse <- predictions_test %>%
#   rmse(truth = sale_price, .pred)
# 
# # Variable imporantance plot
# imp_img <- final %>%
#   pull_workflow_fit()%>%
#   vip()
# 
# # Save model
# saveRDS(final, paste0("model_output_files/", "final_model.rds"))
# 
# # Print rmse
# print(train_rmse)
# print(test_rmse)
# 
# # Save plot of most important variables
# ggsave(paste0("model_output_files/", "imp_var_plot.png"), plot =imp_img)
# 
# #Save prediction train and test outputs
# OUT <- createWorkbook()
# 
# # Add some sheets to the workbook
# addWorksheet(OUT, "predictions_train_output")
# addWorksheet(OUT, "predictions_test_output")
# addWorksheet(OUT, "train_rmse")
# addWorksheet(OUT, "test_rmse")
# 
# # Write the data to the sheets
# writeData(OUT, sheet = "predictions_train_output", x = predictions_train)
# writeData(OUT, sheet = "predictions_test_output", x = predictions_train)
# writeData(OUT, sheet = "train_rmse", x = train_rmse)
# writeData(OUT, sheet = "test_rmse", x = test_rmse)
# 
# # Export the file
# saveWorkbook(OUT, paste0("model_output_files/", "model_output.xlsx", overwrite = TRUE))
# 
# # Exploration of errors
# quantile_error<- predictions_test %>%
#   mutate(error = abs(sale_price -.pred)) %>%
#   mutate(error = as.integer(error))%>%
#   mutate(quartile = ntile(error, 4)) %>%
#   select(quartile, error) %>%
#   group_by(quartile) %>%
#   summarise(max = max(error), n = n())%>%
#   mutate(cumsum = cumsum(n))
#   
# deciles_error<- predictions_test %>%
#   mutate(error = abs(sale_price -.pred)) %>%
#   mutate(error = as.integer(error))%>%
#   mutate(decile = ntile(error, 10)) %>%
#   select(decile, error) %>%
#   group_by(decile) %>%
#   summarise(max = max(error), n = n())%>%
#   mutate(cumsum = cumsum(n))
# 
# error_plot <- ggplot(deciles_error, aes(x = decile, y = max))+
#   geom_line()+
#   theme_classic()+
#   ylab('error')
# 
# ggsave(paste0("model_output_files/", "error_plot.png"), plot =imp_img)




