%Metadata goes here
%Translational
%SmithRectilinearSpring
%Paper Name: Smith Flexures Book
%Description: Simplest translational joint - two leaf springs in parallel,
            %The bottom is fixed, and the top platform moves linearly
%Notes: Works best when l>>t
            
E = 73000; %N/mm^2 (73.1 GPa)
%Young's Modulus

%%----Joint Dimensional Characteristics----%%
%Length of leaf springs
L=60; %mm
%Depth of leaf springs
b=5; %mm
%Thickness of leaf springs
t=.25; %mm
%Force applied
F=1; %N

%%----Solution of Joint----%%
K=2*E*b*(t/L)^3;
%In plane deflection
Disp=F/K;