# PAMfinder
PAMfinder identifies novel “NGG” protospacer adjacent motifs (PAMs) from variant call files (VCFs) generated from next generation sequencing. Somatic NGG PAMs can serve as tumor-specific CRISPR-Cas9 targets.  

## Background
  CRISPR-Cas9 requires a specific protospacer adjacent motif (PAM) as a binding signal for Cas9 activity, as the PAM sequence evolutionally allows the bacterial adaptive immune system to differentiate between self (contains the gRNA sequence but lacks the PAM) and non-self DNA (contains both the gRNA sequence and the PAM). Analogously, CRISPR-Cas9 can distinguish between cancer cells (containing PAMs from somatic mutations) and normal cells (lacking PAMs) for selective cancer killing. The most commonly used CRISPR-Cas9 system, derived from Streptococcus pyogenes, recognizes a PAM sequence of “NGG” (any nucleotide followed by two guanine (G) bases).  
  PAMfinder requires that the user downloads individual chromosomes for the desired reference genome. When supplied with a tumor-normal (T-N) subtracted VCF, PAMfinder looks at each single base substitution (SBS) or indel and determines if it changes any A, C, or T nucleotide to a G nucleotide. If so, it queries the reference human genome to determine whether a native G immediately precedes or follows the novel G and produces GG (one G from the mutation, and one native G). In addition, it also looks for mutations that produce novel Cs that are immediately upstream or downstream of a native C, thereby producing CC which would be GG on the complementary strand. The output provides the subset of mutations from the input VCF that create novel NGG sites. 
  An analysis of 591 whole genome sequencing T-N VCFs from the International Cancer Genome Consortium (ICGC) comparing the number of somatic SBSs to the number of novel PAMs showed that approximately 10% of the SBSs were PAM-creating (https://doi.org/10.1101/2023.04.15.537042).  

## SBSfilter.pl
SBSfilter scans the list of point mutations in the VCF and identifies mutations that pass the read depth and variant allele frequency (VAF) filters set by the user. Only mutations that are reported as PASS by the filter used by the variant caller are included. The script assumes that the tumor is on column 10 of the VCF and normal is on column 11, so user has to change the array orientation accordingly based on the VCF to the acceptable format prior to executing PAMfinder.
Input: T-N subtracted VCF

## PAMfinder.pl
PAMfinder is an extension of the SBSfilter. The output contains a list of somatic variants that form novel PAMs (see Background), including information about the somatic variant, sequence flanking the mutation, and +/- to indicate whether the novel PAM is located on the plus or minus strand of the genome.
Prerequisite: FASTAs of all individual chromosomes have to be downloaded prior to running PAMfinder. Users can download FASTAs of individual chromosomes (https://hgdownload2.soe.ucsc.edu/downloads.html) by choosing “Sequence data by chromosome” (e.g. for hg38: https://hgdownload2.soe.ucsc.edu/goldenPath/hg38/chromosomes/). Once downloaded and unzipped, “chr#” has to be removed from the beginning of the file name (e.g. change “chr1.fa” to “1.fa”). The directory containing all FASTAs have to be coded into the script.
Input: T-N subtracted VCF

License: GPL (>=3)
