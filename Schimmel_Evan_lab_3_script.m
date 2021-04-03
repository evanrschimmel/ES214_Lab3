clear all
close all
clc

Loa=100;
Link(1)=Loa;
Lab=240;
Link(2)=Lab;
Lbd=165;
Link(3)=Lbd;
Lod=190;
Link(4)=Lod;

if sum(Link) >= 2*(min(Link)+max(Link))
    fprintf('System is Grashof\n');
    ThetaOAmax=360;
    ThetaOAmin=0;
elseif sum(Link) < 2*(min(Link)+max(Link))
    fprintf('System is Non-Grashof\n');
    ThetaOAmax=acos(((Loa^2)+(Lod^2)-((Lab-Lbd)^2))/(2*Loa*Lod));
    ThetaOAmin=-ThetaOAmax;
end