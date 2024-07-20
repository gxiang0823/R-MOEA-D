function Chrom = Cal_CrowdingDistance(Chrom,F)
Num_F = numel(F);
for i = 1 : Num_F
    costs = [Chrom(F{i}).cost];
    [nobj, n] = size(costs);
    d = zeros(n,nobj);
    for j = 1 : nobj
        [cj, so] = sort(costs(j,:));
        d(so(1), j) = inf;
        for k = 2 : n - 1
            d(so(k), j) = abs(cj(k+1) - cj(k-1))/abs(cj(1) - cj(end));
        end
        d(so(end), j) = inf;
    end
    for m = 1 : n
        Chrom(F{i}(m)).crowdingdistance = sum(d(m,:));
    end
end
