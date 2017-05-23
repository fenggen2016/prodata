#' A function that takes a list of UIDs and returns a genebank files 
#' 
#' This function will allow you to enter a list of protien/gene names and convert the into NCBI unique IDs. It will return a list. 
#' The first element will be your UIDss the second element will have the protien/gene names that were not matched to an ID. 
#' 
#' 
#' 
#' @param UIDss List of NCBI UIDss. 
#' @keywords NCBI, UIDss, genebank, parsing
#' @export
#' @examples
#'
#' df <- fetchGenebankl(UIDss)

fetchGenebank <- function(UIDs) {
  
  files <- function(id){ return(efetch(id, db= 'protein', rettype = 'gp', retmode = 'text', retmax = 1))}
  
  getFetchSeq <- function(gbfile){
    rec <- gbRecord(gbfile)
    tryCatch(seq <- biofiles::getSequence((ft(rec))), error=function(e) NULL)
    protienName <- unique(names(seq))
    m <- data.frame(seq)
    m <- add_column(m, protienName, .after = 0)
    return(m)
  }
  
  #Using lapply over the UIDss to retrive genebank file 
  df1 <- lapply(UIDs, files)
  #Using lapply over the genebank files to retrive sequences of protien and sub region
  df2 <- lapply(df1, getFetchSeq)
  
  for(i in 1:length(df2)){
    df2[[i]]$geneid <- UIDs[i]
  }
  #Concatonating the list into a data frame 
  df3 <- do.call(rbind.data.frame, df2)
  #Filtering for Protien and protien regions 
  logvec <- grepl('(Protein)|(Region)', df3$protienName)
  df4 <- subset(df3, logvec) 
  df5 <- molecW(df4)
  
  
  return(df5)
  
  }
