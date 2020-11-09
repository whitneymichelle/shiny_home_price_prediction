ui <- fluidPage(
     titlePanel(h1("Predict Home Sale Price")),
            tags$h1(tags$style(".titlePanel{color:black;
                                              font-size: 60px;
                               font-weight:800
                               }"
                               )),
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
                                              font-weight:500
                                              }"
                                              ))
                          
                )))
  
  
)



