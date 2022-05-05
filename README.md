[![DOI](https://zenodo.org/badge/240797439.svg)](https://zenodo.org/badge/latestdoi/240797439)

# Supporting data and code for: Distribution of invasive *versus* native whitefly species and their pyrethroid knock-down resistance allele in a context of interspecific hybridization

*The data and R code used for the related study. This study is a part of the PhD thesis of Alizée Taquet.*

![alt_text](https://am3pap005files.storage.live.com/y4mLAUTj_dFHf9lTTOqNQUOcfotjPFDX-sTivwhbD9sfyuCOipemF_KtXczK-fLqGRmdicIWShqNNEYshw0UZcd4W-apRHqMqlzxYi3RtTsJ-jnC9wGlLHnepU1QG5z0mUmcTT6F4w3TiSbcU20ByLo6MlUBIJ1MYuvtdl8FNGY3PUq3b3JzCSHnMs30TQsouIa?width=1584&height=588&cropmode=none)

## Context
A few sentences to introduce the topic of the research

## Datasets
In this section, you will find the list of the data sets used to produce the figures of the manuscript. The data files can be found in the "data" folder. For the data tables, the name of the different variables are listed and explained as well below. There are 4 data sets used in this study.  
 
+ **bem_genepop.txt:** the first data set contains the results of the dose-response experiments. Each line depict the results for one population of one species at one concentration of one pesticide.
  + *whitefly_ID*: the ID of the indivual (unique for each individual)
  + *species*: the species of *Bemisia tabaci* (either IO, MEAM1, MED-Q or Hybrid)
  + *pop_geo*: the ID of the geographic location of the population
  + *pop_geo_env*: the ID of the environmental type within the geographic population
  + *collection_date*: the date of the collection of the samples
  + *latitude*: the latitude coordinate of the population in degrees and decimal WGS84 format
  + *longitude*: the longitude coordinate of the population in degrees and decimal WGS84 format
  + *environment*: the type of environment the individuals were sampled from. In order of increasing level of artificialization *Non-cultivated*, *Field_surroundings*, *Open_ields* and *Greenhouse*
  + *host_plant*:
  + *insecticide_treat*:
  + *insecticide_list*:
  + *H06, MS145, P59, P7, D04, P5, G03, SSA13, SSA2, SSA41, SSA6*: microsatellite data (coded as the length of the alleles with 3 digits for each allele). The columns' name correspond to the name of the microsatellite markers
  + *mut_L925I*:
  + *mut_T929V*:
  + *MeIo_clust1,	MeIo_clust2*: Q-matrix for IO and MEAM1, obtained by averaging the runs belonging to the major solution over 50 runs with K=2
  + *Med_clust1, Med_clust2,	Med_clust3*: Q-matrix for MED, obtained by averaging the runs belonging to the major solution over 50 runs with K=3

+ **barplotkdr.txt:** the second data set contains the frequency of the *kdr* genotype for each *B. tabaci* species. 
  + *species*: the species of *Bemisia tabaci* (either IO, MEAM1, MED or Hybrids)
  + *mutation*: the genotype at the *kdr* locus using the codon coding (either L925/L925, L925/I925 or I925/I925)
  + *genotype*: the genotype at the *kdr* locus using resistance/sensitive coding (either SS, RS or RR)
  + *n*: the number of individuals identified for each species by *kdr* genotype combination

+ **50runs:** a folder containing 15 files that allow the plotting of 50 STRUCTURE runs for each K of interest (from K=2 to K=3 for IO and MEAM1, and from K=2 to K=4 for MED)

+ **shapefiles:** a folder containing the shapefiles for plotting maps (source DEAL REUNION, 2020)


## R scripts
In this section, you will find the list of the different scripts used in the article to produce the figures with a brief description of their purpose.

+ **bemG_load_data.R**: the script to load the different data sets and the necessary packages in the environment
+ **bemG_dapc_ana.R**: the script to perform the DAPC analysis
+ **bemG_div_ana.R**: a script to compute diversity indices for the population
+ **bemG_div_plot.R**: a script for plotting figures of diversity indices
+ **bemG_kdrdistriplot.R**: a script for plotting the distribution of the kdr mutations by species
+ **bemG_mult_str_plot.R**: the script to plot Figure 3 and Figure 4 STUCTURE and STRUCTURE like plot of the average 50 runs of STRUCTURE for the best K for the two species, their hybrid status and their kdr1 genotype. The code for an additionnal figure is also included
+ **bemG_str_50plot.R**: the script to plot the 50 runs of STRUCTURE for K ranging from 2 to 3 and from 2 to 4 for BMS and Q species, respectively
+ **bemG_strplot_fun.R**: the function to plot STRUCTURE plot
+ **bemG_map_fig.R**: the script to plot some maps of La Réunion (one of which is used to illustrate this Github repository)


## Citation
You will soon be able to cite the related study: 
+ Taquet A., Jourdan-Pineau H., Simiand C., Grondin M., Barrès B.\* and Delatte H.\* [Distribution of invasive *versus* native whitefly species and their pyrethroid knock-down resistance allele in a context of interspecific hybridization. *Scientific Reports*.]()

If you want to use (some of) the code found on this page or if you want to cite this repository: 
+ Benoit Barrès. [Supporting data and code for: Distribution of invasive *versus* native whitefly species and their pyrethroid knock-down resistance allele in a context of interspecific hybridization. Zenodo.](https://zenodo.org/badge/latestdoi/240797439)

