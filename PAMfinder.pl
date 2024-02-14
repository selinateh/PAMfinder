#!/usr/bin/perl

$last = 0;
####read in variants file
open (FILE, $ARGV[0]);
while ($line = <FILE>)
{
   if ($line !~ /^#/)
   {
###split the variant file into counts and variant allele fractions for both tumor and normal 
      @array = split(/\t/, $line);
      @arrayT = split(/:/, $array[9]);
      @arrayN = split(/:/, $array[10]);
      @nT = split(/,/, $arrayT[1]);
      @nN = split(/,/, $arrayN[1]);

###filter the variants by the total read count should be greater than 18 for both the tumor and normal, limit the analysis to only SNPs and the tumor VAF is greater than 0.3
# added VCF Filter PASS check - 02-2023
      if ($nT[0]+$nT[1] >= 18 && $nN[0]+$nN[1] >= 18 && length($array[4])==1 && $arrayT[2]>0.3 && $array[6] eq "PASS")
      {
         if ($array[0] ne $last)
         {
            $seq = "";
####hard coded the chromosome fasta file's location
            open (SEQ, "/data/ngsc4data/NGSC_reference/Human/hg38/$array[0].fa");
            while ($seqline = <SEQ>)
            {
               if ($seqline !~ />/)
               {
                  $seqline =~ s/\n//;
                  $seq .= uc($seqline);
               }
            }
            $last = $array[0];
         }
##########search SNPs along the genome for possible PAM sites. Print to a file the chromosome, position, reference allele, variant allele, tumor VAF, tumor read depth, and whether it is a new PAM site.
         $subseq2 = substr($seq, $array[1]-24, 23);
         $var = lc(substr($seq, $array[1]-1, 1));
         $subseq3 = substr($seq, $array[1], 23);
         $subseq = $subseq2 . $var . $subseq3;
         $site = substr($subseq, 22, 3);
         if ($array[4] eq "G")
         {
            if ($site =~ /G/)
            {
               $str = substr($subseq, 1, 24);
               print ("$array[0]\t$array[1]\t$array[3]\t$array[4]\t$arrayT[2]\t$nT[0]\t$nT[1]\t+\t$str\tPAMCREATED\n");
            }
         } elsif ($array[4] eq "C")
         {
            if ($site =~ /C/)
            {
               $str = substr($subseq, 22, 24);
               print ("$array[0]\t$array[1]\t$array[3]\t$array[4]\t$arrayT[2]\t$nT[0]\t$nT[1]\t-\t$str\tPAMCREATED\n");
            }
         }
      }
   }
}
