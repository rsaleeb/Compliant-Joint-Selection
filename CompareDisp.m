clear
clc
close all


%%%%--------------------------------------------------------------%%%%%
%%MATERIAL ALUMINUM, FORCE APPLIED 10 N

E=73000;
s1=1;
s2=10;
F=10;
%Desired Range of motion
rom=.1;


%n=# of joints in function
n=6;
Disp=zeros(n,3);
for i=1:n
    Disp(i,3)=i;
end


%Find the minimum and maximum displacement for each joint - leave thickness
%constant, vary the depth of the joint from each iteration

Disp(1,1)=SmithRectilinearSpringFun(E,s1,s1,s2,F);
Disp(1,2)=SmithRectilinearSpringFun(E,s1,s2,s2,F);

Disp(2,1)=ParallelStripFun(E,s1,s1,s2,F);
Disp(2,2)=ParallelStripFun(E,s1,s2,s2,F);

Disp(3,1)=KyusojinLinear6L1Fun( E,s1,s1*4,s2,F );
Disp(3,2)=KyusojinLinear6L1Fun( E,s1,s2,s2,F );

Disp(4,1)=TreaseTranslationalFun( E,s1,s1,s2,F );
Disp(4,2)=TreaseTranslationalFun( E,s1,s2,s2,F );

Disp(5,1)=XuTranslationalFun( E,s1,s1,s1,s2,F );
Disp(5,2)=XuTranslationalFun( E,s1,s2,s1,s2,F );

Disp(6,1)=SmithNotchHingeFun( E,s1,s1,s1,s2,F );
Disp(6,2)=SmithNotchHingeFun( E,s1,s1,s2,s2,F );

plot([0,7],[ rom rom], 'k-')
hold on
scatter(Disp(:,3),Disp(:,2),'o');
hold on
scatter(Disp(:,3),Disp(:,1),'o');
hold on


Check=zeros(n,1);

for i=1:n
    Check(i)=CheckRangeFun(Disp(i,2),Disp(i,1),rom);
end

line([Disp(1,3),Disp(1,3)],[Disp(1,1),Disp(1,2)],'LineStyle','--','Color','b')
line([Disp(2,3),Disp(2,3)],[Disp(2,1),Disp(2,2)],'LineStyle','--','Color','b')
line([Disp(3,3),Disp(3,3)],[Disp(3,1),Disp(3,2)],'LineStyle','--','Color','b')
line([Disp(4,3),Disp(4,3)],[Disp(4,1),Disp(4,2)],'LineStyle','--','Color','b')
line([Disp(5,3),Disp(5,3)],[Disp(5,1),Disp(5,2)],'LineStyle','--','Color','b')
line([Disp(6,3),Disp(6,3)],[Disp(6,1),Disp(6,2)],'LineStyle','--','Color','b')



%%%--------------------------------------------------------------%%%%%
%MATERIAL ALUMINUM, FORCE APPLIED 20 N
E=73000;
s1=1;
s2=10;
F=20;

Disp=zeros(6,3);
for i=1:1:6
    Disp(i,3)=i;
end


%Find the minimum and maximum displacement for each joint - leave thickness
%constant, vary the depth of the joint from each iteration

Disp(1,1)=SmithRectilinearSpringFun(E,s1,s1,s2,F);
Disp(1,2)=SmithRectilinearSpringFun(E,s1,s2,s2,F);

Disp(2,1)=ParallelStripFun(E,s1,s1,s2,F);
Disp(2,2)=ParallelStripFun(E,s1,s2,s2,F);

Disp(3,1)=KyusojinLinear6L1Fun( E,s1,s1*4,s2,F );
Disp(3,2)=KyusojinLinear6L1Fun( E,s1,s2,s2,F );

Disp(4,1)=TreaseTranslationalFun( E,s1,s1,s2,F );
Disp(4,2)=TreaseTranslationalFun( E,s1,s2,s2,F );

Disp(5,1)=XuTranslationalFun( E,s1,s1,s1,s2,F );
Disp(5,2)=XuTranslationalFun( E,s1,s2,s1,s2,F );

Disp(6,1)=SmithNotchHingeFun( E,s1,s1,s1,s2,F );
Disp(6,2)=SmithNotchHingeFun( E,s1,s1,s2,s2,F );


scatter(Disp(:,3),Disp(:,2),'x');
hold on
scatter(Disp(:,3),Disp(:,1),'x');
hold on

% line([Disp(1,3),Disp(1,3)],[Disp(1,1),Disp(1,2)],'LineStyle','--','Color','g')

hold on

%%%%--------------------------------------------------------------%%%%%
%%MATERIAL ABS, FORCE APPLIED 10 N
E=2800;
s1=1;
s2=10;
F=10;

Disp=zeros(6,3);
for i=1:1:6
    Disp(i,3)=i;
end


%Find the minimum and maximum displacement for each joint - leave thickness
%constant, vary the depth of the joint from each iteration

Disp(1,1)=SmithRectilinearSpringFun(E,s1,s1,s2,F);
Disp(1,2)=SmithRectilinearSpringFun(E,s1,s2,s2,F);

Disp(2,1)=ParallelStripFun(E,s1,s1,s2,F);
Disp(2,2)=ParallelStripFun(E,s1,s2,s2,F);

Disp(3,1)=KyusojinLinear6L1Fun( E,s1,s1*4,s2,F );
Disp(3,2)=KyusojinLinear6L1Fun( E,s1,s2,s2,F );

Disp(4,1)=TreaseTranslationalFun( E,s1,s1,s2,F );
Disp(4,2)=TreaseTranslationalFun( E,s1,s2,s2,F );

Disp(5,1)=XuTranslationalFun( E,s1,s1,s1,s2,F );
Disp(5,2)=XuTranslationalFun( E,s1,s2,s1,s2,F );

Disp(6,1)=SmithNotchHingeFun( E,s1,s1,s1,s2,F );
Disp(6,2)=SmithNotchHingeFun( E,s1,s1,s2,s2,F );


scatter(Disp(:,3),Disp(:,2),'.');
hold on
scatter(Disp(:,3),Disp(:,1),'.');

xlabel('Joint number');
ylabel('Displacement (mm)');
axis([.5,6.5,0,.50])
title('Deflection range (mm)')
% line([Disp(1,3),Disp(1,3)],[Disp(1,1),Disp(1,2)],'LineStyle','--','Color','r')
% line([Disp(2,3),Disp(2,3)],[Disp(2,1),Disp(2,2)],'LineStyle','--','Color','r')
% line([Disp(3,3),Disp(3,3)],[Disp(3,1),Disp(3,2)],'LineStyle','--','Color','r')
% line([Disp(4,3),Disp(4,3)],[Disp(4,1),Disp(4,2)],'LineStyle','--','Color','r')
% line([Disp(5,3),Disp(5,3)],[Disp(5,1),Disp(5,2)],'LineStyle','--','Color','r')
% line([Disp(6,3),Disp(6,3)],[Disp(6,1),Disp(6,2)],'LineStyle','--','Color','r')
 legend('Desired ROM','Al 10N','Al 10N','Al 20N','Al 20N','ABS 10N','ABS 10N')
 

