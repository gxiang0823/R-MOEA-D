function Neighbor_Vector = Find_Neighbor(Lamda,Neighbor_Number)
N = size(Lamda,1);
Neighbor_Vector = zeros(N,Neighbor_Number);
distance = zeros(N,N);
for i = 1:N
    for j = 1:N
        L = Lamda(i,:) - Lamda(j,:);
        distance(i,j) = sqrt(L*L');
    end
end
for k = 1:N
    [~,index] = sort(distance(k,:));
    Neighbor_Vector(k,:) = index(1:Neighbor_Number);
end