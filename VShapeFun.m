function [alpha,K] = VShapeFun(E,t,h,l,R,b,F)
% E = Young's Modulus 
%N/mm^2 
%%----Joint Dimensional Characteristics----
% t = Thickness of flexure at smallest point
t=t/5;
%%mm
% R = Circles at middle of flexure
%This ensures radius is not larger than half of height of flexure
R=(R/2-t/2)/2;
% l = Half length of flexure
%Since l is half length, 
l=l/2;
% h = Total height of flexure
%theta = Slope of flexure sides
theta = 20;%maintained
theta=theta*2*pi()/360;
% c = Height of sloped portion 
%This logic ensures flexure has solution
if h==b
    %min def
    c=h/2-t;
else
    c=0.1;
end
% F = Force applied

%%----Solution of Joint----%%
B=t/(2*R);
y=t/(2*c);
M=F*(l);
%Compliance 
C=(3/(2*E*b*R^2))*((1/(2*B+B^2))*(((1+B)*sin(theta)/(1+B-cos(theta))^2)...
        +((3+2*B+B^2)*sin(theta)/((2*B+B^2)*(1+B-cos(theta))))...
        +(6*(1+B)/((2*B+B^2)^(3/2))*atan(sqrt((2+B)/B)*tan(theta/2))))...
        -y^2*cot(theta)/(B^2*(1+y)^2)...
        +cot(theta)/(1+B-cos(theta))^2);

%Alternative compliance, for force applied rather than moment
% C=(3*y+3*(B-y)*cos(theta))/(2*E*b*R*y*sin(theta))*...
%     ((1/(2*B+B^2))*(((1+B)*sin(theta))/((1+B-cos(theta))^2)...
%     +((3+2*B+B^2)*sin(theta))/((2*B+B^2)*(1+B-cos(theta)))...
%     +(6*(1+B))/((2*B+B^2)^(3/2))*atan(sqrt((2+B)/B)*tan(theta/2)))...
%     -(y^2*cot(theta))/(B^2*(1+y)^2)...
%     +cot(theta)/(1+B-cos(theta))^2);
%Stiffness
K=1/C;

%Angular Displacement
alpha=M*C*180/pi();
%Linear Displacement
Disp=sin(alpha)*(l);
%Transform stiffness to Nm/deg
K=K*pi()/180;

end