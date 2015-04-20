P=1;
l=57; %Length of leaf spring
E=73000;
t=0.5;
w=25;
N=2;
r= 50;
%Note - the size of the center platform (that moves) does not matter

I=t*w^3/12;

a=sqrt(N/(E*I));
dell=(P^2*l^5)/(60*(E*I)^2)*(1/(cos(a*l))-1);
%Out of plane deflection

i=sqrt((5*P^2*l^6)/(3*(60*(E*I)^2)));
%In plane deflection (linear translation)

phi=atand(i/r)