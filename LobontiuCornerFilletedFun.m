function [ Disp,K ] = LobontiuCornerFilletedFun( E,t,r,l,w,F )
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% r = Radius of filets
%%mm
% w = Depth of flexure
% l = Length of flexure
% t = Thickness of flexure
% F = Force applied

%%----Solution of Joint----%%
r=r/2;
t=t/5;
%Compliance
C=(3/(E*w))*(((4*(l-2*r)*(l^2-l*r+r^2))/(3*t^3))...
    +(sqrt(t*(4*r+t))*(-80*r^4+24*r^3*t+8*(3+2*pi())*r^2*t^2+4*(1+2*pi())*r*t^3+pi()*t^4))/(4*sqrt(t^5*(4*r+t)^5))...
    +((2*r+t)^3*(6*r^2-4*r*t-t^2)*atan(sqrt(1+4*r/t)))/sqrt(t^5*(4*r+t)^5)...
    +(-40*r^4+8*l*r^2*(2*r-t)+12*r^3*t+4*(3+2*pi())*r^2*t^2+2*(1+2*pi())*r*t^3+(pi()*t^4)/2)/(2*t^2*(4*r+t)^2)...
    +(4*l^2*r*(6*r^2+4*r*t+t^2))/(t^2*(2*r+t)*(4*r+t)^2)...
    -((2*r+t)*(-24*(l-r)^2*r^2-8*r^3*t+14*r^2*t^2+8*r*t^3+t^4)/(t^5*(4*r+t)^5)^0.5)*atan(1+4*r/t));
%Stiffness
K=1/C;
%Displacement
Disp=C*F;
%Angular Displacement
Disp = asin(Disp/l)*180/pi();
%Rotational Stiffness
K=(F*l/2)/Disp;

end