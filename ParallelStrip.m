%Metadata goes here
%Translational
%ParallelStrip
%Paper Name:
%Description: Simplest translational joint - two leaf springs in parallel,
            %The bottom is fixed, and the top platform moves linearly
%Notes: Works best when l>>h

E = 73000; %N/mm^2 (73.1 GPa)
%Young's Modulus

%%----Joint Dimensional Characteristics----%%
%Length of leaf springs
l=60;%mm
%Depth of leaf springs
w=5;%mm
%Thickness of leaf springs
h=.25;%mm
%Force applied
F=159; %N

%%----Solution of Joint----%%
I=h*w^3/12;
%In plane deflection
Dispx=sqrt((5*F^2*l^6)/(3*(240*(E*I)^2)));
%Out of plane deflection
Dispy=F^2*l^5/(240*(E*I)^2);

%dell2=3*15^2/(5*60);

%del2 = 2.25, with l=60 and i = 15
