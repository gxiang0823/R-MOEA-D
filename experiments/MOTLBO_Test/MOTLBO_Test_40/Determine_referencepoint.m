function r = Determine_referencepoint(Lamda,Chrom)
n = size(Lamda,1);
Dis = zeros(n,1);
for i = 1:n
    Dis(i) = ((Chrom(1) - Lamda(i,1))^2 + (Chrom(2) - Lamda(i,2))^2)^0.5;
end
[~, r] = min(Dis);