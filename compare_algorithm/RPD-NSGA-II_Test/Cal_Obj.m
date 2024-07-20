function Obj_Val = Cal_Obj(Chrom_j,Dist_Table,Function_Number,Cusnum_Number,Target_Demand)
% Obj_Val  Energy  Time
E0 = 10;
omege = 1.5;        %  ----  1.5
Obj_Val = zeros(1,Function_Number);
Veh_Num = size(Chrom_j,1);
Ec_Sum = 0;
for i = 1:Veh_Num
    Task_Array = Chrom_j{i,1};
    Load_Array = Chrom_j{i,2};
    Task_Num = length(Task_Array);
    Load_Sum = 0;
    En = 0.1*(E0 + Load_Sum*omege);
    Tc_Sum = 0;
    for j = 1:Task_Num
        if j == 1
            Tc = Dist_Table(1,Task_Array(j)+1);
%             Tc = Dist_Table(1,Task_Array(j)+1) + 0.5 * Target_Demand(Task_Array(j));
            Ec = Dist_Table(1,Task_Array(j)+1)*En;
        else
            Tc = Dist_Table(Task_Array(j-1)+1,Task_Array(j)+1);
%             Tc = Dist_Table(Task_Array(j-1)+1,Task_Array(j)+1) + 0.5 * Target_Demand(Task_Array(j)) + Tc;
            Ec = (Dist_Table(Task_Array(j-1)+1,Task_Array(j)+1))*En + Ec;
        end
        Load_Sum = Load_Sum + Load_Array(j);
        Tc = Tc + Dist_Table(1,Task_Array(end)+1) + 0.5 * Load_Sum;
        En = 0.1*(E0 + Load_Sum*omege);
    end
    Ec = (Dist_Table(1,Task_Array(end)+1))*En + Ec;
    Ec_Sum = Ec + Ec_Sum + 200 * Veh_Num;
    Tc_Sum = max(Tc,Tc_Sum);
end
Obj_Val(1,1) = round(0.01*Ec_Sum,4);
Obj_Val(1,2) = Tc_Sum;