function [RESP] = analyze(DVAR)
H=DVAR(1);
W=DVAR(2);
D=DVAR(3);

A=2*(H*W+H*D+W*D);
V=H*W*D;

RESP(1)=A;
RESP(2)=V;