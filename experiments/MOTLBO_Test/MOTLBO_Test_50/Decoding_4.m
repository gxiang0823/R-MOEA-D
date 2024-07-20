function Chrom_Decoded = Decoding_4(Route,Cusnum_Number,Target_Demand,Cap)
location = find(Route == 0);
Location = flip(location);
%Delete empty elements
len = length(Location);
for i = 1:len
    Route(Location(i)) = [];
end
Temp_Path = cell(Cusnum_Number,1);
Temp_Load = cell(Cusnum_Number,1);
Path = [];
Load = [];
Vehicle_Count = 1;
Load_Sum = 0;
for i = 1:length(Route)
    Load_Sum = Load_Sum + Target_Demand(Route(i));
    if Load_Sum < Cap
        Path = [Path, Route(i)];
        Load = [Load, Target_Demand(Route(i))];
    elseif Load_Sum == Cap
        Path = [Path, Route(i)];
        Load = [Load, Target_Demand(Route(i))];
        Temp_Path{Vehicle_Count} = Path;
        Temp_Load{Vehicle_Count} = Load;
        Vehicle_Count = Vehicle_Count+1;
        Load_Sum = 0;
        Path = [];
        Load = [];
    else
        if (Load_Sum - Cap) > (Target_Demand(Route(i))/2)
            Temp_Path{Vehicle_Count} = Path;
            Temp_Load{Vehicle_Count} = Load;
            Vehicle_Count = Vehicle_Count+1;
            Load_Sum = Target_Demand(Route(i));
            Path = Route(i);
            Load = Load_Sum;
        else
            Path = [Path, Route(i)];
            Load = [Load, Target_Demand(Route(i)) - (Load_Sum - Cap)];
            Temp_Path{Vehicle_Count} = Path;
            Temp_Load{Vehicle_Count} = Load;
            Vehicle_Count = Vehicle_Count+1;
            Load_Sum = Load_Sum - Cap;
            Path = Route(i);
            Load = Load_Sum;
        end
    end
end
Temp_Path{Vehicle_Count} = Path;
Temp_Load{Vehicle_Count} = Load;
Temp_Path(cellfun(@isempty,Temp_Path))=[];
Temp_Load(cellfun(@isempty,Temp_Load))=[];
%Delete empty elements
m = size(Temp_Path,1);
Chrom_Decoded = cell(m,2);
for k = 1:m
    Chrom_Decoded{k,1} = Temp_Path{k};
    Chrom_Decoded{k,2} = Temp_Load{k};
end