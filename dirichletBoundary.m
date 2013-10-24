function [AOutput,fOutput] = dirichletBoundary(AInput,fInput,Boundaries,points)
%NEUMANNBOUNDARY Summary of this function goes here
%   Detailed explanation goes here

    % Initialisierung der Ausgabe:
    [m,n] = size(AInput);
    fOutput = zeros(n,1);
    AOutput = zeros(m,n);

    % Bearbeitung der rechten Seite, so dass f0=u0 und fn=un, sowie die Rand-
    % bedingungen erfüllt werden.
    fInput(points) = Boundaries;
    
    fOutput = fInput;

    % Bearbeiten von der Matrix A, damit die erste Zeile und letzte der
    % Einheitsvektor sind.
    AInput(points,:) = zeros(length(points),n);
    AInput(:,points) = zeros(m,length(points));
    
    AOutput = AInput;
   
    for k = 1 : length(points)
        l = points(k);
        AOutput(l,l) = 1;
    end
end
