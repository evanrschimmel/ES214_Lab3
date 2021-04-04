clear all
close all
clc

Loa=50;
Link(1)=Loa;
Lab=75;
Link(2)=Lab;
Lbd=85;
Link(3)=Lbd;
Lod=115;
Link(4)=Lod;
Lac=85;
phi=30;

if sum(Link) >= 2*(min(Link)+max(Link))
    fprintf('System is Grashof\n');
    ThetaOAmax=360;
    ThetaOAmin=0;
elseif sum(Link) < 2*(min(Link)+max(Link))
    fprintf('System is Non-Grashof\n');
    ThetaOAmax=acosd(((Loa^2)+(Lod^2)-((Lab-Lbd)^2))/(2*Loa*Lod));
    ThetaOAmin=-ThetaOAmax;
end

i=0;
for angle=ThetaOAmin:1:ThetaOAmax
    i=i+1;
    Lad=sqrt((Loa^2)+(Lod^2)-(2*Loa*Lod*cosd(angle)));
    alpha=asind((Loa/Lad)*sind(angle));
    beta=acosd(((Lab^2)+(Lbd^2)-(Lad^2))/(2*Lab*Lbd));
    gamma=asind((Lbd/Lad)*sind(beta));
    epsilon=180-beta-gamma;
    ThetaBD=180-alpha-epsilon;
    ThetaAB=ThetaBD-beta;
    Xa(i)=Loa*cosd(angle);
    Ya(i)=Loa*sind(angle);
    Xb(i)=Lod+Lbd*cosd(ThetaBD);
    Yb(i)=Lbd*sind(ThetaBD);
    Xc(i)=Loa*cosd(angle)+Lac*cosd(phi+ThetaAB);
    Yc(i)=Loa*sind(angle)+Lac*sind(phi+ThetaAB);
end

plot(Xa,Ya,Xb,Yb,Xc,Yc);
axis equal
legend('Point A','Point B','Point C');
xlabel('X Position [mm]');
ylabel('Y Position [mm]');

animate_four_bar(Xa,Ya,Xb,Yb,Xc,Yc,Lod);