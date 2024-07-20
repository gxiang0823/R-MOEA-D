function [Child_1, Child_2] = Global_Search_Effect(After_Chrom,Chrom_Length,Cap,Function_Number,X)
Target_Demand = X(2:end,4);             %Target Point Demand
m = size(After_Chrom,1);
arr = randperm(m);
Chrom_1 = After_Chrom(arr(1),1:end-Function_Number);
Chrom_2 = After_Chrom(arr(2),1:end-Function_Number);
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
x = rand(2);
m = x(1);
if m==1
    Child_1 = Swap(Child_1,Chrom_Length,Target_Demand,Cap);
    Child_2 = Swap(Child_2,Chrom_Length,Target_Demand,Cap);
else
    Child_1 = Inversion(Child_1,Chrom_Length,Target_Demand,Cap);
    Child_2 = Inversion(Child_2,Chrom_Length,Target_Demand,Cap);
end
[~,Obj_1] = Calculate_Objective(Child_1,Function_Number,Cap,X);
[~,Obj_2] = Calculate_Objective(Child_2,Function_Number,Cap,X);
Child_1 = [Child_1,Obj_1];
Child_2 = [Child_2,Obj_2];