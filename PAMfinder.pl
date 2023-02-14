#!/usr/bin/perl

$last = 0;
open (FILE, $ARGV[0]);
while ($line = <FILE>)
{
   if ($line !~ /^#/)
   {
      @array = split(/\t/, $line);
      @arrayT = split(/:/, $array[9]);
      @arrayN = split(/:/, $array[10]);
      @nT = split(/,/, $arrayT[1]);
      @nN = split(/,/, $arrayN[1]);

	# added VCF Filter PASS check - 02-2023

      if ($nT[0]+$nT[1] >= 18 && $nN[0]+$nN[1] >= 18 && length($array[4])==1 && $arrayT[2]>0.2 && $array[6] eq "PASS")
      {
         if ($array[0] ne $last)
         {
            $seq = "";
            open (SEQ, "E:/ICGC/hg38/$array[0].fa");
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
