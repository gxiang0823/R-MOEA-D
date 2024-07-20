function Chrom_Decoded = Decoding_6(Route,Cusnum_Number,Target_Demand,Cap)
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
i = 1;
while i <= length(Route)
    Load_Sum = Load_Sum + Target_Demand(Route(i));
    if Load_Sum < Cap
        Temp_P = [Path, Route(i)];
        Path = Temp_P;
        Temp_L = [Load, Target_Demand(Route(i))];
        Load = Temp_L;
        i = i + 1;
    elseif Load_Sum == Cap
        Temp_P = [Path, Route(i)];
        Path = Temp_P;
        Temp_L = [Load, Target_Demand(Route(i))];
        Load = Temp_L;
        Temp_Path{Vehicle_Count} = Path;
        Temp_Load{Vehicle_Count} = Load;
        Vehicle_Count = Vehicle_Count+1;
        Load_Sum = 0;
        Path = [];
        Load = [];
        i = i + 1;
    else
        if Load_Sum - Target_Demand(Route(i)) <= 0.9 * Cap
            Temp_P = [Path, Route(i)];
            Path = Temp_P;
            Temp_L = [Load, Target_Demand(Route(i)) - (Load_Sum - Cap)];
            Load = Temp_L;
            Temp_Path{Vehicle_Count} = Path;
            Temp_Load{Vehicle_Count} = Load;
            Vehicle_Count = Vehicle_Count+1;
            Load_Sum = Load_Sum - Cap;
            Path = Route(i);
            Load = Load_Sum;
            i = i + 1;
        else
            Temp_Path{Vehicle_Count} = Path;
            Temp_Load{Vehicle_Count} = Load;
            Vehicle_Count = Vehicle_Count+1;
            Load_Sum = Target_Demand(Route(i));
            Path = Route(i);
            Load = Load_Sum;
            i = i + 1;
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