function [Child_1, Child_2] = SEX_Swap(Chrom,Chrom_Length,Cap,Function_Number,X)
NP = size(Chrom,1);
%% SEX Crossover
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

Rand = randperm(length(Parent_1));
P1 = min(Rand(1),Rand(2));
P2 = max(Rand(1),Rand(2));
Fragment_1 = Parent_1(P1:P2);
len = length(Fragment_1);
Pos_2 = zeros(1,len);
Fragment_2 = zeros(1,len);
for i = 1:len
    Pos_2(i) = find(Parent_2 == Fragment_1(i));
    Fragment_2(i) = Parent_2(Pos_2(i));
end
Child_1 = Parent_1;
Child_1(P1:P2) = Fragment_2;
Child_2 = Parent_2;
for i = 1:len
    Child_2(Pos_2(i)) = Fragment_1(i);
end

for i = 1:length(location_1)
    Child_1 = [Child_1(1:location_1(i)-1), 0, Child_1(location_1(i):end)];
end

for i = 1:length(location_2)
    Child_2 = [Child_2(1:location_2(i)-1), 0, Child_2(location_2(i):end)];
end

%% Swap Mutation
Sw_Index = randperm(length(Child_1));
Temp_1 = Child_1(Sw_Index(1));
Child_1(Sw_Index(1)) = Child_1(Sw_Index(2));
Child_1(Sw_Index(2)) = Temp_1;
Temp_2 = Child_2(Sw_Index(1));
Child_2(Sw_Index(1)) = Child_2(Sw_Index(2));
Child_2(Sw_Index(2)) = Temp_2;

Child_1 = [Child_1, Chrom(Index(1),Chrom_Length+1:Chrom_Length+3)];
Child_2 = [Child_2, Chrom(Index(2),Chrom_Length+1:Chrom_Length+3)];
[~, Obj_1] = Calculate_Objective(Child_1,Function_Number,Cap,X);
Child_1 = [Child_1, Obj_1];
[~, Obj_2] = Calculate_Objective(Child_2,Function_Number,Cap,X);
Child_2 = [Child_2, Obj_2];