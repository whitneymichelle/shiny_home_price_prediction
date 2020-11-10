
library(shiny)
library(shinyWidgets)
library(scales)
library(grid)
library(gridExtra)

# Source in model file
source('model_main.R')
#create dataframe from all available data
shiny_df <- bind_rows(predictions_train, predictions_train)


ui <- fluidPage(
  headerPanel("Home Sale Price Predictor"),
  tabPanel( "House Sale Predictions", fluid = TRUE,
            sidebarLayout(
              sidebarPanel(width = 2,
                           sliderTextInput("overallquality", "Overall Quality",
                                           choices= sort(unique(shiny_df$overall_qual))),
                           sliderTextInput("grlivarea", "Above Ground Square Feet",
                                           choices= sort(unique(shiny_df$gr_liv_area))),
                           sliderTextInput("garagecars", "How Many Car Garage?",
                                           choices= sort(unique(shiny_df$garage_cars))),
                           sliderTextInput("finbsmtsf", "Finished Basement Square Feet",
                                           choices= sort(unique(shiny_df$bsmt_fin_sf1))),             
                           sliderTextInput("bsmtsf", "Total Basement Square Feet",
                                           choices= sort(unique(shiny_df$total_bsmt_sf))),
                           sliderTextInput("firstflsq", "First Floor Square Feet",
                                           choices= sort(unique(shiny_df$x1st_flr_sf))),  
                           sliderTextInput("lotarea", "Lot Area",
                                           choices= sort(unique(shiny_df$lot_area))),  
                           sliderTextInput("garagesf", "Garage Sqaure Feet",
                                           choices= sort(unique(shiny_df$garage_area))),  
                           sliderTextInput("fullbath", "Full Baths Above Ground",
                                           choices= sort(unique(shiny_df$full_bath))), 
                           sliderTextInput("yrbuilt", "Year Built",
                                           choices= sort(unique(shiny_df$year_built)))
              ),
              mainPanel(width = 9, 
                        br(),
                        textOutput("prediction"),
                        tags$head(tags$style("#prediction{color:black;
                                             font-size: 40px;
                                             font-weight:300;
                                             border: 10px solid black;
                                             text-align: center;
                                             background-color:lightblue;
                                             background: rgba(0,191, 255, .3)
                                             
                                             }"
                                              ))
                        
                        )))
  
  
            )



server <- function(input, output, session) {
  
  prediction_df <- reactive({
    
    predict(final, tibble( 
      overall_qual = input$overallquality,
      gr_liv_area = input$grlivarea,
      garage_cars = input$garagecars,
      bsmt_fin_sf1 = input$finbsmtsf,
      total_bsmt_sf = input$bsmtsf,
      x1st_flr_sf = input$firstflsq,
      lot_area = input$lotarea,
      garage_area = input$garagesf,
      full_bath = input$fullbath,
      year_built = input$yrbuilt)) %>%
      select(.pred)%>%
      mutate(.pred = dollar(.pred))%>%
      rename('Predicted Sale Price' = .pred)
    
  })
  
  output$prediction <- renderText ({
    
    paste("Predicted Sale Price:", "", "", as.character(prediction_df()[1,]))
    
    
  })
  
  
  
}

#Run shiny app
shinyApp(ui = ui, server = server)
