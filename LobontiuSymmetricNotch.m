E = 73000;
%Young's Modulus
t = 0.1;
%thickness of center beam
w = 1;
%Depth of flexure
l = 1;
%Length of beam
F = 1;
%Force applied

k = (4*l^3)/(E*w*t^3);
Disp = F*k;
V=t*w*l;