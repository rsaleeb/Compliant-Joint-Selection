function [ Disp,K ] = SmithNotchHingeFun( E,R,t,b,L,F )
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----%%
% R = Radius of circular notches
%mm
% t = Thickness between circular notches
% b = Depth of Flexures
% L = Length between circular notches
% F = Force Applied

%%----Solution of Joint----%%
R=R/2;
t=t/5;
Lstar=L+2*R;
%Stiffness calculation
K=(8*E*b*t^(5/2))/(9*pi()*R^.5*Lstar^2);
%Deflection
Disp=F/K;

end