%Metadata goes here
%Translational
%TreaseTranslational
%Paper Name: Design of Large-Displacement Compliant Joints
%Description: Multi-part rectilinear spring
            
E = 73000; %N/mm^2 (73.1 GPa)
%Young's Modulus
sigmay=414;

%%----Joint Dimensional Characteristics----%%
%Length of leaf springs
LB = 30;
%Thickness of leaf springs
t = 1;
%Depth of leaf springs
w = 10;
%Force applied
F=1;


%%----Solution of Joint----%%
%Note: Planar is 2 sets of 6 beams, spatial is double that
%K for planar (2 sides)
kaxialp = 3*(E*t^3*w)/(LB^3);
%K for spatial (4 sides)
kaxials = 6*(E*t^3*w)/(LB^3);

Disp= F/kaxialp;

%Max range of motion
%Single beam
xb = (1/3)*LB^2*sigmay/(t*E);
%Seies of beams
xt = (2/3)*LB^2*sigmay/(t*E);

%Max force that can be applied
Fmaxs=12*w*t^2/(3*L)*sigmay;
Fmaxp=6*w*t^2/(3*L)*sigmay;




