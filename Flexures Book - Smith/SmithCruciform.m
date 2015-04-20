G=28000;
L=10;
d=2;
t=1;
F=1;


M=F*(t/2+d);

K=(d/t-0.373)*2*G*t^4/(3*L);

theta=M/K;

dispdegs=sin(theta)*(t/2+d)
