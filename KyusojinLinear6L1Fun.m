function [ Disp,K ] = KyusojinLinear6L1Fun( E,t,w,l,F )
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----%%
% w = Width of leaf springs
%mm
% t = Thickness of leaf springs
% l = Height of leaf springs
% F = Force Applied

%Number of spring-pairs
N=4;

%%----Solution of Joint----%%
t=t/5;
I=(t*w^3)/12;
a=sqrt(N/(E*I));

%Out of plane deflection
dely=(F^2*l^5)/(60*(E*I)^2)*(1/(cos(a*l))-1);

%In plane deflection (linear translation)
Disp=sqrt((5*F^2*l^6)/(3*(60*(E*I)^2)));

K=F/Disp;
end
