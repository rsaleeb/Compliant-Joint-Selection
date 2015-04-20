function [Disptheta,KTheta] = TreaseConceptFun(G,t,L,w,F)
% G = Shear Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% t = Thickness of flexure at smallest point
t=t/5;
%%mm
% L = Length of cruciforms
L=L/2; %B/C equations are both sides
% w = Total width of cruciform
% F = Applied force

%%----Solution of Joint----%%
T=F*(w/2);
Q=(w^2*t^2)/(3*w+1.8*t);
Tmax=T/Q;
%Stiffness
KTheta=(w/t-0.373)*(4*G*t^4)/(3*L);
%Angular Displacement
Disptheta=T/KTheta*180/pi();
%Linear Displacement
Disp=sind(Disptheta)*(w/2);
%Transform stiffness to Nm/deg
KTheta=KTheta*pi()/180;

end