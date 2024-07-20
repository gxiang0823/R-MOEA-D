function Save_Table = Calculate_MileageSavings(Init_Path,Dist_Table,Target_Demand)
N = size(Init_Path,1);
Save_Table = [];
for i =1:N
    Receive_Position = Init_Path{i};
    Receive_Length = size(Receive_Position,2);
    for j = 1:N
        Insert_Position = Init_Path{j};
        Insert_Length = size(Insert_Position,2);
        if (i ~= j) && (Insert_Length == 1)&&(~isempty(Receive_Position))
            for k = 1:Receive_Length+1
                if k == 1
                    AfterMerge_Path = [Insert_Position,Receive_Position];
                elseif k == Receive_Length+1
                    AfterMerge_Path = [Receive_Position,Insert_Position];
                else
                    AfterMerge_Path = [Receive_Position(1:k-1),Insert_Position,Receive_Position(k:end)];
                end
                Save_Energy = Calculate_PathEnergy(Receive_Position, Insert_Position, Dist_Table, Target_Demand, AfterMerge_Path);
                Save_Table = [Save_Table;Save_Energy,i,j,k];
            end
        end
    end
end
if ~isempty(Save_Table)
    [~,sort_index] = sort(Save_Table(:,1),'descend');
    Save_Table = Save_Table(sort_index,:);
end