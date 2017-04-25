#' A function that takes a list of human genes and finds the mouse homologs
#' 
#' This function will accept a list of human gene names and finds their mouse homologs. This gene list can then be used with the getUID function of this package.
#' 
#' 
#' 
#' @param genelist A list of human genes 
#' @keywords biomart, human genes, mouse genes
#' @export
#' @examples
#'
#' mousegenelist <- humanMSouse(humangenelist)
humanMouse <- function(genelist){

ensembl <- useMart("ensembl",dataset="hsapiens_gene_ensembl")

attributes <- c('mmusculus_homolog_associated_gene_name')
genelistm <- getBM(attributes = attributes, filters = 'hgnc_symbol', values = genelist, mart = ensembl)
return(genelistm)

}

