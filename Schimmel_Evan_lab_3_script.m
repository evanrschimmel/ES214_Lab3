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
Lac=140;
phi=34;

if sum(Link) >= 2*(min(Link)+max(Link))
    fprintf('System is Grashof\n');
    ThetaOAmax=360;
    ThetaOAmin=0;
elseif sum(Link) < 2*(min(Link)+max(Link))
    fprintf('System is Non-Grashof\n');
    ThetaOAmax=acos(((Loa^2)+(Lod^2)-((Lab-Lbd)^2))/(2*Loa*Lod));
    ThetaOAmin=-ThetaOAmax;
end

i=0;
for angle=ThetaOAmin:1:ThetaOAmax
    i=i+1;
    Lad=sqrt((Loa^2)+(Lod^2)-(2*Loa*Lod*cosd(angle)));
    alpha=asin((Loa/Lad)*sind(angle));
    beta=acos(((Lab^2)+(Lbd^2)-(Lad^2))/(2*Lab*Lbd));
    gamma=asin((Lbd/Lad)*sind(beta));
    epsilon=180-beta-gamma;
    ThetaBD=180-alpha-epsilon;
    ThetaAB=ThetaBD-beta;
    Xa(i)=Loa*cosd(angle);
    Ya(i)=Loa*sind(angle);
    Xb(i)=Lod+Lbd*cosd(ThetaBD);
    Yb(i)=Lod+Lbd*sind(ThetaBD);
    Xc(i)=Loa*cosd(angle)+Lac*cosd(phi+ThetaAB);
    Yc(i)=Loa*sind(angle)+Lac*sind(phi+ThetaAB);
end

%axis equal
%plot(Xa,Ya,Xb,Yb,Xc,Yc);

animate_four_bar(Xa,Ya,Xb,Yb,Xc,Yc,Lod);