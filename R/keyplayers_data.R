#'List of keyplayers for protiens active in a diabetic mouse pancreas
#'
#' List of protiens that are active in a diabetic mouse pancreas. This can be used to test the function of this package.
#'
#' @docType data
#'
#' @usage data(ketplayers)
#'
#' @format A list of proteins 
#' 
#' @keywords datasets
#'
#'
#' @examples
#' data(keyplayers)
#' 
#' ids <- getUID(keyplayers, "[Protein Name] AND Mus musculus[Organism]", "protein" )
#'
#' proteindf <- getGenPept(ids$UIDs)
#' res <- unip(ids$UIDs)
#' #here you must run the command lind tool found here: https://github.com/jdrudolph/uniprot
#' # res() will also a file called uniprot.txt in your working directory, this can be used with the tool
#' # like this: uniprot retrieve -f gff uniprot.txt output.txt 
#' ptmdf <- readPTM('output.txt')
#' ptmdf <- ptm(ptmdf, res)
#' ptmdf <- ptmClean(ptmdf)
#' proteindf <- countPTMs(proteindf, ptmdf)
#'finaldf <- predictedMW(proteindf, ptmdf)
#'
#'viz(finaldf)
#' 
#' 
#' 
"keyplayers"