function External_Set = Record_ExternalSet(Chrom,Objective_Value)
Function_Number = size(Objective_Value,2);
recoder = [];
NIND = size(Chrom,1);
External_Set = [Chrom, Objective_Value];
for i = 1:NIND
    for j = 1:NIND
        if i ~= j
            less = 0;
            equal = 0;
            greater = 0;
            for k = 1:Function_Number
                if(Objective_Value(i,k) < Objective_Value(j,k))
                    less = less + 1;
                elseif(Objective_Value(i,k) == Objective_Value(j,k))
                    equal = equal + 1;
                else
                    greater = greater + 1;
                end
            end
            if (less == 0 && equal ~= Function_Number)
                recoder = [recoder, i];
                break;
            end
        end
    end
%     External_Set = [External_Set; Chrom(i,:), Objective_Value(i,:)];
end
res_recoder = flip(recoder);
for m = 1:length(res_recoder)
    External_Set(res_recoder(m),:) = [];
end