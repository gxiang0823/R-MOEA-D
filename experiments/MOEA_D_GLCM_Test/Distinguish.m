function After_Chrom = Distinguish(Chrom,Rule_Number,Objective_Value)
Distin_Chrom = cell(Rule_Number,1);
NIND = size(Chrom,1);
for i = 1:Rule_Number
    Distin_Chrom{i} = [Chrom(i,:), Objective_Value(i,:)];
end
for NP = Rule_Number + 1:NIND
    row = mod(NP,Rule_Number);
    if row == 1
        Distin_Chrom{1} = [Distin_Chrom{1};Chrom(NP,:),Objective_Value(NP,:)];
    elseif row == 2
        Distin_Chrom{2} = [Distin_Chrom{2};Chrom(NP,:),Objective_Value(NP,:)];
    elseif row == 3
        Distin_Chrom{3} = [Distin_Chrom{3};Chrom(NP,:),Objective_Value(NP,:)];
    elseif row == 4
        Distin_Chrom{4} = [Distin_Chrom{4};Chrom(NP,:),Objective_Value(NP,:)];
    elseif row == 5
        Distin_Chrom{5} = [Distin_Chrom{5};Chrom(NP,:),Objective_Value(NP,:)];
    elseif row == 6
        Distin_Chrom{6} = [Distin_Chrom{6};Chrom(NP,:),Objective_Value(NP,:)];
    elseif row == 7
        Distin_Chrom{7} = [Distin_Chrom{7};Chrom(NP,:),Objective_Value(NP,:)];
    elseif row == 0
        Distin_Chrom{8} = [Distin_Chrom{8};Chrom(NP,:),Objective_Value(NP,:)];
    end
end
After_Chrom = [];
for i = 1:Rule_Number
    After_Chrom = [After_Chrom; Distin_Chrom{i}];
end