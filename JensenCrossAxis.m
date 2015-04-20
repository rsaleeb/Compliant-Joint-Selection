E = 73000; %N/mm^2 (73.1 GPa)
%Young's Modulus

%%----Joint Dimensional Characteristics----%%
%Total length of gap
r = 10; %mm
%Length of cross spring
l = 14.142136; %mm
%Height of joint
w = 10; %mm
%Thickness of Leaf Spring
t = 0.707107; %mm
%Lever arm
L = 0.1; %mm
%Depth of joint
D = 10; %mm
%Force Applied
F = 1; %N
%Number of springs
nSprings=1;

%%----Solution of Joint----%%
n=r/w;
KTheta=5.300185-1.6866*n+0.885356*n^2-0.2094*n^3+0.018385*n^4;
I=(1/12)*D*t^3;
%Stiffness
K=(KTheta*E*I)/(2*l);
Torque=F*L;
%Angular Displacement
Disp=Torque/(K*nSprings);
%Linear Displacement
Disp=sin(Theta)*(L+r);