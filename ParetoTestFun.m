%%Pareto Test function
clear
clc
close all

E=28000;
G=28000;
s1=0.5;
s2=10;
F=1;
Disp=[0];
k=[0];


scount=(s2-s1)/10;
s1c=s1;
s2c=s2;
b=1;
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=LobontiuSymmetricNotchFun(E,s1c,i,s2c,F)
            b=b+1;
            j=j-scount;
        end
%         subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Lobontiu Symmetric Notch')
%         num=num+1;
        
% for j=Fstart:Fcount:Fend
%     for i=s1:scount:s2
%         [Disp(a),k(a)]=SmithRectilinearSpringFun(E,s1c,i,s2c,j);%max disp
%         %[Disp(i),k(i)]=SmithRectilinearSpringFun(E,s1,s2,s2,F);%min disp
%         F(a)=j;
%         a=a+1;    
%     end
% %     plot(Disp,k)
% %     hold on
% %     a=1;
% end
% Z=[Disp' F' k'];
% % plot(Disp,k)
% figure(1)
% surf(Z);shading('interp');
% figure(2)
% tri=delaunay(Disp',k');
% trisurf(tri,Disp',k',F');
% figure(3)
% xlabel('Displacement (mm)')
% ylabel('Spring Constant (N/mm^2)')
% title('Pareto Curve for F Applied Force')   
   