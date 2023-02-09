# PAMfinder
PAMfinder identifies novel NGG PAMs from variant call files containing point mutations.

## SBSfilter.pl
SBSfilter scans the list of point mutations in the variant call file (VCF) and identifies mutations that pass the read depth and variant allele frequency (VAF) filters set by the user. Only mutations that are reported as PASS by the filter used by the variant caller are included. The script assumes that the tumor is on column 10 of the VCF and normal is on column 11, so user has to change the array orientation accordingly based on the VCF.
Input: VCF

## PAMfinder.pl
PAMfinder is an extension of the SBSfilter. It is written to process VCFs based on their genome builds to identify somatic variants that produce novel NGG PAMs. For somatic variants that pass through the filters mentioned in SBSfilter, the 5' and 3' genomic sequences flanking the somatic variants are obtained from the FASTA of their corresponding chromosomes to inspect whether novel Cs are adjacent to an exisiting C or novel Gs are adjacent to an existing G. The output contains a list of somatic variants that form novel PAMs, including information about the somatic variant, sequence flanking the mutation, and +/- to indicate whether the novel PAM is located on the plus or minus strand of the genome.
Prerequisite: FASTAs of individual chromosomes
Input: VCF
