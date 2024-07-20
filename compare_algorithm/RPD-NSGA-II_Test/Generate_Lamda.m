function Lamda = Generate_Lamda(NIND,Function_Number)
Lamda = zeros(NIND,Function_Number);
Lamda(1,:) = [0, 1];
for i = 1:NIND-1
    Lamda(i+1,1) = i/(NIND-1);
    Lamda(i+1,2) = 1 - Lamda(i+1,1);
end