function Chrom = Init_Chrom(Init_Pop,NIND,Rule_Number,Chrom_Length,Target_Demand,Cap)
RuleArray = [0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; 1 1 1];
AllLength = Chrom_Length + 3;
Chrom = zeros(NIND, AllLength);

VN = size(Init_Pop,1);
Route = [];
for i = 1:VN
    vc = Init_Pop{i};
    for j = 1:length(vc)
        Temp_R = [Route, vc(j)];
        Route = Temp_R;
    end
    Temp_R = [Route, 0];
    Route = Temp_R;
end
if length(Route) < Chrom_Length
    Temp = zeros(1,Chrom_Length - length(Route));
    Route = [Route,Temp];
end
Route = [Route,RuleArray(1,:)];
for i = 1:Rule_Number
    Chrom(i,1:Chrom_Length) = Route(1:Chrom_Length);
end
for i = 1:Rule_Number
    Chrom(i,end - 2:end) = RuleArray(i,:);
end
for j = Rule_Number + 1:NIND
    row = mod(j,Rule_Number);
    if row == 0
        row = 8;
    end
    Chrom(j,end - 2:end) = RuleArray(row,:);
    Temp_Pop = Route(1:Chrom_Length);
    index = randperm(Chrom_Length);
    if row == 1
        flag = 1;
        while flag
            index = randperm(Chrom_Length);
            for k = 1:Chrom_Length
                Chrom(j,k) = Temp_Pop(index(k));
            end
            flag = Judge(Chrom(j,:),Chrom_Length,Target_Demand,Cap);
        end
    else
        for k = 1:Chrom_Length
            Chrom(j,k) = Temp_Pop(index(k));
        end
    end
end