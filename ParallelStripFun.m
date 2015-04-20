function [ Dispx,K ] = ParallelStripFun( E,h,w,l,F )
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----%%
% w = thickness of leaf springs
%mm
% h = Depth of joint
% l = Height of leaf springs
% F = Force Applied

%%----Solution of Joint----%%
w=w/5;

I=h*w^3/12;
%In plane deflection
Dispx=sqrt((5*F^2*l^6)/(3*(240*(E*I)^2)));

K=F/Dispx;
%Only represents one spring, so
Dispx=Dispx/2;
K=K*2;

%Out of plane deflection
Dispy=F^2*l^5/(240*(E*I)^2);

end