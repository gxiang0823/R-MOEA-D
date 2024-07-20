function flag = Judge(Chrom,Chrom_Length,Target_Demand,Cap)
flag = 1;
Route = Chrom(1:Chrom_Length);
loc = find(Route == 0);
for i = 1:length(loc)-1
    if i == 1 && loc(i) == 1
        Load = 0;
        rou = Route(loc(i)+1:loc(i+1)-1);
        if ~isempty(rou) && ~any(rou)
            for j = 1:length(rou)
                Load = Load + Target_Demand(rou(j));
            end
            if Load > Cap
                break;
            end
        end
    end
    if i == 1 && loc(i) ~= 1
        Load = 0;
        rou = Route(1:loc(1)-1);
        if ~isempty(rou) && ~any(rou)
            for j = 1:length(rou)
                Load = Load + Target_Demand(rou(j));
            end
            if Load > Cap
                break;
            end
        end
    else
        Load = 0;
        rou = Route(loc(i)+1:loc(i+1)-1);
        if ~isempty(rou) && ~any(rou)
            for j = 1:length(rou)
                Load = Load + Target_Demand(rou(j));
            end
            if Load > Cap
                break;
            end
        end
    end
    flag = 0;
end
rou = Route(loc(end-1)+1:loc(end)-1);
if ~isempty(rou) && ~any(rou)
    for j = 1:length(rou)
        Load = Load + Target_Demand(rou(j));
    end
    if Load > Cap
        flag = 1;
    end
end
