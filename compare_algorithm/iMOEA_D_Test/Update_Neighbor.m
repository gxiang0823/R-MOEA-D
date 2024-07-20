function After_Chrom = Update_Neighbor(Lamda,z,After_Chrom,Neighbor_Vector,Child_1,Child_2,Function_Number,Cap,X,Chrom_Length)
Get_Off_1 = inf;
Get_Off_2 = inf;
Target_Demand = X(2:end,4);
for i = 1:length(Neighbor_Vector)
    Get_Par = Tchebycheff_Approach(Lamda,z,After_Chrom(Neighbor_Vector(i),end-1:end),Neighbor_Vector(i));
    if isequal(After_Chrom(Neighbor_Vector(i),end-4:end-2),Child_1(end-4:end-2))
        Get_Off_1 = Tchebycheff_Approach(Lamda,z,Child_1(end-Function_Number+1:end),Neighbor_Vector(i));
    else
        Child_1(end-4:end-2) = After_Chrom(Neighbor_Vector(i),end-4:end-2);
        if Child_1(end-4) == Child_1(end-3) == Child_1(end-2) == 0
            flag_1 = Judge(Child_1(1:end-Function_Number),Chrom_Length,Target_Demand,Cap);
            if ~flag_1
                [~, Obj_Off_1] = Calculate_Objective(Child_1(1:end-Function_Number),Function_Number,Cap,X);
                Child_1(end-Function_Number+1:end) = Obj_Off_1;
                Get_Off_1 = Tchebycheff_Approach(Lamda,z,Child_1(end-Function_Number+1:end),Neighbor_Vector(i));
            end
        else
            [~, Obj_Off_1] = Calculate_Objective(Child_1(1:end-Function_Number),Function_Number,Cap,X);
            Child_1(end-Function_Number+1:end) = Obj_Off_1;
            Get_Off_1 = Tchebycheff_Approach(Lamda,z,Child_1(end-Function_Number+1:end),Neighbor_Vector(i));
        end
    end
    if isequal(After_Chrom(Neighbor_Vector(i),end-4:end-2),Child_2(end-4:end-2))
        Get_Off_2 = Tchebycheff_Approach(Lamda,z,Child_2(end-Function_Number+1:end),Neighbor_Vector(i));
    else
        Child_2(end-4:end-2) = After_Chrom(Neighbor_Vector(i),end-4:end-2);
        if Child_2(end-4) == Child_2(end-3) == Child_2(end-2) == 0
            flag_2 = Judge(Child_2(1:end-Function_Number),Chrom_Length,Target_Demand,Cap);
            if ~flag_2
                [~, Obj_Off_2] = Calculate_Objective(Child_2(1:end-Function_Number),Function_Number,Cap,X);
                Child_2(end-Function_Number+1:end) = Obj_Off_2;
                Get_Off_2 = Tchebycheff_Approach(Lamda,z,Child_2(end-Function_Number+1:end),Neighbor_Vector(i));
            end
        else
            [~, Obj_Off_2] = Calculate_Objective(Child_2(1:end-Function_Number),Function_Number,Cap,X);
            Child_2(end-Function_Number+1:end) = Obj_Off_2;
            Get_Off_2 = Tchebycheff_Approach(Lamda,z,Child_2(end-Function_Number+1:end),Neighbor_Vector(i));
        end
    end
    if min([Get_Off_1,Get_Off_2,Get_Par]) == Get_Off_1
        After_Chrom(Neighbor_Vector(i),:) = Child_1;
    elseif min([Get_Off_1,Get_Off_2,Get_Par]) == Get_Off_2
        After_Chrom(Neighbor_Vector(i),:) = Child_2;
    end
end
        