clc
clear
close all
%% Input
load Example_30.mat
load Refer_30.mat
IGD_30 = zeros(20,1);
HV_30 = zeros(20,1);
for example_count = 1:20
    X = Example_30{example_count};
    P = Refer_30{example_count};
    Cusnum_Number = size(X,1)-1;            %Number of Target Points
    Cap = 80;                               %Vehicle Loading Capacity                       %-----10-----50-----5
    Vehicle_Number = 10;                    %Number of Vehicle                              %-----20-----50-----10
    NIND = 200;                             %Population Size                                %-----30-----80-----10
    Neighbor_Number = 20;                   %Number of Neighbor Vectors  ----  10           %-----40-----100----10
    Function_Number = 2;                    %Number of Objective Functions                  %-----50-----150----10
    Target_Demand = X(2:end,4);             %Target Point Demandcc
    Chrom_Length = Cusnum_Number + Vehicle_Number - 1;
    Vertexs = X(:,2:3);
    dist = pdist(Vertexs);
    Dist_Table = squareform(dist);
    Pc = 0.9;
    Pm = 0.9;
    Nc = round(Pc * NIND / 2) * 2;
    Lamda = Generate_Lamda(NIND,Function_Number);                   %Obtain Weight Vector
    EP = [];                                                        %Set external file set to empty
    Rule_Number = 8;                                                %Number of Rules
    %% Define Result Storage Template
    empty.position = [];
    empty.cost = [];
    empty.referencepoint = [];
    empty.rank = [];
    empty.domination = [];
    empty.dominated = 0;
    empty.crowdingdistance = [];
    Chrom = repmat(empty, NIND, 1);
    %% Random Initial Solution
    Init_Pop = ICW_Init(Cusnum_Number,Dist_Table,Target_Demand,Cap);%Improved CW algorithm
    Pop = Init_Chrom(Init_Pop,NIND,Rule_Number,Chrom_Length,Target_Demand,Cap);     %Random Operator
%     Pop = Random_Init(Cusnum_Number,Vehicle_Number,NIND,Rule_Number,Target_Demand,Cap);
    [Chrom_AfterDecoded, Objective_Value] = Calculate_Objective(Pop,Function_Number,Cap,X);
    for i = 1:NIND
        Chrom(i).position = Pop(i,:);
        Chrom(i).cost = [Objective_Value(i,1); Objective_Value(i,2)];
        Chrom(i).referencepoint = Determine_referencepoint(Lamda,Chrom(i).cost);
    end
    %% non-dominated sorting
    [Chrom,F] = NonDominated_Sort(Chrom);
    %% Congestion calculation
    Chrom = Cal_CrowdingDistance(Chrom,F);
    %% main program
    result_recorder = cell(30,1);
    time_count = 1;
    while time_count <= 30
        tused = 0;
        iter = 1;
        tic;
        tstart = tic;
        while tused <= 60
            Pop_Off = repmat(empty, Nc/2,2);
            for j = 1 : Nc / 2
               P1 = tournamentsel(Chrom);
               P2 = tournamentsel(Chrom);
               [Pop_Off(j, 1).position, Pop_Off(j, 2).position] = Crossover(P1.position, P2.position,Chrom_Length,Cap,X);
            end
            Pop_Off = Pop_Off(:);
            for k = 1 : Nc
                Pop_Off(k).position = Mutate(Pop_Off(k).position, Pm,Chrom_Length,Target_Demand,Cap);
                [~, Objective_Value] = Calculate_Objective(Pop_Off(k).position,Function_Number,Cap,X);
                Pop_Off(k).cost = [Objective_Value(1); Objective_Value(2)];
            end
            New_Chrom = [Chrom; Pop_Off];
            [Chrom,F] = NonDominated_Sort(New_Chrom);
            Chrom = Cal_CrowdingDistance(Chrom,F);
            % 排序
            Chrom = Sort_Chrom(Chrom);
            % 淘汰
            Chrom = Chrom(1: NIND);
            [Chrom,F] = NonDominated_Sort(Chrom);
            Chrom = Cal_CrowdingDistance(Chrom,F);
            Chrom = Sort_Chrom(Chrom);
            % 更新第一等级
            F1 = Chrom(F{1});
            iter = iter + 1;
            if mod(iter,10) == 0
                fprintf('%d gen has completed!\n',iter);
            end
            tused = toc(tstart);
        end
        EP_Num = numel(F1);
        EP = zeros(2,EP_Num);
        for e = 1:EP_Num
            EP(:,e) = F1(e).cost;
        end
        temp = EP(1, :);
        EP(1, :) = EP(2, :);
        EP(2, :) = temp;
        EP = EP';
        EP = unique(EP, 'rows', 'stable');
        result_recorder{time_count} = EP(:,end-1:end);
        time_count = time_count + 1;
        disp(time_count);
    end
    IGDAll = zeros(30,1);
    HVAll = zeros(30,1);
    for k = 1:30
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
    IGD_30(example_count) = IGD;
    HV_30(example_count) = HV;
end
save('IGD_30.mat','IGD_30');
save('HV_30.mat','HV_30');