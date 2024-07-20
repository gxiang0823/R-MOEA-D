function EP = Update_Ep(EP,Update_Chrom,Function_Number)
n = size(Update_Chrom,1);
for k = 1:n
    ind = 1;
    Flag_Domin = 0;
    Obj_Search = Update_Chrom(k,end-Function_Number+1:end);
    while ind <= size(EP,1)
        Obj_Par = EP(:,end-Function_Number+1:end);
        less = 0;
        equal = 0;
        greater = 0;
        for col = 1:Function_Number
            if Obj_Search(col) < Obj_Par(ind,col)
                less = less + 1;
            elseif Obj_Search(col) == Obj_Par(ind,col)
                equal = equal + 1;
            else
                greater = greater + 1;
            end
        end
        if (greater == Function_Number)||(greater + equal == Function_Number)||(equal == Function_Number)
            Flag_Domin = 0;
            break;
        elseif (less == Function_Number)||(less + equal == Function_Number)
            EP(ind,:) = [];
            Flag_Domin = 1;
            continue;
        elseif greater + less == Function_Number
            Flag_Domin = 1;
            ind = ind + 1;
        end
    end
    if Flag_Domin
        EP = [EP; Update_Chrom(k,:)];
    end
end