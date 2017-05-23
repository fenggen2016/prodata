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
#' ids <- getUID(keyplayers, "[Protein Name] AND Mus musculus[Organism]", "protien" ))
#' 
#' proteindf <- fetchGenebank(ids$UIDs)
#' res <- unip(id$UIDs)
#' 
#' ptmdf <- readPTM(file = 'output.txt')
#' ptmdf <- ptm(ptmdf, res)
#' ptmdf <- ptmClean(ptmdf)
#' 
#' proteindf <- countPTMs(proteindf, ptmdf)
#' finaldf <- predictedMW(proteindf, ptmdf)
#' 
#' 
#' 
#' 
"keyplayers"