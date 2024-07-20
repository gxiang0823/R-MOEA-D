function Path_Energy = Calculate_PathEnergy(Receive_Position, Insert_Position, Dist_Table, Target_Demand, AfterMerge_Path)
m = length(Receive_Position);
Load_Sum_A = 0;
Len_Sum_A = 0;
for i = 1:m
    Load_Sum_A = Load_Sum_A + Target_Demand(Receive_Position(i));
end
if m > 1
    for i = 1:m - 1
        Len_Sum_A = Len_Sum_A + Dist_Table(Receive_Position(i)+1,Receive_Position(i+1)+1);
    end
end
Len_Sum_A = Len_Sum_A + Dist_Table(1,Receive_Position(1)+1) + Dist_Table(Receive_Position(end)+1,1);
Aver_A = mean(Load_Sum_A);

n = length(Insert_Position);
Load_Sum_B = 0;
Len_Sum_B = 0;
for i = 1:n
    Load_Sum_B = Load_Sum_B + Target_Demand(Insert_Position(i));
end
if n > 1
    for i = 1:n - 1
        Len_Sum_B = Len_Sum_B + Dist_Table(Insert_Position(i)+1,Insert_Position(i+1)+1);
    end
end
Len_Sum_B = Len_Sum_B + Dist_Table(1,Insert_Position(1)+1) + Dist_Table(Insert_Position(end)+1,1);
Aver_B = mean(Load_Sum_B);

k = length(AfterMerge_Path);
Load_Sum_C = 0;
Len_Sum_C = 0;
for i = 1:k
    Load_Sum_C = Load_Sum_C + Target_Demand(AfterMerge_Path(i));
end
if k > 1
    for i = 1:k - 1
        Len_Sum_C = Len_Sum_C + Dist_Table(AfterMerge_Path(i)+1,AfterMerge_Path(i+1)+1);
    end
end
Len_Sum_C = Len_Sum_C + Dist_Table(1,AfterMerge_Path(1)+1) + Dist_Table(AfterMerge_Path(end)+1,1);
Aver_C = mean(Load_Sum_C);

% Path_Energy = Aver_A/Len_Sum_A + Aver_B/Len_Sum_B - Aver_C/Len_Sum_C;
Path_Energy = Len_Sum_A/Aver_A + Len_Sum_B/Aver_B - Len_Sum_C/Aver_C;