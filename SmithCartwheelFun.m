function [thetadeg,K] = SmithCartwheelFun(E,t,R,b,F)
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% t = Thickness of flexure beams
t=t/5;
%%mm
% R = Radius of circle
R=R/2;
% b = Depth of flexure
% F = Applied force

%%----Solution of Joint----%%
I=(b*t^3)/12;

%Stiffness
K=4*E*I/R;
M=F*(R);
theta=M/K;
%Angular Displacement
thetadeg=theta*180/pi();
%Linear Displacement
Disp=sin(theta)*(2*R);
%Transform stiffness to Nm/deg
K=K*pi()/180;

end