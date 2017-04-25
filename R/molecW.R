#' A function that takes a dataframe produced by the fetchGenebank() function and returns PTMS and molecular weight
#'
#' This function takes a dataframe produced by the fetchGenebank() function and returns PTMS and molcular weights via extra columns in the data frame.
#' I can take other data frames if the sequences columns is named seq
#' 
#' 
#' 
#' @param df df produced by the fetchGenebank() function or where the sequence column is named seq.
#' @keywords Molecular Weight, PTMs
#' @export
#' @examples
#'
#' finaldf <- molecw(df)



molecW <-function(df){

  df$molecularweight <- mw(df$seq)

  df$m <- str_count(df$seq, 'm')
  df$cc <- str_count(df$seq, 'cc')

  
  #Using the PTM counts to adjust the molecular weights, this should be executed in order
  for(i in 1:length(df$m)){
    df$molecularweight_predicted[i] <- df$m[i] * 16 + df$molecularweight[i] 
  }
  
  for(i in 1:length(df$cc)){
    df$molecularweight_predicted[i] <- df$cc[i] * -2 + df$molecularweight_predicted[i] 
  }
  
  return(df)
}
