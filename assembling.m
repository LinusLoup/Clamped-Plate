function [A1,A2,f] = assembling(Aloc1,Aloc2,floc,B)
% B ist die Assemblierungsmatrix aus der die globale Matrix berechnet wird,
% Aloc ist dabei die lokale Matrix fürs Lösen des LGS und nloc ist die
% Anzahl der lokalen Freiheitsgrade, sowie nglob die
% Anzahl der globalen (also die Stützstellen).

[m,n] = size(B);
nloc = n;
nglob = m+1;

A1 = zeros(nglob,nglob);
A2= zeros(nglob,nglob);
f = zeros(nglob,1);
C = zeros(nglob,nloc);

for i = 1 : m
    for j = 1 : n
        C(B(i,j),j) = 1;
    end
    
    A1 = A1 + C*Aloc1*transpose(C);
    A2 = A2 + C*Aloc2*transpose(C);
    f = f + C*floc;
    C = zeros(nglob,nloc);
end

end