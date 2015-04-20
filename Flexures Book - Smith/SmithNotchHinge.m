%Metadata goes here
%Translational
%ParallelStrip
%Paper Name:
%Description: Simplest translational joint - two leaf springs in parallel,
            %The bottom is fixed, and the top platform moves linearly
%Notes: Works best when R and t are very small

E = 73000; %N/mm^2 (73.1 GPa)
%Young's Modulus

%%----Joint Dimensional Characteristics----%%
%Length between flexures
L=10;
%Depth of joint
b=1;

%Radius of flexures
R=.1;
%Thickness between flexures
t=.1;
%Force Applied
F=1;

%%----Solution of Joint----%%
%Distance from centerpoint of flexures
Lstar=L+2*R;
K=(8*E*b*t^(5/2))/(9*pi()*R^.5*Lstar^2);
Disp=F/K;