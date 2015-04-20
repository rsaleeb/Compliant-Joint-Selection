function [dellR,K] = KyusojinRotational2RFun(E,l,w,hf,H,P)


% P=1;Force applied
% l=57;Length of springs
% E=73000;

% t=0.5;%thickness of springs
% w=50;%width of springs

t=w/10;

r0=2*w;
b=w/2;
R=r0+b;

thetad=2.5;
theta=thetad*2*pi()/180;

dellR=((3*theta^2)/(5*l))*((2*r0*R)-(1/3*(3*r0^2-b^2)));

end