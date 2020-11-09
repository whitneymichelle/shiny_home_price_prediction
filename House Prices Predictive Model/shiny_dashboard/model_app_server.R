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

