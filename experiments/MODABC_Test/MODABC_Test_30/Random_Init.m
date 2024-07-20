function Chrom = Random_Init(Cusnum_Number,Vehicle_Number,NIND,Rule_Number,Target_Demand,Cap)
Chrom_Length = Cusnum_Number + Vehicle_Number - 1;
RuleArray = [0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; 1 1 1];
AllLength = Chrom_Length + 3;
Chrom = zeros(NIND, AllLength);
Cus_Arr = randperm(Cusnum_Number);
Veh_Arr = zeros(1,Vehicle_Number-1);
Chrom_Ref = [Cus_Arr,Veh_Arr];
for j = 1:NIND
    row = mod(j,Rule_Number);
    if row == 0
        row = 8;
    end
    Chrom(j,end - 2:end) = RuleArray(row,:);
    index = randperm(Chrom_Length);
    if row == 1
        flag = 1;
        while flag
            index = randperm(Chrom_Length);
            for k = 1:Chrom_Length
                Chrom(j,k) = Chrom_Ref(index(k));
            end
            flag = Judge(Chrom(j,:),Chrom_Length,Target_Demand,Cap);
        end
    else
        for k = 1:Chrom_Length
            Chrom(j,k) = Chrom_Ref(index(k));
        end
    end
end