E = 73000;
h = 10;
c = 2;
theta = 20;
t = 2;
R = 3.2750;
l = 5.96;
F= 1;
b=5;
a=5;

Beta=t/(2*R);
Gamma=t/(2*c);

alpha = ((3*Gamma+3*(Beta-Gamma)*cosd(theta))/(2*E*b*R*Gamma*sind(theta)))*...
    ((1/(2*Beta+Beta^2))*((((1+Beta)*sind(theta))/(1+Beta-cosd(theta))^2)+...
    ((3+2*Beta+Beta^2)*sind(theta)/((2*Beta+Beta^2)*(1+Beta-cosd(theta))))+...
    (((6*(1+Beta))/(2*Beta+Beta^2)^(3/2))*atand(sqrt((2+Beta)/Beta)*tand(theta/2))))-...
    ((Gamma^2*cotd(theta))/(Beta^2*(1+Gamma)^2))+(cotd(theta)/(1+Beta-cosd(theta))^2))*(F*a);

Disp=sind(alpha)*(l*a*.5)
