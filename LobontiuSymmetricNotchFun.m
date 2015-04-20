function [Disp,K] = LobontiuSymmetricNotchFun(E,t,l,w,F)
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% t = Thickness of flexure
% w = Depth of flexure
% l = Length of flexure
% F = Force applied

%%----Solution of Joint----%%
t=t/5;

%Compliance
C = (4*l^3)/(E*w*t^3);
%Stiffness
K=1/C;
%Linear Displacement
Disp = F/K;
%Angular Displacement
Disp = asin(Disp/l)*180/pi();
%Rotational Stiffness
K=(F*l/2)/Disp;

end
