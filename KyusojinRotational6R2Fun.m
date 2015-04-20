function [phi,K] = KyusojinRotational6R2Fun(E,t,l,w,P)
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% t = Thickness of leaf spring
t=t/5;
%%mm
% l = Length of leaf spring
% w = width of leaf spring
% P = Applied force

N=4; %# of springs (constant for this geometry)
r= w*2; %radius of circle (center platform)
%Note - the size of the center platform 
% (that moves) does not matter

%%----Solution of Joint----%%
I=t*w^3/12;
a=sqrt(N/(E*I));
%Out of plane deflection
dell=(P^2*l^5)/(60*(E*I)^2)*(1/(cos(a*l))-1);
% i=sqrt((5*P^2*l^6)/(3*(60*(E*I)^2)));
%Linear displacement
i=sqrt((5*l^6)/(3*(60*(E*I)^2)));
%Stiffness
K=P/i;
%Angular Displacement
phi=asin(i/r)*180/pi();
%Rotational Stiffness
K=(P*r)/phi;

end