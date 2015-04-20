function [theta,K] = SmithCruciformFun(G,t,L,d,F)
% G = Shear Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% t = Thickness of cruciform
t=t/5;
%%mm
% l = length of cruciform
% d = height of cruciform arms
d=d/2-t/2;
% F = Applied force

%%----Solution of Joint----%%
M=F*(d);
%Stiffness
K=(d/t-0.373)*(2*G*t^4)/(3*L);
%Angular Displacement
theta=M/K*180/pi();
%Linear Displacement
Disp=sind(theta)*(d);
%Transform stiffness to Nm/deg
K=K*pi()/180;

end
