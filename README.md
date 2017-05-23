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

Now that you have the ID list you can feed this into the  `fetchGenebank()` function. This will fetch and parse the genebank file connected with each UID. This parses the protien sequence into the sequence and its subregions. Therefore you will end up with many more lines of data then your genelist. 

```R
files <- fetchGenebank(ids$UIDs)
```

You can use the the  `molecW()` function to calculate the molecular weight without PTMs and with PTMS (methalyation and disulfide bonds). This returns to you the final data table.

```R
finaldf <- molecW(files)
```
To filter the data by molecular weight range you can use the `searchpro()` function. It will allow you to pin point an exact range of MW, including or not including PTM calculations. 

```R
searchpro(finaldf, range = 2000:10000, predicted = TRUE)
```
