# prodata
An R package for retrieving protien sequence, counting  PTMs, and calculating the molecular weight. This is currently focusing on mouse protiens but may be expanded later. The molecular weight is calculated use the effect of the experimentally verified PTMs. 

## How to use

To use this package you should start out with a list of mouse genes or protiens. If you only have a list of human genes you can use the `humanMouse()` function to convert your human genes.

```R
genelist <- humanMouse(humagenes)
```

After you have your mouse gene list you can start to process it. The first function you should use is `getUID()`. This will take your list and turn into NCBI unique IDs. The list will have two elements. The first UIDs and the second Missing, which are the protien names that did not return a UID. These can then be used to get protien data. 

```R
ids <- getUID(genelist)
```

Now that you have the ID list you can feed this into the  `fetchGenebank()` function. This will fetch and parse the genebank file connected with each UID. This parses the protien sequence into the sequence and its subregions. It will also return the molecular weight of your protein without taking into account PTMs. Therefore you will end up with many more lines of data then your genelist. 

```R
files <- fetchGenebank(ids$UIDs)
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
