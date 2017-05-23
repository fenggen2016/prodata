#' A function that takes a list of UID and returns a list of UNIPROT IDs 
#' 
#' This function converts UID into UNIPROT IDs for the retrival of PTM data from UNIPROT. It writes this to a file to be used in the comman line UNIPROT tool. 
#' It also returns a list of UIDs attached to UNIPROT ID. This will be used to build the ptmdf. 
#' 
#' 
#' @param UIDs List of NCBI UIDs. 
#' @keywords NCBI, UIDs, Uniprot
#' @export
#' @examples
#'
#' res <- unip(UIDs)
#' 
unip <- function(UIDs){
  up <- UniProt.ws(taxId=10090)
  
  res <- UniProt.ws::select(up, 
                            keys =  unique(UIDs), 
                            columns = "UNIPROTKB",
                            keytype = "GI_NUMBER*")
  
  write(unique(res$UNIPROTKB), file = "uniprot.txt")
  
  return(res)
}
