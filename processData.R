# processData.r
# this script will be sourced by the main.Rmd
doSomething <- function(input){
  input$a <- input$a * 2
  input$b <- input$b * 3
  return(input)
}
