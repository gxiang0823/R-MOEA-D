function Path_Load = Calculate_PathLoad(Route,Target_Demand)
m = length(Route);
Path_Load = 0;
for i = 1:m
    Path_Load = Path_Load + Target_Demand(Route(i));
end