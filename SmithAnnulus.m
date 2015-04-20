

E=73000;
r1=10;
r2=8;
G=28000;
t=0.25;
F=1;

M=F*r1;
b=r1-r2;

J=(b*t^3)/3;

I=pi()/4*(r1^4-r2^4);

lamda=E*I/(G*J);
fm1=((pi()+4)+lamda*(8-pi()))
fm2=((2*pi()^2-4*pi()-4)+lamda*(8*pi()^2-18*pi()-16)+lamda^2*(6*pi()^2-14*pi()-12))
fm=fm1/fm2
K=((16*E*I)/r1)*fm

theta=M/K