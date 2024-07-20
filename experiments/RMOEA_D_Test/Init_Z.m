function z = Init_Z(Objective_Value,Function_Number)
z = zeros(1,Function_Number);
for i = 1:Function_Number
    z(i) = min(Objective_Value(:,i));
end