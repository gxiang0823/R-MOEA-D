function [Child_1, Child_2] = Crossover(Chrom_1,Chrom_2,Chrom_Length,Cap,X)
Rand_Arr = randperm(4);
Rand_Index = Rand_Arr(1);
switch Rand_Index
    case 1
        [Child_1, Child_2] = SBX(Chrom_1,Chrom_2,Chrom_Length,Cap,X);
    case 2
        [Child_1, Child_2] = SEX(Chrom_1,Chrom_2,Chrom_Length,Cap,X);
    case 3
        [Child_1, Child_2] = PMX(Chrom_1,Chrom_2,Chrom_Length,Cap,X);
    case 4
        [Child_1, Child_2] = OX(Chrom_1,Chrom_2,Chrom_Length,Cap,X);
end