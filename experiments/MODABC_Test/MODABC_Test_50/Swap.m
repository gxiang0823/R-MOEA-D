function Child = Swap(Chrom,Chrom_Length,Target_Demand,Cap)
Child = Chrom(1:Chrom_Length);
Flag = 1;
while Flag
    Sw_Index = randperm(length(Child));
    Temp = Child(Sw_Index(1));
    Child(Sw_Index(1)) = Child(Sw_Index(2));
    Child(Sw_Index(2)) = Temp;
    if (Chrom(Chrom_Length+1)==Chrom(Chrom_Length+2)==Chrom(Chrom_Length+3)==0)
        Flag = Judge(Child,Chrom_Length,Target_Demand,Cap);     %flag = 1  ---->  illegality    flag = 0  ---->  legal
    else
        Flag = 0;
    end
end
Child = [Child, Chrom(Chrom_Length+1:Chrom_Length+3)];