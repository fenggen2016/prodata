#' A function that searches your output based on MW   
#' 
#' This function will allow you to search your data set based on a range of molecular weights 
#' 
#' 
#' 
#' @param df Data frame following the formatting of data frames produced by the prodata package
#' @param range Range of values for the molecular weight that you would like to search for. Default returns whole dataset. 
#' @param predicted If TRUE (default) it will use the molecular weight including the PTM calculations. If FALSE it will use the molecular weight without PTMs. 
#' @keywords search, molecular weight
#' @export
#' @examples
#'
#'filtered <- searchpro(df, range = 1000:2000, predicted = TRUE)

searchpro <- function (df, range = 1:max(df$molecularweight_predicted), predicted = TRUE){
  r1 <-  range[1]
  r2 <-  range[length(range)]
  
  if (predicted == TRUE){
 
  return(subset(df, molecularweight_predicted > r1 & molecularweight_predicted < r2))
  }else{
    return(subset(df, molecularweight > r1 & molecularweight < r2))
  }
}


