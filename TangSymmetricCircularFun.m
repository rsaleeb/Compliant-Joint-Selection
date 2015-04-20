function [Disp,K] = TangSymmetricCircularFun(E,R,t,b,F)
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% t = Thickness of flexure at smallest point
t=t/5;
%%mm
% R = Radius of circles
R=R/2;
% b = Depth of Flexure
% F = Force applied

%%----Solution of Joint----%%
M= F*R;
%Stiffness
K=(2*E*b*t^(5/2))/(9*pi()*R^.5);
%Angular Displacement
Disp = M/K*180/pi();
%Linear Displacement
% Disp=sind(Disp)*R;
%Transform stiffness to Nm/deg
K=K*pi()/180;

end
