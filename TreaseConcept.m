E = 2000000000;
G = 741000000;
L = 0.04;
t = 0.0008;
w = 0.01;
F = 0.1;
T = 0.02;


  Q=(w^2*t^2)/(3*w+1.8*t);
  Tmax=T/Q;
  KTheta=(w/t-0.373)*(4*G*t^4)/(3*L);
  MaxTheta=(Tmax*Q)/KTheta;
  Degrees=MaxTheta*360/(2*3.14);