function [ dmax,K ] = XuTranslationalFun( E,t,dc,hf,H,F )
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----%%
% t = Thickness of leaf springs
%mm
% phi = Angle (from vertical) to each fixed point, 
%%set to simplify optimization
phi = 30;
% Hf = Point to force application
% H = Height to fixed points
% F = Force Applied

%%----Solution of Joint----%%
t=t/5;

n=H/(H-hf);
gamma =15*n^2/(2-3*n+18*n^2);
Hp=(n-gamma)/(gamma*cosd(phi)^2)*H;
theta = (H*dc)/(E*t*(3*n-1)*n*cosd(phi));
dx=Hp*theta;

%Deflection in x direction
dmax=Hp*sin(theta);
K=F/dmax;

end
