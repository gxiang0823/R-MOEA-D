function [Chrom_AfterDecoded, Objective_Value] = Calculate_Objective(Chrom,Function_Number,Cap,X)
NIND = size(Chrom,1);
Vertexs = X(:,2:3);
dist = pdist(Vertexs);
Dist_Table = squareform(dist);
Cusnum_Number = size(X,1)-1;            %Number of Target Points
Target_Demand = X(2:end,4);             %Target Point Demand
Objective_Value = zeros(NIND,Function_Number);
Chrom_AfterDecoded = cell(NIND,1);
for i = 1:NIND
    Decoding_Flag = 1 * Chrom(i,end) + 2 * Chrom(i,end - 1) + 4 * Chrom(i,end - 2);
    switch Decoding_Flag
        case 0              %Split according to the number 0 in the first encoding
            Chrom_Decoded = Decoding_0(Chrom(i,1:end - 3),Cusnum_Number,Target_Demand);
        case 1              %Return when the loading capacity is greater than 60%
            Chrom_Decoded = Decoding_1(Chrom(i,1:end - 3),Cusnum_Number,Target_Demand,Cap);
        case 2              %Try to fill up as much as possible without splitting
            Chrom_Decoded = Decoding_2(Chrom(i,1:end - 3),Cusnum_Number,Target_Demand,Cap);
        case 3              %Split with full load, determine distance and exchange positions
            Chrom_Decoded = Decoding_3(Chrom(i,1:end - 3),Cusnum_Number,Target_Demand,Cap,Dist_Table);
        case 4              %Dismantling when the remaining capacity can meet more than half of the next task point
            Chrom_Decoded = Decoding_4(Chrom(i,1:end - 3),Cusnum_Number,Target_Demand,Cap);
        case 5              %The next task point is greater than the previous average demand disassembly
            Chrom_Decoded = Decoding_5(Chrom(i,1:end - 3),Cusnum_Number,Target_Demand,Cap);
        case 6              %Not reaching 90% loading, not splitting if exceeding
            Chrom_Decoded = Decoding_6(Chrom(i,1:end - 3),Cusnum_Number,Target_Demand,Cap);
        case 7              %Determine whether to split based on average distance
            Chrom_Decoded = Decoding_7(Chrom(i,1:end - 3),Cusnum_Number,Target_Demand,Cap,Dist_Table);
        otherwise
            break;
    end
    Chrom_AfterDecoded{i} = Chrom_Decoded;
end
for j = 1:NIND
    Obj_Val = Cal_Obj(Chrom_AfterDecoded{j},Dist_Table,Function_Number,Cusnum_Number,Target_Demand);
    Objective_Value(j,:) = Obj_Val;
end
Max_Energy = 10;
Max_Time = 10;
for j = 1:NIND
    for k = 1:Function_Number
        if k == 1
            Objective_Value(j,k) = Objective_Value(j,k)/Max_Energy;
        else
            Objective_Value(j,k) = Objective_Value(j,k)/Max_Time;
        end
    end
end
    