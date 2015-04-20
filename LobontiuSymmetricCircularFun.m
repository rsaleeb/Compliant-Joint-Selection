function [ Disp,K ] = LobontiuSymmetricCircularFun( E,t,r,w,F )
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% r = Radius of circles
r=r/2;
%%mm
% t = Distance between circles
t=t/5;
% w = Depth of Flexure
% F = Force applied

%%----Solution of Joint----%%
%Compliance
C = (3/(4*E*w*(2*r+t)))*...
    (2*(2+pi())*r+pi()*t+(8*r^3*(44*r^2+28*r*t+5*t^2))/(t^2*(4*r+t)^2)...
    +((2*r+t)*sqrt(t*(4*r+t))*(-80*r^4+24*r^3*t+8*(3+2*pi())*r^2*t^2+4*(1+2*pi())*r*t^3+pi()*t^4))/sqrt(t^5*(4*r+t)^5)...
    -((8*(2*r+t)^4*(-6*r^2+4*r*t+t^2))/sqrt(t^5*(4*r+t)^5))*atan((1+(4*r)/t)^0.5));
% C=24*r^2/(E*w*t^3*(2*r+t)*(4*r+t)^3)*...
%     (t*(4*r+t)*(6*r^2+4*r*t+t^2)...
%     +6*r*(2*r+t)^2*sqrt(t*(4*r+t))*atan(sqrt(1+4*r/t)));
%Stiffness
K=1/C;
%Linear Displacement
Disp = F/K;
%Angular Displacement
Disp = asin(Disp/(r))*180/pi();
%Rotational Stiffness
K=(F*r)/Disp;

end