function z = Init_Z(Objective_Value,Function_Number)
z = zeros(2,Function_Number);
for i = 1:Function_Number
    z(1,i) = min(Objective_Value(:,i));
    z(2,i) = max(Objective_Value(:,i));
end