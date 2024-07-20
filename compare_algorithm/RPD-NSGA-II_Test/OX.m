function [Child_1, Child_2] = OX(Chrom_1,Chrom_2,Chrom_Length,Cap,X)
Target_Demand = X(2:end,4);             %Target Point Demand
flag_1 = 1;
flag_2 = 1;
Parent_1 = Chrom_1(1:Chrom_Length);
Parent_2 = Chrom_2(1:Chrom_Length);

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
while flag_1||flag_2
    Rand = randperm(length(Parent_1));
    P1 = min(Rand(1),Rand(2));
    P2 = max(Rand(1),Rand(2));
    Fragment_1 = Parent_1(P1:P2);
    Fragment_2 = Parent_2(P1:P2);
    len = length(Fragment_1);
    for i = 1:len
        Parent_2(find(Parent_2 == Fragment_1(i))) = [];
        Parent_1(find(Parent_1 == Fragment_2(i))) = [];
    end
    Child_1 = [Parent_2(1:P1-1), Fragment_1, Parent_2(P1:end)];
    Child_2 = [Parent_1(1:P1-1), Fragment_2, Parent_1(P1:end)];

    for i = 1:length(location_1)
        Child_1 = [Child_1(1:location_1(i)-1), 0, Child_1(location_1(i):end)];
    end

    for i = 1:length(location_2)
        Child_2 = [Child_2(1:location_2(i)-1), 0, Child_2(location_2(i):end)];
    end
        if (Chrom_1(Chrom_Length+1)==Chrom_1(Chrom_Length+2)==Chrom_1(Chrom_Length+3)==0)
        flag_1 = Judge(Child_1,Chrom_Length,Target_Demand,Cap);     %flag = 1  ---->  illegality    flag = 0  ---->  legal
    else
        flag_1 = 0;
    end
    if (Chrom_2(Chrom_Length+1)==Chrom_2(Chrom_Length+2)==Chrom_2(Chrom_Length+3)==0)
        flag_2 = Judge(Child_2,Chrom_Length,Target_Demand,Cap);     %flag = 1  ---->  illegality    flag = 0  ---->  legal
    else
        flag_2 = 0;
    end
end
Child_1 = [Child_1, Chrom_1(Chrom_Length+1:Chrom_Length+3)];
Child_2 = [Child_2, Chrom_2(Chrom_Length+1:Chrom_Length+3)];
