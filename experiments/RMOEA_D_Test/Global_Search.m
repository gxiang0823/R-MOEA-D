function [Child_1, Child_2] = Global_Search(Ind,After_Chrom,Rule_Number,Chrom_Length,Cap,Function_Number,X,NIND)
Rule_Num = NIND/Rule_Number;
Rule_Index = ceil(Ind/Rule_Num);
if Rule_Index == 0
    Rule_Index = 8;
end
switch Rule_Index
    case 1
        [Child_1, Child_2] = SBX_Swap(After_Chrom(((Rule_Index-1)*Rule_Num+1:(Rule_Index)*Rule_Num),:),Chrom_Length,Cap,Function_Number,X);
    case 2
        [Child_1, Child_2] = SBX_Inversion(After_Chrom(((Rule_Index-1)*Rule_Num+1:(Rule_Index)*Rule_Num),:),Chrom_Length,Cap,Function_Number,X);
    case 3
        [Child_1, Child_2] = SEX_Swap(After_Chrom(((Rule_Index-1)*Rule_Num+1:(Rule_Index)*Rule_Num),:),Chrom_Length,Cap,Function_Number,X);
    case 4
        [Child_1, Child_2] = SEX_Inversion(After_Chrom(((Rule_Index-1)*Rule_Num+1:(Rule_Index)*Rule_Num),:),Chrom_Length,Cap,Function_Number,X);
    case 5
        [Child_1, Child_2] = PMX_Swap(After_Chrom(((Rule_Index-1)*Rule_Num+1:(Rule_Index)*Rule_Num),:),Chrom_Length,Cap,Function_Number,X);
    case 6
        [Child_1, Child_2] = PMX_Inversion(After_Chrom(((Rule_Index-1)*Rule_Num+1:(Rule_Index)*Rule_Num),:),Chrom_Length,Cap,Function_Number,X);
    case 7
        [Child_1, Child_2] = OX_Swap(After_Chrom(((Rule_Index-1)*Rule_Num+1:(Rule_Index)*Rule_Num),:),Chrom_Length,Cap,Function_Number,X);
    case 8
        [Child_1, Child_2] = OX_Inversion(After_Chrom(((Rule_Index-1)*Rule_Num+1:(Rule_Index)*Rule_Num),:),Chrom_Length,Cap,Function_Number,X);
end


        