#' A function that takes the dataframe created by the predictedMW() function and launched a shiny app
#' 
#' This function creates a shiny app of the final data frame created by the prodata package and launched a shiny app.
#' The shiny app allows the user to filter that databased on their prefred molecularweight plus a tolerance.
#' 
#' 
#' @param finaldf Dataframe created by the predictedMW() function
#' @keywords shiny, dashboard, interaction
#' @export
#' @examples
#'
#'viz(finaldf)
#' 
viz <- function(finaldf) {
  shinyApp(
  ui <- fluidPage(
 
    sidebarLayout(
    sidebarPanel(
      numericInput('molec', 'Molecularweight:', 5000),
      numericInput('tol','Tolerence:', 100)
    ),
    
    mainPanel(
      DT::dataTableOutput('mytable')
    ))
  ),
  
  server = function(input, output) {

    output$mytable <- DT::renderDataTable({
      subset(finaldf,molecularweight_predicted >= input$molec - input$tol & molecularweight_predicted <=  input$molec + input$tol )
    })
  },
    )
}
    
  
  

  
  

