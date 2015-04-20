function [ Disp,K ] = SmithRectilinearSpringFun( E,t,b,L,F )
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----%%
% w = thickness of leaf springs
%mm
% d = Depth of joint
% L = Height of leaf springs
% D  = Distance between leaf springs
% F = Force Applied

%%----Solution of Joint----%%
t=t/5;
%Stiffness
K=2*E*b*(t/L)^3;
%In plane displacement
Disp=F/K;
end

