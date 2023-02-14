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
      if ($nT[0]+$nT[1] >= 18 && $nN[0]+$nN[1] >= 18 && length($array[4])==1 && $arrayT[2]>0.2 && $array[6] eq "PASS")
      {
         print ("$array[0]\t$array[1]\t$array[3]\t$array[4]\t$array[6]\t$arrayT[2]\t$nT[0]\t$nT[1]\t+\t$str\n");
      }
   }
}
           
