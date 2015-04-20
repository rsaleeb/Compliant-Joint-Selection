E = 73000;
t = 0.1; %Distance between circles
w = 10;%Depth of Flexure
r = 3.5;%Radius of circles
F = 0.1;%Force applied
 
  C = (3/(4*E*w*(2*r+t)))*(2*(2+3.14)*r+3.14*t+(8*r^3*(44*r^2+28*r*t+5*t^2))/(t^2*(4*r+t)^2)+((2*r+t)*(t*(4*r+t))^0.5*(-80*r^4+24*r^3*t+8*(3+2*3.14)*r^2*t^2+4*(1+2*3.14)*r*t^3+3.14*t^4))/(t^5*(4*r+t)^5)^0.5-(8*(2*r+t)^4*(-6*r^2+4*r*t+t^2))/(t^5*(4*r+t)^5)^0.5*atan((1+(4*r)/t)^0.5));
  Disp = C*F