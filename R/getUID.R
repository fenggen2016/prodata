#' A function that takes a  protien/genelist and returns the Unique ID number of NCBI
#'
#' This function will allow you to enter a list of protien/gene names and convert the into NCBI unique IDs. It will return a list. 
#' The first element will be your UIDs the second element will have the protien/gene names that were not matched to an ID. 
#' 
#' 
#' 
#' @param protien_gene_list List of protiens or genes. 
#' @param baseterm The term that you would like attached to your protien/gene names to make the search as accurate as possible. I.e. "[Protein Name] AND Mus musculus[Organism]"
#' @param db The database of the NCBI that you would like to access. I.e. protien 
#' @keywords NCBI, UIDs
#' @export
#' @examples
#'
#' uids <- getUID(protien_gene_list, baseterm = "[Protein Name] AND Mus musculus[Organism]", db = "protien" )


getUID <- function(protien_gene_list, baseterm = "[Protein Name] AND Mus musculus[Organism]", db = "protien"){
  
  uid1 <- function(protien){
    
    searchresult = esearch(protien, db = db,rettype = 'uilist', retmode = "json", retmax = 1)
    return(as.character(searchresult$get_content(as = 'parsed')))
  }
  
  myDF <-  data.frame(protien_gene_list)
  #Pasting the base term to the protien or gene name to ensure the optimal results 
  myDF[,2] <- paste0(myDF[,1], baseterm)
  #cleaning date frame 
  myDF[,1] <- NULL
  #Using the apply function to loop over the protien/gene names and return the UID into a dataframe
  myDF$UID <- apply(myDF, 1, uid1)
  logicm <- is.na(myDF$UID)
  missing <- subset(myDF, logicm)
  #Omitting protiens that didn't return a UID
  myDF <- na.omit(myDF)  
 
  
  #making the UIDs into a list
  gene_list <- myDF$UID
  results <- list("UIDs" = gene_list, "Missing_Protiens" = missing)
  return(results)
}
