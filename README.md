---
title: "DiamondPriceEstimator_helpfile"
author: "Patricio Villar"
date: "Monday, November 17, 2014"
output: html_document
---
##Introduction:
This help file was written to explain how to utilize the Diamond Price Estimator Tool. This tool has been developed to easily estimate a diamond price based on its mass. The data used to create the predictor can be viewed in http://www.amstat.org/publications/jse/datasets/diamond.txt. Data set is contributed by Singfat Chu.

##How to utilize the application:

ONce you access to the application URL, you'll be able to see a scatterplot at the bottom. This scatterplot shows the relation between diamond mass in carats and diamond price in Singapore dollars, based on the information provided in the dataset.
If you want to draw a trend line, you just need to click in the "Draw Trend Line" checkbox.
If you want to calculate a diamond price, you just need to put the diamond's mass (expressed in carats) int the "Calculate Diamond Price" textbox. Then just press the "Calculate Button", the diamond price will appear below.

##R Code:

ui.R:
-----

```{r, echo=TRUE, results='hide', eval=FALSE}
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

```

server.R:
---------

```{r, echo=TRUE, results='hide', eval=FALSE}
library(shiny);library(UsingR);data(diamond)
shinyServer(
        function(input, output) {
         
                output$main_plot <- renderPlot({
                        
                        plot(diamond$carat, diamond$price,
                             xlab = "Mass(carats)",
                             ylab = "Price (SIN $)",
                             bg = "lightblue",
                             main = "Diamond Price Regression Model",
                             col = "black", cex = 2, pch = 21, frame = FALSE)
                        
                        if (input$draw_trend) {
                                abline(lm(price~carat, data = diamond), lwd = 2, col = "red")
                        }
                        

                        
                })
                
                output$calculated_price <- renderText({
                        if (input$calc_Button == 0)
                                return()
                        isolate(fit <- lm(price~carat, data=diamond))
                        isolate(coef(fit)[1] + coef(fit)[2] * as.numeric(input$calculate_price))
                        
                })
        })
```

