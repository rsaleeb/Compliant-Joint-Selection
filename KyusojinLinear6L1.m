%Metadata goes here
%Translational
%KyusojinLinear6L1
%Paper Name: Development of Linear and Rotary Movement Mechanisms by Using Leaf Springs

E = 73e9; %N/mm^2 (73.1 GPa)
%Young's Modulus

%%----Joint Dimensional Characteristics----%%
%Length of leaf spring
l=.050; %mm
%Thickness of leaf spring
t=0.001;%mm
%Width of leaf spring (1 on each side of center)
w=.050;
%Number of spring-pairs
N=2;
%Force Applied
F=1;
%Note - the size of the center platform (that moves) does not matter

%%----Solution of Joint----%%
I=t*w^3/12;

a=sqrt(N/(E*I));
dely=(F^2*l^5)/(60*(E*I)^2)*(1/(cos(a*l))-1);
%Out of plane deflection

Disp=sqrt((5*F^2*l^6)/(3*(60*(E*I)^2)))
%In plane deflection (linear translation)
