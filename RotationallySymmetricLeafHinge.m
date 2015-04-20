function [ Disp,K ] = RotationallySymmetricLeafHingeFun( E,t,r,w,l,F )

%Rotationally Symmetric Leaf Hinge

E=73000;
d=1;
Ri=4;
Ro=5;
theta=75;
F=1;

epsilon=d/Ro;
gamma=Ri/Ro;

thetad=theta*pi()/180;



k=E*d/(2*thetad^3)*(epsilon/gamma)^2*(1-gamma^2);

Disp=F/k
end


