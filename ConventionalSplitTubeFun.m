function [Disptheta,K] = ConventionalSplitTubeFun(G,t,L,R,F)
% G = Shear Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% t = Thickness of tube
t=t/5;
%%mm
% R = Outer radius of tube
R=R/2;
% L = Tube length
% F = Applied force

%%----Solution of Joint----%%
%Stiffness
K=(2*pi()*G*R*t^3)/(3*L);
%Angular Displacement
Disptheta=(F*R)/K*180/pi();
%Linear Displacement
Disp=sind(Disptheta)*R;
%Rotational Stiffness
K=(F*R)/Disptheta;

end
