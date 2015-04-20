E = 73000; %N/mm^2 (73.1 GPa)
%Young's Modulus

%%----Joint Dimensional Characteristics----%%
%Length between flexures edges
L=9.2; %mm
%Depth of joint
b=1; %mm
%Radius of flexures
R=0.4; %mm
%Thickness between flexures
t=0.2;
%Force Applied
F=1;

%%----Solution of Joint----%%
%Distance from centerpoint of flexures
Lstar=L+2*R;
%Stiffness
K=(8*E*b*t^(5/2))/(9*pi()*R^.5*Lstar^2);
%Linear Displacement
Disp=F/K;