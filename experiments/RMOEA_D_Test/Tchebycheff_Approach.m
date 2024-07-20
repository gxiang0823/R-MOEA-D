function Get_Fs = Tchebycheff_Approach(Lamda,z,Obj_Fun,Neighbor_Vector)
%Tchebycheff_Approach
for i = 1:length(Lamda(Neighbor_Vector,:))
    if(Lamda(Neighbor_Vector,i) == 0)
        Lamda(Neighbor_Vector,i) = 0.00001;
    end
end
Get_Fs = max(Lamda(Neighbor_Vector,:).*abs(Obj_Fun - z));