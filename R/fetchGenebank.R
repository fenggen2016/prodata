#' A function that takes a list of UID and returns a genebank files #
#' 
#' This function will allow you to enter a list of protien/gene names and convert the into NCBI unique IDs. It will return a list. 
#' The first element will be your UIDs the second element will have the protien/gene names that were not matched to an ID. 
#' 
#' 
#' 
#' @param UIDs List of NCBI UIDs. 
#' @keywords NCBI, UIDs, genebank, parsing
#' @export
#' @examples
#'
#' df <- fetchGenebankl(UIDs)

fetchGenebank <- function(UIDs) 
  { 
  files <- function(id){ return(efetch(id, db=db, rettype = 'gp', retmode = retmode, retmax = returnAmount))}
  
  getFetchSeq <- function(gbfile){
    rec <- gbRecord(gbfile)
    tryCatch(seq <- biofiles::getSequence((ft(rec))), error=function(e) NULL)
    protienName <- names(seq)
    m <- data.frame(seq)
    m <- add_column(m, protienName, .after = 0)
    return(m)
  }
  #Using lapply over the UIDs to retrive genebank file 
  df1 <- lapply(UIDs, files)
  #Using lapply over the genebank files to retrive sequences of protien and sub region
  df2 <- lapply(df1, getFetchSeq)
  #Concatonating the list into a data frame 
  df3 <- do.call(rbind.data.frame, df2)
  #Filtering for Protien and protien regions 
  logvec <- grepl('(Protein)|(Region)', df3$protienName)
  df4 <- subset(df3, logvec) 
  return(df4)
  
}
