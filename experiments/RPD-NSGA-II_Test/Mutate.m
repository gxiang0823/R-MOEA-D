function Child = Mutate(Chrom, Pm,Chrom_Length,Target_Demand,Cap)
n = numel(Chrom);
for i = 1:n
    r = rand(1);
    if r<Pm
        x = rand(2);
        m = x(1);
        if m==1
            Child = Swap(Chrom,Chrom_Length,Target_Demand,Cap);
        else
            Child = Inversion(Chrom,Chrom_Length,Target_Demand,Cap);
        end
    else
        Child = Chrom;
    end
end
