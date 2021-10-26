[![DOI](https://zenodo.org/badge/240797439.svg)](https://zenodo.org/badge/latestdoi/240797439)

# Supporting data and code for: Distribution of invasive *versus* native whitefly species and their pyrethroid knock-down resistance allele in a context of interspecific hybridization

*The data and R code used for the related study. This study is a part of the PhD thesis of Alizée Taquet.*


![alt_text](https://am3pap005files.storage.live.com/y4mLAUTj_dFHf9lTTOqNQUOcfotjPFDX-sTivwhbD9sfyuCOipemF_KtXczK-fLqGRmdicIWShqNNEYshw0UZcd4W-apRHqMqlzxYi3RtTsJ-jnC9wGlLHnepU1QG5z0mUmcTT6F4w3TiSbcU20ByLo6MlUBIJ1MYuvtdl8FNGY3PUq3b3JzCSHnMs30TQsouIa?width=1584&height=588&cropmode=none)


## Context
A few sentences to introduce the topic of the research

## Datasets
The data sets used in the study can be found in the "dataset" folder. 

The first data set contains the results of the dose-response experiments. Each line depict the results for one population of one species at one concentration of one pesticide. 
+ insecticides-mortality.txt
  + *population_ID*: population ID
  + *species*: the species of *Bemisia tabaci* (either IO or MEAM1)


## R scripts
+ **bemG_load_data.R**: the script to load the different data sets and the necessary packages in the environment
+ **bemG_dapc_ana.R**: the script to perform the DAPC analysis
+ **bemG_div_ana.R**: a script to compute diversity indices for the population
+ **bemG_div_plot.R**: a script for plotting figures of diversity indices
+ **bemG_kdrdistriplot**: a script for plotting the distribution of the kdr mutations by species
+ **bemG_mult_str_plot**: the script to plot Figure 3 and Figure 4 STUCTURE and STRUCTURE like plot of the average 50 runs of STRUCTURE for the best K for the two species, their hybrid status and their kdr1 genotype. The code for an additionnal figure is also included
+ **bemG_str_50plot.R**: the script to plot the 50 runs of STRUCTURE for K ranging from 2 to 6
+ **bemG_strplot_fun.R**: the function to plot STRUCTURE plot


## Citation
You will (hopefully) soon be able to cite the related study: 
+ Taquet A., Jourdan-Pineau H., Simiand C., Grondin M., Barrès B. and Delatte H. [Distribution of invasive *versus* native whitefly species and their pyrethroid knock-down resistance allele in a context of interspecific hybridization]()

If you want to use (some of) the code found on this page or if you want to cite this repository: 
+ Benoit Barrès. bbarres/bemisiaGen: [Supporting data and code for: Distribution of invasive *versus* native whitefly species and their pyrethroid knock-down resistance allele in a context of interspecific hybridization. Zenodo; 2022.]()

