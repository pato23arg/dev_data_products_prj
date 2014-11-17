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