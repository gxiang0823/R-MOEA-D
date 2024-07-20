function After_Chrom = Distinguish(Chrom,Objective_Value,Chrom_Length,NIND,Rule_Number)
A_Chorm1 = zeros(NIND/Rule_Number,Chrom_Length+5);
A_Chorm2 = zeros(NIND/Rule_Number,Chrom_Length+5);
A_Chorm3 = zeros(NIND/Rule_Number,Chrom_Length+5);
A_Chorm4 = zeros(NIND/Rule_Number,Chrom_Length+5);
A_Chorm5 = zeros(NIND/Rule_Number,Chrom_Length+5);
A_Chorm6 = zeros(NIND/Rule_Number,Chrom_Length+5);
A_Chorm7 = zeros(NIND/Rule_Number,Chrom_Length+5);
A_Chorm8 = zeros(NIND/Rule_Number,Chrom_Length+5);
A1 = 1;
A2 = 1;
A3 = 1;
A4 = 1;
A5 = 1;
A6 = 1;
A7 = 1;
A8 = 1;
for i = 1:NIND
    if Chrom(i,end-2)==0&&Chrom(i,end-1)==0&&Chrom(i,end)==0
        A_Chorm1(A1,:) = [Chrom(i,:),Objective_Value(i,:)];
        A1 = A1 + 1;
    elseif Chrom(i,end-2)==0&&Chrom(i,end-1)==0&&Chrom(i,end)==1
        A_Chorm2(A2,:) = [Chrom(i,:),Objective_Value(i,:)];
        A2 = A2 + 1;
    elseif Chrom(i,end-2)==0&&Chrom(i,end-1)==1&&Chrom(i,end)==0
        A_Chorm3(A3,:) = [Chrom(i,:),Objective_Value(i,:)];
        A3 = A3 + 1;
    elseif Chrom(i,end-2)==0&&Chrom(i,end-1)==1&&Chrom(i,end)==1
        A_Chorm4(A4,:) = [Chrom(i,:),Objective_Value(i,:)];
        A4 = A4 + 1;
    elseif Chrom(i,end-2)==1&&Chrom(i,end-1)==0&&Chrom(i,end)==0
        A_Chorm5(A5,:) = [Chrom(i,:),Objective_Value(i,:)];
        A5 = A5 + 1;
    elseif Chrom(i,end-2)==1&&Chrom(i,end-1)==0&&Chrom(i,end)==1
        A_Chorm6(A6,:) = [Chrom(i,:),Objective_Value(i,:)];
        A6 = A6 + 1;
    elseif Chrom(i,end-2)==1&&Chrom(i,end-1)==1&&Chrom(i,end)==0
        A_Chorm7(A7,:) = [Chrom(i,:),Objective_Value(i,:)];
        A7 = A7 + 1;
    else
        A_Chorm8(A8,:) = [Chrom(i,:),Objective_Value(i,:)];
        A8 = A8 + 1;
    end
end
After_Chrom = [A_Chorm1;A_Chorm2;A_Chorm3;A_Chorm4;A_Chorm5;A_Chorm6;A_Chorm7;A_Chorm8];