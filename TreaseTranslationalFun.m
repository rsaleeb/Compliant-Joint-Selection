function [ Disp,kaxialp ] = TreaseTranslationalFun( E,t,w,LB,F )
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----%%
% w = Depth of leaf springs
%mm
% t = Thickness of leaf springs
% LB = Length of leaf springs
% F = Force Applied


%%----Solution of Joint----%%
t=t/5;
%Note: Planar is 2 sets of 6 beams, spatial is 4 sets of 6 beams
%%Only planar is used as a joint in the solution

%K for planar (2 sides)
kaxialp = 3*(E*t^3*w)/(LB^3);
%K for spatial (4 sides)
kaxials = 6*(E*t^3*w)/(LB^3);
%Displacement
Disp= F/kaxialp;

end
