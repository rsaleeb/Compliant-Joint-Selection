function [ Theta,K ] = RotationallySymmetricLeafHingeFun(E,d,Ro,F )
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% d = Thickness of flexure at smallest point
d=d/5;
%%mm
% Ro = Outer radius of circle
Ro=Ro/2;
% Ri = Inner radius of circle
Ri=Ro-Ro/5;
% F = Applied force

%%----Solution of Joint----%%
theta=75;%Simplification - deflection of 
%thin member when force is applied
thetar=theta*pi()/180;
epsilon=d/Ro;
gamma=Ri/Ro;

%Stiffness
K=E*d/(2*thetar^3)*(epsilon/gamma)^2*(1-gamma^2);
%Linear Displacement
Disp=F/K;
%Angular Displacement
Theta=asin(Disp/Ro)*180/pi();
%Rotational Stiffness
K=(F*Ro)/Theta;

end


