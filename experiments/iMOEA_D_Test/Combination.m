function [After_Chrom, Combination_Chrom] = Combination(Function_Number,Cap,X,After_Chrom,Vehicle_Number)
Target_Demand = X(2:end,4);
Cusnum_Number = size(X,1)-1;            %Number of Target Points
Chrom_Length = Cusnum_Number + Vehicle_Number - 1;
RuleArray = [0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; 1 1 1];
m = size(After_Chrom,1);
index = randperm(m);
Row = index(1);
Rule_Ind = mod(Row,m/8);
if Rule_Ind == 0
    Rule_Ind = m/8;
end
Operate_Chrom = After_Chrom(Row,:);
Operate_Chrom(end-4:end) = [];
Combin_Chrom = [];
for i = 1:size(RuleArray,1)
    Combin_Chrom(i,:) = [Operate_Chrom,RuleArray(i,:)];
end
[~, Objective_Combin] = Calculate_Objective(Combin_Chrom,Function_Number,Cap,X);
Combin_Chrom = [Combin_Chrom,Objective_Combin];
n = size(Combin_Chrom,1);
Combination_Chrom = [];
for j = 1:n
    Times_Count = 1;
    Temp_Chrom = Combin_Chrom(j,:);
    Search_Chrom = Temp_Chrom(1:end-5);
    while Times_Count <= 5
        len = length(Search_Chrom);
        Insert = randperm(len);
        In_Pos = Insert(1);
        Out_Pos = Insert(2);
        Temp = Search_Chrom(Out_Pos);
        Search_Chrom(Out_Pos) = [];
        if In_Pos ~= len
            Search_Chrom = [Search_Chrom(1:In_Pos),Temp,Search_Chrom(In_Pos+1:end)];
        else
            Search_Chrom = [Search_Chrom(1:end),Temp];
        end
        Flag = 1;
        if j == 1
            Flag = Judge(Search_Chrom,Chrom_Length,Target_Demand,Cap);
            if Flag
                Times_Count = Times_Count + 1;
                continue;
            end
        end
        Search_Chrom = [Search_Chrom,RuleArray(j,:)];
        [~, Objective_Search] = Calculate_Objective(Search_Chrom,Function_Number,Cap,X);
        if Objective_Search(1) < After_Chrom((j-1)*(m/8)+Rule_Ind,end-1) && Objective_Search(2) < After_Chrom((j-1)*(m/8)+Rule_Ind,end)
            After_Chrom((j-1)*(m/8)+Rule_Ind,:) = [Search_Chrom,Objective_Search];
            Combination_Chrom = [Combination_Chrom;After_Chrom((j-1)*(m/8)+Rule_Ind,:)];
%             Temp_Obj = Objective_Search;
%             Combin_Chrom(j,:) = [Search_Chrom,Temp_Obj];
            break;
        else
            Search_Chrom = Search_Chrom(1:end-3);
            Times_Count = Times_Count + 1;
        end
    end
end

% for k = 1:n
%     ind = 1;
%     Flag_Domin = 0;
%     Obj_Search = Combin_Chrom(k,end-Function_Number+1:end);
%     while ind <= size(EP,1)
%         Obj_Par = EP(:,end-Function_Number+1:end);
%         less = 0;
%         equal = 0;
%         greater = 0;
%         for col = 1:Function_Number
%             if Obj_Search(col) < Obj_Par(ind,col)
%                 less = less + 1;
%             elseif Obj_Search(col) == Obj_Par(ind,col)
%                 equal = equal + 1;
%             else
%                 greater = greater + 1;
%             end
%         end
%         if (greater == Function_Number)||(greater + equal == Function_Number)||(equal == Function_Number)
%             Flag_Domin = 0;
%             break;
%         elseif (less == Function_Number)||(less + equal == Function_Number)
%             EP(ind,:) = [];
%             Flag_Domin = 1;
%             continue;
%         elseif greater + less == Function_Number
%             Flag_Domin = 1;
%             ind = ind + 1;
%         end
%     end
%     if Flag_Domin
%         EP = [EP; Combin_Chrom(k,:)];
%     end
% end