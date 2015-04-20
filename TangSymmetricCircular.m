E = 73000;
R = 3.5;%Radius of circles
b = 10;%Depth of Flexure
t = 0.1;%Distance between circles
F = 0.1;%Force applied
M= F*R;
K=(2*E*b*t^(5/2))/(9*pi()*R^.5);
AngularDisp = M/K

Disp=sin(AngularDisp)*R