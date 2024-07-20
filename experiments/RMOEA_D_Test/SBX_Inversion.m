function [Child_1, Child_2] = SBX_Inversion(Chrom,Chrom_Length,Cap,Function_Number,X)
NP = size(Chrom,1);
%% SBX Crossover
Index = randperm(NP);
Parent_1 = Chrom(Index(1),1:Chrom_Length);
Parent_2 = Chrom(Index(2),1:Chrom_Length);

%Delete empty elements
location_1 = find(Parent_1 == 0);
Location_1 = flip(location_1);
len = length(Location_1);
for i = 1:len
    Parent_1(Location_1(i)) = [];
end
%Delete empty elements
location_2 = find(Parent_2 == 0);
Location_2 = flip(location_2);
len = length(Location_2);
for i = 1:len
    Parent_2(Location_2(i)) = [];
end
Exchange_Pos = 1;
while Exchange_Pos == 1
    Rand = randperm(length(Parent_1));
    Exchange_Pos = Rand(1);
end
Fragment_1 = Parent_1(Exchange_Pos:end);
Fragment_2 = Parent_2(Exchange_Pos:end);
Child_1 = [];
Left_1 = Parent_1(1:Exchange_Pos-1);
for i = 1:length(Left_1)
    Pos_1 = Left_1(i);
    if ismember(Pos_1,Fragment_2)
        Pos_1 = Fragment_1(find(Fragment_2 == Pos_1));
        while ismember(Pos_1,Fragment_2)
            Pos_1 = Fragment_1(find(Fragment_2 == Pos_1));
        end
        Temp1 = [Child_1, Pos_1];
        Child_1 = Temp1;
        continue;
    end
    Temp1 = [Child_1, Pos_1];
    Child_1 = Temp1;
end
Temp1 = [Child_1, Fragment_2];
Child_1 = Temp1;
for i = 1:length(location_1)
    Child_1 = [Child_1(1:location_1(i)-1), 0, Child_1(location_1(i):end)];
end
Child_2 = [];
Left_2 = Parent_2(1:Exchange_Pos-1);
for i = 1:length(Left_2)
    Pos_2 = Left_2(i);
    if ismember(Pos_2,Fragment_1)
        Pos_2 = Fragment_2(find(Fragment_1 == Pos_2));
        while ismember(Pos_2,Fragment_1)
            Pos_2 = Fragment_2(find(Fragment_1 == Pos_2));
        end
        Temp2 = [Child_2, Pos_2];
        Child_2 = Temp2;
        continue;
    end
    Temp2 = [Child_2, Pos_2];
    Child_2 = Temp2;
end
Temp2 = [Child_2, Fragment_1];
Child_2 = Temp2;
for i = 1:length(location_2)
    Child_2 = [Child_2(1:location_2(i)-1), 0, Child_2(location_2(i):end)];
end
%% Inversion Mutation
In_Index = randperm(length(Child_1));
Temp_1 = Child_1(In_Index(1):end);
Temp_1 = flip(Temp_1);
Child_1(In_Index(1):end) = Temp_1;
Temp_2 = Child_2(In_Index(1):end);
Temp_2 = flip(Temp_2);
Child_2(In_Index(1):end) = Temp_2;
Child_1 = [Child_1, Chrom(Index(1),Chrom_Length+1:Chrom_Length+3)];
Child_2 = [Child_2, Chrom(Index(2),Chrom_Length+1:Chrom_Length+3)];
[~, Obj_1] = Calculate_Objective(Child_1,Function_Number,Cap,X);
Child_1 = [Child_1, Obj_1];
[~, Obj_2] = Calculate_Objective(Child_2,Function_Number,Cap,X);
Child_2 = [Child_2, Obj_2];