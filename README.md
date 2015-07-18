# linkageMapAnchoring
Anchoring variants in genomic scaffolds to linkage map

Mikhail V. Matz, matz@utexas.edu
May 2015

The goal is to take a VCF file with variants within genomic scaffolds, a table with linkage map positions for
some of these variants, and create a VCF file with all variants rewritten in chromosome-wide base coordinates.

The main script (vcf2map.pl) does the following:
- extracts consistently mapped segments (two or more consecutive markers mapping to the same linkage group);
- determines average map location and orientation of the segments (calculated from base pair difference between the first half and second half of markers);
- calculates local recombination rate (cM/Mb) - I find this pretty noisy though;
- writes a new VCF file with chromosome-wide marker coordinates;
- single-marker scaffolds are anchored trivially, assuming direct orientation.

In this way the scaffold segments are forced to be contiguous, i.e., we trust the sequence assembly more than we trust the linkage map.

The key parameter in vcf2map.pl is cmmb - centimorgan per megabase (recombination rate). The rate estimated from data seems to be too high, so set it reasonably: a good guess is length of the linkage map divided by the size of the genome.

Too high rec.rate will cause scaffold coordinates to overlap. Use mapAnchoring_tests.R to see if this is the case. 

An accessory script scaffoldContiguityInLinkageMaps.R is to see whether the linkage map is more or less true to the scaffolds, i.e., does not break them up too much.

Data files included: 
oldMap.tab : linkage map for the coral Acropora millepora build with regressin algorithm, from Dixon et al Science 2015.
newMap.tab : an alternative version of the same map build with maximum likelihood algorithm.
Both maps are build from the same data using JoinMap software.

gatkFinal2digitifera.vcf : 2bRAD variants called in populations of A.millerora along the Great Barrier Reef, mapped to the genome of Acropora digitifera. This dataset is not yet published, so please contact Mikhail Matz if you would like to use it in your research.
