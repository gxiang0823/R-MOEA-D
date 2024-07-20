function [Chrom,F] = NonDominated_Sort(Chrom)
Num_chrom = numel(Chrom);
% 初始化支配集和被支配个数
 for i = 1 : Num_chrom
     % 支配解集
     Chrom(i).domination = [];
     % 被支配次数?
     Chrom(i).dominated = 0;  
 end
F{1} = []; 
for i = 1 : Num_chrom
    p = Chrom(i);
    for j = i+1 : Num_chrom 
        q = Chrom(j);
        if dominate(p, q)
            p.domination = [p.domination j];
            q.dominated = q.dominated + 1;
        elseif dominate(q, p)
            q.domination = [q.domination i];
            p.dominated = p.dominated + 1;
        end 
        Chrom(i) = p;
        Chrom(j) = q;
    end
    if Chrom(i).dominated == 0
        Chrom(i).rank = 1;
        F{1} = [F{1} i];
    end
end
k = 1;
while true
    Q = [];
    for i = F{k}
        p = Chrom(i);
        for j = p.domination
            q = Chrom(j);
            q.dominated = q.dominated - 1;
            if q.dominated == 0 
                Q = [Q j];
                q.rank = k + 1;
            end
            Chrom(j) = q;
        end
    end
    if isempty(Q)
        break
    else
        F{k+1} = Q;
        k = k + 1;
    end
end
