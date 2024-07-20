function Child = Inversion(Chrom,Chrom_Length,Target_Demand,Cap)
Parent = Chrom(1:Chrom_Length);
Flag = 1;
while Flag
    In_Index = randperm(length(Parent));
    Temp = Parent(In_Index(1):end);
    Temp = flip(Temp);
    Parent(In_Index(1):end) = Temp;
    if (Chrom(Chrom_Length+1)==Chrom(Chrom_Length+2)==Chrom(Chrom_Length+3)==0)
        Flag = Judge(Parent,Chrom_Length,Target_Demand,Cap);     %flag = 1  ---->  illegality    flag = 0  ---->  legal
    else
        Flag = 0;
    end
end
Child = [Parent, Chrom(Chrom_Length+1:Chrom_Length+3)];