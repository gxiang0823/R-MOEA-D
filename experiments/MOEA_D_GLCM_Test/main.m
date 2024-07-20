clc
clear
close all
%% Input
load Example_50.mat
load Refer_50.mat
IGD_50 = zeros(20,1);
HV_50 = zeros(20,1);
for example_count = 1:20
    X = Example_50{example_count};
    P = Refer_50{example_count};
    Cusnum_Number = size(X,1)-1;            %Number of Target Points
    Cap = 150;                              %Vehicle Loading Capacity                       %-----10-----50-----5
    Vehicle_Number = 10;                    %Number of Vehicle                              %-----20-----50-----10
    NIND = 200;                             %Population Size                                %-----30-----80-----10
    Neighbor_Number = 10;                   %Number of Neighbor Vectors  ----  10           %-----40-----100----10
    Function_Number = 2;                    %Number of Objective Functions                  %-----50-----150----10
    Target_Demand = X(2:end,4);             %Target Point Demandcc
    Chrom_Length = Cusnum_Number + Vehicle_Number - 1;
    Vertexs = X(:,2:3);
    dist = pdist(Vertexs);
    Dist_Table = squareform(dist);
    Rule_Number = 8;                                                %Number of Rules
    %% Random Initial Solution
    Chrom = Random_Init(Cusnum_Number,Vehicle_Number,NIND,Rule_Number,Target_Demand,Cap);
    [Chrom_AfterDecoded, Objective_Value] = Calculate_Objective(Chrom,Function_Number,Cap,X);
    z = Init_Z(Objective_Value,Function_Number);
    z_ideal = z(1,:);
    z_nadir = z(2,:);
    External_Set = Record_ExternalSet(Chrom,Objective_Value);       %Record External Set
    EP = External_Set;
    After_Chrom = Distinguish(Chrom,Rule_Number,Objective_Value);
    Lamda = Generate_Lamda(After_Chrom,NIND,Function_Number,z(1,:));                   %Obtain Weight Vector
    Neighbor_Vector = Find_Neighbor(Lamda,Neighbor_Number);         %Generate Neighbor Vector
    result_recorder = cell(30,1);
    time_count = 1;
    while time_count <= 30
        tused = 0;
        iter = 1;
        tic;
        tstart = tic;
        while tused <= 60
            % Global Search Operator
            for Ind = 1:NIND
                if mod(Ind, 2)
                    [Child_1, Child_2] = Global_Search_Effect(After_Chrom,Chrom_Length,Cap,Function_Number,X);
                    for j = 1:Function_Number
                        z_nadir(end-j+1) = max(z_nadir(end-j+1),Child_1(end-j+1));
                    end
                    for j = 1:Function_Number
                        z_nadir(end-j+1) = max(z_nadir(end-j+1),Child_2(end-j+1));
                    end
                    After_Chrom = Update_Neighbor(Lamda,z_ideal,After_Chrom,Neighbor_Vector(Ind,:),Child_1,Child_2,Function_Number,Cap,X,Chrom_Length);
                else
                    [Child_1, Child_2] = Global_Search_Effect(After_Chrom,Chrom_Length,Cap,Function_Number,X);
                    for j = 1:Function_Number
                        z_ideal(end-j+1) = min(z_ideal(end-j+1),Child_1(end-j+1));
                    end
                    for j = 1:Function_Number
                        z_ideal(end-j+1) = min(z_ideal(end-j+1),Child_2(end-j+1));
                    end
                    After_Chrom = Update_Neighbor(Lamda,z_nadir,After_Chrom,Neighbor_Vector(Ind,:),Child_1,Child_2,Function_Number,Cap,X,Chrom_Length);
                    EP = Update_Ep(EP,[Child_1;Child_2],Function_Number);
                end
            end
            iter = iter + 1;
            [After_Chrom, Combination_Chrom] = Combination(Function_Number,Cap,X,After_Chrom,Vehicle_Number);
            EP = Update_Ep(EP,Combination_Chrom,Function_Number);
            if mod(iter,10) == 0
                fprintf('%d gen has completed!\n',iter);
            end
            tused = toc(tstart);
        end
        result_recorder{time_count} = EP(:,end-1:end);
        time_count = time_count + 1;
        disp(time_count);
    end
    for k = 1:30
        IGDAll = zeros(30,1);
        HVAll = zeros(30,1);
        Cal = result_recorder{k};
        m = size(Cal,1);
        n = size(P,1);
        for index = 1:m
            if index == 1
                area = abs(20-Cal(index,1)) * abs(20-Cal(index,2));
            else
                area = abs(Cal(index,1)-Cal(index-1,1)) * abs(20 - Cal(index,2));
            end
            HVAll(k) = HVAll(k) + area;
        end
        IGD_num = zeros(m,1);
        for i = 1:m
            Temp_Cal = Cal(i,:);
            min_dis = sqrt((Temp_Cal(1)-P(1,1))^2 + (Temp_Cal(2)-P(1,2))^2);
            for j = 1:n
                min_dis = min(min_dis,sqrt((Temp_Cal(1)-P(j,1))^2 + (Temp_Cal(2)-P(j,2))^2));
            end
            IGD_num(i) = min_dis;
        end
        Sum = sum(IGD_num);
        Sum_IGD = Sum/n;
        IGDAll(k) = Sum_IGD;
    end
    IGD = mean(IGDAll);
    HV = mean(HVAll);
    IGD_50(example_count) = IGD;
    HV_50(example_count) = HV;
end
save('IGD_10.mat','IGD_10');
save('HV_10.mat','HV_10');