%Metadata goes here
%Translational
%XuTranslational
%Paper Name: Design of Compliant Straight-line Mechanisms Using Flexural Joints

E = 73000; %N/mm^2 (73.1 GPa)
%Young's Modulus

%%----Joint Dimensional Characteristics----%%
%Height- origin to fixed points
H = 20;
%Height - Origin to top of bottom platform
hf= 8.75;
%Angle (from vertical) to each fixed point
phi = 30;
%Thickness of leaf springs
t=0.5;
%Depth of platform?
dc=7.5;

% Hp=26.89; %Equation 10

%%----Solution of Joint----%%
n=H/(H-hf);

gamma =15*n^2/(2-3*n+18*n^2);

Hp=(n-gamma)/(gamma*cosd(phi)^2)*H;

theta = (H*dc)/(E*t*(3*n-1)*n*cosd(phi));

dx=Hp*theta;

%Maximum deflection in x direction
dmax=Hp*sin(theta);
%Parasitic deflection in y direction
dely=H*(n-gamma)/(2*gamma*cos(phi)^2)*theta^2-...
    (H*(gamma-n)*(3*gamma*n-3*n^2+(7*gamma^2-18*gamma*n+12*n^2)*cos(phi)^2)/...
    (24*gamma^3*cos(phi)^4))*theta^4;



% del =(1-(1-gamma/n)*cosd(theta))*B1*H;

% del=(H*(n-gamma))/(2*gamma*cosd(phi)^2)*theta^2-...
%     (H*(gamma-n)*(3*gamma*n-3*n^2+(7*gamma^2-18*gamma*n+12*n^2)*cosd(phi)^2))*theta^4/...
%     (24*gamma^3*cosd(phi)^4);

