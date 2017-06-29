# prodata
An R package for retrieving protien sequence, counting  PTMs, and calculating the molecular weight. This is currently focusing on mouse protiens but may be expanded later. The molecular weight is calculated using the effect of the PTMs. 

This package was built to narrow the search space for the identification of proteins imaged in an IMS experiment. Data from Uniprot and NCBI are merged together to created final comprehensive dataset to help with identification new proteins or peptides. A full video tutorial can be found here https://www.youtube.com/watch?v=YKKxj1O1Dn0



##Motivation behind this R package
In the end of a metabolic or comparative analysis of a serie of IMS experiment, we usually obtain a set of masses that are differentially expressed across different conditions or displaying interesting spatial distributions in the tissue. It is very useful for sequential investigations if we can generate relevant hypotheses about what these masses could be and what are their biological functions. It is useful to screen for potential drug targets or possible candidates for following MS/MS experiment. Currently in the field of IMS, this is done one by one manually by browsing through huge databases containing heterogenous entries. Our tool is now available to effectively do the whole job. Given a list or several lists of proteins or genes of interest, our tool will quickly generate a corresponding database containing all possible masses. Compared to existing calculator, these calculated masses have two useful and unique features. One is that they include not only the whole protein but also the reported subregions, chains or precursors. The second feature is that they also take into account all curated PTMs. PTMs are important biochemical processes that can change the mass of a protein. In addition to creating a database with these carefully calculated mass, our tool also generate a web application that allows you to efficiently query the database in two ways. One is querying by mass value the other is by protein function or name. All our aforementioned solutions are now available in a R package that we make.

## How to use

To use this package you should start out with a list of mouse genes or protiens. If you only have a list of human genes you can use the `humanMouse()` function to convert your human genes.

```R
genelist <- humanMouse(humagenes)
```

After you have your mouse gene list you can start to process it. The first function you should use is `getUID()`. This will take your list and turn into NCBI unique IDs. The list will have two elements. The first UIDs and the second Missing, which are the protien names that did not return a UID. These can then be used to get protien data. 

```R
ids <- getUID(genelist)
```

Now that you have the ID list you can feed this into the  `getGenePept()` function. This will fetch and parse the genebank file connected with each UID. This parses the protien sequence into the sequence and its subregions. It will also return the molecular weight of your protein without taking into account PTMs. Therefore you will end up with many more lines of data then your genelist. 

```R
files <- getGenPept(ids$UIDs)
```

The list of gene IDs should also be fed through the `unip()` function. This will do two things, return a variable which contains UIDs linked to UNIPROTKB and write to a file called uniprot.txt. This file should then be used with this https://github.com/jdrudolph/uniprot. The file should retrieve gff entries from UNIPROT. The output file should be named output.txt. 
```R
res <- unip(id$UIDs)
```
The file output.txt should be read by the `readPTM()` function. This will output a dataframe of PTMs linked to the geneids of the proteins. 

```R
ptmdf <- readPTM(file = 'output.txt')
```
The ptmdf needs to be cleaned and formated by the ptmClean function. 
```R
ptmdf <- ptmClean(ptmdf)
```
`countPTMS()` merges the protein data with the PTM data. It returns a data frame with the number of PTMs there are for all possible PTMs.
```R
proteindf <- countPTMs(proteindf, ptmdf)
```
The final step to creating the data frame is to put it throught the `predictedMW()` function. This will calculaed a predicted molecular weight based on the number of experimentally verified PTMs. The weights of these ptms were gathered from variauous sources. 

```R
finaldf <- predictedMW(proteindf, ptmdf)
```
To filter the data by molecular weight range you can use the `searchpro()` function. It will allow you to pin point an exact range of MW, including or not including PTM calculations. 

```R
searchpro(finaldf, range = 2000:10000, predicted = TRUE)
```

Attached to this R package are two important things. The first is the `keyplayers` proteins list. This can be used as a test proteins list to help you get hang of the package. The second is the `conversions` data which contains the PTMs and their molecular weights. This is used by various functions within the package. If you have any suggestions or questions feel free to contact me. 


```R
viz(finaldf)
```

The `viz()` function launched a shiny application using the final dataframe.

If you have any suggestions or questions feel free to contact me. 

