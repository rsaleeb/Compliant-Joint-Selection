E=73000;
R=5;
t=.5;
b=1;
F=1;
I=(b*t^3)/12;

K=4*E*I/R;
M=F*(R);
theta=M/K;

Mmax=2*E*I/R*theta;

thetadeg=theta*180/pi();
Disp=sin(theta)*(R);