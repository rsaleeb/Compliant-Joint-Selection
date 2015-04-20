function [Disp,K] = SmithTwoAxisFun(E,R,t,F)
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% t = Thickness of flexure at smallest point
t=t/5;
%%mm
% R = Radius of circles
R=R/2;
% F = Applied force

%%----Solution of Joint----%%
%Stiffness
K=(E*t^(7/2))/(20*R^(3/2));
%Angular Displacement for a force applied at the end
Disp=F/K*180/pi();
%Linear Displacement
% Disp=sin(Disptheta)*(R);
%Angular Stiffness
K=F*R/Disp;

end