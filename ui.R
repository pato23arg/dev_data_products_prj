library(shiny)
shinyUI(bootstrapPage(
        h3("Diamond Price Estimator Tool"),

        
        textInput(inputId = "calculate_price",
                      label = strong("Calculate Diamond Price - Enter carats"),
                      value = 1),
        actionButton("calc_Button", "Calculate"),
        p('Diamond Estimated Price (SIN $):'),
        textOutput('calculated_price'),
        
        checkboxInput(inputId = "draw_trend",
                      label = strong("Draw Trend Line"),
                      value = FALSE),
        
        
        plotOutput(outputId = "main_plot", height = "500px", width = "500px")
        
))

