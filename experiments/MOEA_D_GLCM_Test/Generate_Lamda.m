function Lamda = Generate_Lamda(After_Chrom,NIND,Function_Number,z)
Lamda_Init = zeros(NIND,Function_Number);
Lamda = zeros(NIND,Function_Number);
Obj_Val = After_Chrom(:,end-1:end);
for i = 1:NIND
    for j = 1:Function_Number
        Lamda_Init(i,j) = (1/((Obj_Val(i,j))-z(j)))/(1/((Obj_Val(i,1))-z(1)) + 1/((Obj_Val(i,2))-z(2)));
        if isnan(Lamda_Init(i,j))
            Lamda_Init(i,j) = 1;
        end
    end
end
dist = pdist(Lamda_Init);
Dist_Lamda = squareform(dist);
Dist_Lamda(Dist_Lamda == 0) = NaN;
for k = 1:NIND
    [sortedValues, sortedIndices] = sort(Dist_Lamda(k,:));
    minValues = mean(sortedValues(1:2));
    for m = 1:Function_Number
        Lamda(k,m) = Lamda_Init(k,m)+minValues;
    end
end