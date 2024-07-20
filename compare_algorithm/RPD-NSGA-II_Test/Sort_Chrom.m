function Chrom = Sort_Chrom(Chrom)
[~, CDSO] = sort([Chrom.crowdingdistance], 'descend');
Chrom = Chrom(CDSO);

[~, RSO] = sort([Chrom.rank]);
Chrom = Chrom(RSO);