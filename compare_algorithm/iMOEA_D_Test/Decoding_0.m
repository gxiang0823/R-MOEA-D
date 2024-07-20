function Chrom_Decoded = Decoding_0(Route,Cusnum_Number,Target_Demand)
Temp_Path = cell(Cusnum_Number,1);
Temp_Load = cell(Cusnum_Number,1);
Vehicle_Count = 1;
Location = find(Route == 0);
for i = 1:length(Location)
    if i == 1
        Path = Route(1:Location(i));
        Path(Path==Route(Location(i))) = [];
    else
        Path = Route(Location(i-1):Location(i));
        Path(Path==Route(Location(i-1))) = [];
        Path(Path==Route(Location(i))) = [];
    end
    Load = zeros(1,length(Path));
    for j = 1:length(Path)
        Load(j) = Target_Demand(Path(j));
    end
    Temp_Path{Vehicle_Count} = Path;
    Temp_Load{Vehicle_Count} = Load;
    Vehicle_Count = Vehicle_Count+1;
end
Path = Route(Location(end):end);
Path(Path==Route(Location(end)))=[];
Load = zeros(1,length(Path));
for j = 1:length(Path)
    Load(j) = Target_Demand(Path(j));
end
Temp_Path{Vehicle_Count} = Path;
Temp_Load{Vehicle_Count} = Load;
Temp_Path(cellfun(@isempty,Temp_Path))=[];
Temp_Load(cellfun(@isempty,Temp_Load))=[];
%Delete empty elements
Len = size(Temp_Path,1);
Chrom_Decoded = cell(Len,2);
for k = 1:Len
    Chrom_Decoded{k,1} = Temp_Path{k};
    Chrom_Decoded{k,2} = Temp_Load{k};
end