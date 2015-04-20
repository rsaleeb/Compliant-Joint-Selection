function [Disp,K] = JensenCrossAxisFun( E,t,w,r,D,F)
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----%%
% r = Total length of gap
%mm
% l = Length of cross spring
% w = Height of joint
% t = Thickness of Leaf Spring
% L = Lever arm
% D  = Depth of joint
% F = Force Applied

%%----Solution of Joint----%%
L=2; %
t=t/5;
D=D/2;
x = 1.404*t; %estimation, can be determined geometrically
l=sqrt((w-x)^2+r^2);
n=r/w;
KTheta=5.300185-1.6866*n+0.885356*n^2-0.2094*n^3+0.018385*n^4;
I=(1/12)*D*t^3;
%Stiffness
K=(KTheta*E*I)/(2*l);
M=F*(L+r/2);
%Angular Displacement
Theta=M/(K);
%Linear Displacement
Disp=sin(Theta)*(r/2+L);
%Transform stiffness to Nm/deg
K=K*pi()/180;

end