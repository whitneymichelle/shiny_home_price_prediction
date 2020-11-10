# Set working directory
#setwd("C:/Users/whitneymichelle/OneDrive/Documents/Data Everything/House Prices Predictive Model")

library(shiny)
library(shinyWidgets)
library(scales)
library(grid)
library(gridExtra)

# Source in model file
source('model_main.R')
#create dataframe from all available data
shiny_df <- bind_rows(predictions_train, predictions_train)

# Set working directory
#setwd("C:/Users/whitneymichelle/OneDrive/Documents/Data Everything/House Prices Predictive Model/shiny_dashboard_parts")

# Source in ui
source('model_app_ui.R')
#Source in server
source('model_app_server.R')

#Run shiny app
shinyApp(ui = ui, server = server)
