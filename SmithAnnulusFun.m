function [ Disp,K ] = SmithAnnulusFun( E,G,r1,t,F )
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% t = Thickness of central disk
t=t/5;
%%mm
% r1 = Radius of outer circle
% r2 = Radius of inner circle
r1=r1/2;
r2=r1-(r1*.2);
% F = Applied force

%%----Solution of Joint----%%
M=F*r1;
b=r1-r2;

J=(b*t^3)/3;

I=pi()/4*(r1^4-r2^4);

lamda=E*I/(G*J);
fm1=((pi()+4)+lamda*(8-pi()));
fm2=((2*pi()^2-4*pi()-4)+lamda*(8*pi()^2-18*pi()-16)+lamda^2*(6*pi()^2-14*pi()-12));
fm=fm1/fm2;
%Stiffness
K=((16*E*I)/r1)*fm;
%Angular displacement
Disp=M/K *180/pi();
%Transform stiffness to Nm/deg
K=K*pi()/180;

end