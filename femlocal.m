% Zur Berechnung von 1D-FEM Problemen mit Linearen Basisfunktionen mit
% lokalen Ansatzfunktionen:

% Hier lösen wir -u"+u = 1 mit u(0) = 0 und u(3) = 0.

a = 0;          % Linke Seite
b = 1;          % Rechte Seite
n = 3;          % Anzahl der Stützstellen
nloc = 2;       % Anzahl der lokalen Stützstellen
h = (b-a)/(n-1);% Berechnung der äquidistanten Höhe
g = @(x) -1;     % Funktion rechte Seite
u0 = 0;
un = 0;

% Vektor der Elemente;
elements = a:(b-a)/(n-1):b;

% Aufbau der Assemblierungsmatrix:
B = zeros(n-1,nloc);

for i = 1 : n-1
   for j = 1 : nloc
       B(i,j) = i+j-1;
   end
end

% Aufbau der lokalen linearen Ansatzfunktionen auf [0,1]:
lin(1) = LinearSplineBasisFunction(0,0,1);
lin(2) = LinearSplineBasisFunction(0,1,1);
linref = LinearRefBasisFunction;

% Aufbau der lokalen Steifigkeitsmatrix:
K = zeros(2,2);

for i = 1 : 2
    for j = 1 : 2
        K(i,j) = quadgk(@(x) lin(i).GetDerivation(x).*lin(j).GetDerivation(x),0,1);
    end
end

Kloc = 1/h*K;      % lokale Steifigkeitsmatrix für äquidistante Stellen

% Aufbau der lokalen Massematrix:
M = zeros(2,2);

for i = 1 : 2
    for j = 1 : 2
        M(i,j) = quadgk(@(x) lin(i).GetValue(x).*lin(j).GetValue(x),0,1);
    end
end

Mloc = 1/h*M;      % lokale Steifigkeitsmatrix für äquidistante Stellen

% Aufbau des lokalen Vektors auf der rechten Seite des LGS:
f = zeros(2,1);

for i = 1 : 2
    f(i) = -quadgk(@(x) g(x).*lin(i).GetValue(x),0,1);
end

floc = h*f;        % lokaler Ergebnisvektor für äquidistante Stellen

% Assemblierung von lokalen Matrix K:
[K,M,f] = assembling(Kloc,Mloc,floc,B);

% Aufstellen von A und f:
A = [M,K;K,zeros(n)];
f = [zeros(n,1);f];

% Dirichletrandbedingungen:
[A,f] = dirichletBoundary(A,f,[u0,un],[n+1,2*n]);

A;
f;

x = a:0.1:b;
y = A\f;

p = y(1:n);
u = y(n+1:2*n);

% Berechnung des quadratischen Funktionen zu zeichnenden Vektors:
Phi = evalBasisValue(linref,B,elements,x);

y_elem = -1/24.*elements.^4 + 1/12 .* elements.^3  - 1/24 .* elements.^2;

max(abs(u-y_elem'))

x_exakt = a:0.05:b;
y_exakt = -1/24.*x_exakt.^4 + 1/12 .* x_exakt.^3  - 1/24 .* x_exakt.^2;
%C = [exp(a),exp(-a);exp(b),exp(-b)];
%c = C\[u0-1;un-1];

plot(x,Phi*u,x_exakt,y_exakt);
%plot(elements,u,x_exakt,y_exakt);
legend('Näherungslösung','exakte Lösung');
