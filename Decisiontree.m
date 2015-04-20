clear
clc
close all

%%---------------------------------------------------------------%%
%%ReadPropertiesCheat.m, temporary placeholder for simplicity

ty=1; %1 is translational, 0 is rotational

rom=1;
k=1;
s1=1;
s2=10;
%material
%Young's modulus
E=73100; %N/mm^2 (73.1 GPa)
%Density
p=2.78; %g/cc
%Shear Modulus
G=28000; %N/mm^2 (28 GPa)
F=1;
fos=1;
Fset=[.1,1,10]; %can be edited by user if desired
a=0;
%ty,rom,k,s1,s2,E,p,G,maxf,fos
%ty,rom,k,sizevalue1,sizevalue2,E,ro,G,maxload,fos
    
%%---------------------------------------------------------------%%

romc=isequal('na',rom);
kc=isequal('na',k);
fc=isequal('na',F);

%%---------------------------------------------------------------%%
%%Logic Tree%%
%%---------------------------------------------------------------%%

if ty==1
    fprintf('Translational Joints are selected\n')
    if romc==0
        fprintf('RoM has a value\n')
        if kc==0
            fprintf('K has a value\n')
            if fc==0
                fprintf('F has a value\n')
                %This tree - Y,Y,Y -> Search using Load as F applied,
                %find geometry that results in rom and k.
                %-----------------------------------------------------%
                %n=# of joints in function
                n=6;
                Disp=zeros(n,5);
                for i=1:n
                    Disp(i,5)=i;
                end

                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration

                [Disp(1,1),Disp(1,3)]=SmithRectilinearSpringFun(E,s1,s1,s2,F);%max disp
                [Disp(1,2),Disp(1,4)]=SmithRectilinearSpringFun(E,s1,s2,s2,F);%min disp

                [Disp(2,1),Disp(2,3)]=ParallelStripFun(E,s1,s1,s2,F);
                [Disp(2,2),Disp(2,4)]=ParallelStripFun(E,s2,s1,s2,F);

                [Disp(3,1),Disp(3,3)]=KyusojinLinear6L1Fun( E,s1,s1,s1,F );
                [Disp(3,2),Disp(3,4)]=KyusojinLinear6L1Fun( E,s1,s1,s2,F );

                [Disp(4,1),Disp(4,3)]=TreaseTranslationalFun( E,s1,s2,s2,F );
                [Disp(4,2),Disp(4,4)]=TreaseTranslationalFun( E,s1,s2,s1,F );

                [Disp(5,1),Disp(5,3)]=XuTranslationalFun( E,s1,s2,s1,s2,F );
                [Disp(5,2),Disp(5,4)]=XuTranslationalFun( E,s1,s1,s1,s2,F );

                [Disp(6,1),Disp(6,3)]=SmithNotchHingeFun( E,s2,s1,s2,s2,F );
                [Disp(6,2),Disp(6,4)]=SmithNotchHingeFun( E,s1,s1,s2,s1,F );

                Check=zeros(n,2);

                for i=1:n
                    Check(i,1)=CheckRangeFun(Disp(i,2),Disp(i,1),rom);%min max value
                    Check(i,2)=CheckRangeFun(Disp(i,3),Disp(i,4),k);
                end

                names=char('SmithRectilinear','ParallelStrip','KyusojinLinear6L1',...
                    'TreaseTranslational','XuTranslational','SmithNotchHinge');
                b=1;
                for i=1:n
                    if (Check(i,1)==0 || Check(i,2)==0)
                        a(b,1)=i;
                        b=b+1;
                    end
                end

                
                %------------------------------------------------------
                % Inverse of above for pareto curve production %
                d=1;               
                e=0;
                for i=1:n
                    if (Check(i,1)==1 && Check(i,2)==1)
                        e(d,1)=i;
                        d=d+1;
                    end
                end
                
                z = ParetoFunT_YYY( e,E,s1,s2,F);
                %--------------------
                
                sa=size(a);
                c=sa(1);
                for i=1:sa(1)
                    names(a(c),:)=[];
                    c=c-1;
                end
                fprintf('\nPossible joints for this user input are:\n')
                disp(names)
                %-----------------------------------------------------%
                %%END OF Y,Y,Y TREE
                %-----------------------------------------------------%

            else
                fprintf('F does not have a value (na)\n')
                %This tree - Y,Y,N -> Search using generic F set applied,
                %find geometry that results in rom and k.
                %-----------------------------------------------------%
                %n=# of joints in function
                n=6;
                Disp=zeros(n,5);
                for i=1:n
                    Disp(i,5)=i;
                end

                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration
                sizefset=size(Fset);
                nfset=sizefset(2);
                %This is a loop over the user defined forces, Fset (current 3
                %forces a factor of 10 apart, starting with .1)
                for j=1:nfset
                    F=Fset(j);
                    
                    [Disp(1,1),Disp(1,3)]=SmithRectilinearSpringFun(E,s1,s1,s2,F);%max disp
                    [Disp(1,2),Disp(1,4)]=SmithRectilinearSpringFun(E,s1,s2,s2,F);%min disp

                    [Disp(2,1),Disp(2,3)]=ParallelStripFun(E,s1,s1,s2,F);
                    [Disp(2,2),Disp(2,4)]=ParallelStripFun(E,s2,s1,s2,F);

                    [Disp(3,1),Disp(3,3)]=KyusojinLinear6L1Fun( E,s1,s1,s2,F );
                    [Disp(3,2),Disp(3,4)]=KyusojinLinear6L1Fun( E,s1,s2,s2,F );

                    [Disp(4,1),Disp(4,3)]=TreaseTranslationalFun( E,s1,s2,s2,F );
                    [Disp(4,2),Disp(4,4)]=TreaseTranslationalFun( E,s1,s2,s1,F );

                    [Disp(5,1),Disp(5,3)]=XuTranslationalFun( E,s1,s2,s1,s2,F );
                    [Disp(5,2),Disp(5,4)]=XuTranslationalFun( E,s1,s1,s1,s2,F );

                    [Disp(6,1),Disp(6,3)]=SmithNotchHingeFun( E,s2,s1,s2,s2,F );
                    [Disp(6,2),Disp(6,4)]=SmithNotchHingeFun( E,s1,s1,s2,s1,F );

                    Check=zeros(n,2);

                    for i=1:n
                        Check(i,1)=CheckRangeFun(Disp(i,2),Disp(i,1),rom);
                        Check(i,2)=CheckRangeFun(Disp(i,3),Disp(i,4),k);
                    end

                    names=char('SmithRectilinear','ParallelStrip','KyusojinLinear6L1',...
                        'TreaseTranslational','XuTranslational','SmithNotchHinge');
                    b=1;
                    for i=1:n
                        if (Check(i,1)==0 || Check(i,2)==0)
                            a(b,1)=i;
                            b=b+1;
                        end
                    end
                    
                    %------------------------------------------------------
                    % Inverse of above for pareto curve production %
                    d=1;               
                    e=0;
                    for i=1:n
                        if (Check(i,1)==1 && Check(i,2)==1)
                            e(d,1)=i;
                            d=d+1;
                        end
                    end

                    z = ParetoFunT_YYY( e,E,s1,s2,F);
                    %--------------------
                    sa=size(a);
                    c=sa(1);
                    for i=1:sa(1)
                        names(a(c),:)=[];
                        c=c-1;
                    end
                    fprintf('\nPossible joints for this user input using a force of %f are:\n',Fset(j))
                    disp(names)
                    a=0;
                end
                %-----------------------------------------------------%
                %%END OF Y,Y,N TREE
                %-----------------------------------------------------%
            end
        else
            fprintf('k does not have a value (na)\n')
            if fc==0
                fprintf('F has a value\n')
                %This tree - Y,N,Y -> Set F as load applied, check for 
                %any joints that can result in rom.
                %-----------------------------------------------------%
                %n=# of joints in function
                n=6;
                Disp=zeros(n,5);
                for i=1:n
                    Disp(i,5)=i;
                end

                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration

                [Disp(1,1),Disp(1,3)]=SmithRectilinearSpringFun(E,s1,s1,s2,F);%max disp
                [Disp(1,2),Disp(1,4)]=SmithRectilinearSpringFun(E,s1,s2,s2,F);%min disp

                [Disp(2,1),Disp(2,3)]=ParallelStripFun(E,s1,s1,s2,F);
                [Disp(2,2),Disp(2,4)]=ParallelStripFun(E,s2,s1,s2,F);

                [Disp(3,1),Disp(3,3)]=KyusojinLinear6L1Fun( E,s1,s1,s2,F );
                [Disp(3,2),Disp(3,4)]=KyusojinLinear6L1Fun( E,s1,s2,s2,F );

                [Disp(4,1),Disp(4,3)]=TreaseTranslationalFun( E,s1,s2,s2,F );
                [Disp(4,2),Disp(4,4)]=TreaseTranslationalFun( E,s1,s2,s1,F );

                [Disp(5,1),Disp(5,3)]=XuTranslationalFun( E,s1,s2,s1,s2,F );
                [Disp(5,2),Disp(5,4)]=XuTranslationalFun( E,s1,s1,s1,s2,F );

                [Disp(6,1),Disp(6,3)]=SmithNotchHingeFun( E,s2,s1,s2,s2,F );
                [Disp(6,2),Disp(6,4)]=SmithNotchHingeFun( E,s1,s1,s2,s1,F );
                
                Check=zeros(n,1);

                for i=1:n
                    Check(i)=CheckRangeFun(Disp(i,2),Disp(i,1),rom);
                end

                names=char('SmithRectilinear','ParallelStrip','KyusojinLinear6L1',...
                    'TreaseTranslational','XuTranslational','SmithNotchHinge');
                b=1;
                for i=1:n
                    if Check(i)==0
                        a(b,1)=i;
                        b=b+1;
                    end
                end
                
                %------------------------------------------------------
                % Inverse of above for pareto curve production %
                d=1;               
                e=0;
                for i=1:n
                    if Check(i,1)==1
                        e(d,1)=i;
                        d=d+1;
                    end
                end
                
                z = ParetoFunT_YYY( e,E,s1,s2,F);
                %--------------------
                sa=size(a);
                c=sa(1);
                for i=1:sa(1)
                    names(a(c),:)=[];
                    c=c-1;
                end
                fprintf('\nPossible joints for this user input are:\n')
                disp(names)
                %-----------------------------------------------------%
                %%END OF Y,N,Y TREE
                %-----------------------------------------------------%

            else
                fprintf('F does not have a value (na)\n')
                %This tree - Y,N,N -> Search using generic F set applied,
                %find joints that can result in rom.
                %-----------------------------------------------------%
                %n=# of joints in function
                n=6;
                Disp=zeros(n,5);
                for i=1:n
                    Disp(i,5)=i;
                end

                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration
                sizefset=size(Fset);
                nfset=sizefset(2);
                %This is a loop over the user defined forces, Fset (current 3
                %forces a factor of 10 apart, starting with .1)
                for j=1:nfset
                    F=Fset(j);
                    
                    [Disp(1,1),Disp(1,3)]=SmithRectilinearSpringFun(E,s1,s1,s2,F);%max disp
                    [Disp(1,2),Disp(1,4)]=SmithRectilinearSpringFun(E,s1,s2,s2,F);%min disp

                    [Disp(2,1),Disp(2,3)]=ParallelStripFun(E,s1,s1,s2,F);
                    [Disp(2,2),Disp(2,4)]=ParallelStripFun(E,s2,s1,s2,F);

                    [Disp(3,1),Disp(3,3)]=KyusojinLinear6L1Fun( E,s1,s1,s2,F );
                    [Disp(3,2),Disp(3,4)]=KyusojinLinear6L1Fun( E,s1,s2,s2,F );

                    [Disp(4,1),Disp(4,3)]=TreaseTranslationalFun( E,s1,s2,s2,F );
                    [Disp(4,2),Disp(4,4)]=TreaseTranslationalFun( E,s1,s2,s1,F );

                    [Disp(5,1),Disp(5,3)]=XuTranslationalFun( E,s1,s2,s1,s2,F );
                    [Disp(5,2),Disp(5,4)]=XuTranslationalFun( E,s1,s1,s1,s2,F );

                    [Disp(6,1),Disp(6,3)]=SmithNotchHingeFun( E,s2,s1,s2,s2,F );
                    [Disp(6,2),Disp(6,4)]=SmithNotchHingeFun( E,s1,s1,s2,s1,F );

                    Check=zeros(n,1);

                    for i=1:n
                        Check(i)=CheckRangeFun(Disp(i,2),Disp(i,1),rom);
                    end

                    names=char('SmithRectilinear','ParallelStrip','KyusojinLinear6L1',...
                        'TreaseTranslational','XuTranslational','SmithNotchHinge');
                    b=1;
                    for i=1:n
                        if Check(i)==0
                            a(b,1)=i;
                            b=b+1;
                        end
                    end
                    
                    %------------------------------------------------------
                    % Inverse of above for pareto curve production %
                    d=1;               
                    e=0;
                    for i=1:n
                        if Check(i,1)==1
                            e(d,1)=i;
                            d=d+1;
                        end
                    end

                    z = ParetoFunT_YYY( e,E,s1,s2,F);
                    %--------------------
                    sa=size(a);
                    c=sa(1);
                    for i=1:sa(1)
                        names(a(c),:)=[];
                        c=c-1;
                    end
                    fprintf('\nPossible joints for this user input using a force of %f are:\n',Fset(j))
                    disp(names)
                    a=0;

                end
                %-----------------------------------------------------%
                %%END OF Y,N,N TREE
                %-----------------------------------------------------%           
            end 
        end
    else
        fprintf('rom does not have a value (na)\n')
        if kc==0
            fprintf('k has a value\n')
            if fc==0
                fprintf('f has a value\n')
                %This tree - N,Y,Y -> Search using Load as F applied,
                %find geometry that results in k.
                %-----------------------------------------------------%
                %n=# of joints in function
                n=6;
                Disp=zeros(n,5);
                for i=1:n
                    Disp(i,5)=i;
                end

                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration

                [Disp(1,1),Disp(1,3)]=SmithRectilinearSpringFun(E,s1,s1,s2,F);%max disp
                [Disp(1,2),Disp(1,4)]=SmithRectilinearSpringFun(E,s1,s2,s2,F);%min disp

                [Disp(2,1),Disp(2,3)]=ParallelStripFun(E,s1,s1,s2,F);
                [Disp(2,2),Disp(2,4)]=ParallelStripFun(E,s2,s1,s2,F);

                [Disp(3,1),Disp(3,3)]=KyusojinLinear6L1Fun( E,s1,s1,s2,F );
                [Disp(3,2),Disp(3,4)]=KyusojinLinear6L1Fun( E,s1,s2,s2,F );

                [Disp(4,1),Disp(4,3)]=TreaseTranslationalFun( E,s1,s2,s2,F );
                [Disp(4,2),Disp(4,4)]=TreaseTranslationalFun( E,s1,s2,s1,F );

                [Disp(5,1),Disp(5,3)]=XuTranslationalFun( E,s1,s2,s1,s2,F );
                [Disp(5,2),Disp(5,4)]=XuTranslationalFun( E,s1,s1,s1,s2,F );

                [Disp(6,1),Disp(6,3)]=SmithNotchHingeFun( E,s2,s1,s2,s2,F );
                [Disp(6,2),Disp(6,4)]=SmithNotchHingeFun( E,s1,s1,s2,s1,F );
                
                Check=zeros(n,1);

                for i=1:n
                    Check(i)=CheckRangeFun(Disp(i,3),Disp(i,4),k);
                end

                names=char('SmithRectilinear','ParallelStrip','KyusojinLinear6L1',...
                    'TreaseTranslational','XuTranslational','SmithNotchHinge');
                b=1;
                for i=1:n
                    if Check(i)==0
                        a(b,1)=i;
                        b=b+1;
                    end
                end
                
                %------------------------------------------------------
                % Inverse of above for pareto curve production %
                d=1;               
                e=0;
                for i=1:n
                    if Check(i,1)==1
                        e(d,1)=i;
                        d=d+1;
                    end
                end
                
                z = ParetoFunT_YYY( e,E,s1,s2,F);
                %--------------------
                sa=size(a);
                c=sa(1);
                for i=1:sa(1)
                    names(a(c),:)=[];
                    c=c-1;
                end
                fprintf('\nPossible joints for this user input are:\n')
                disp(names)
                %-----------------------------------------------------%
                %%END OF N,Y,Y TREE
                %-----------------------------------------------------%
            else
                fprintf('f does not have a value (na)\n')
                %This tree - N,Y,N -> Search using generic F set applied,
                %find geometry that results in k.
                %-----------------------------------------------------%
                %n=# of joints in function
                n=6;
                Disp=zeros(n,5);
                for i=1:n
                    Disp(i,5)=i;
                end

                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration
                sizefset=size(Fset);
                nfset=sizefset(2);
                %This is a loop over the user defined forces, Fset (current 3
                %forces a factor of 10 apart, starting with .1)
                for j=1:nfset
                    F=Fset(j);
                    
                    [Disp(1,1),Disp(1,3)]=SmithRectilinearSpringFun(E,s1,s1,s2,F);%max disp
                    [Disp(1,2),Disp(1,4)]=SmithRectilinearSpringFun(E,s1,s2,s2,F);%min disp

                    [Disp(2,1),Disp(2,3)]=ParallelStripFun(E,s1,s1,s2,F);
                    [Disp(2,2),Disp(2,4)]=ParallelStripFun(E,s2,s1,s2,F);

                    [Disp(3,1),Disp(3,3)]=KyusojinLinear6L1Fun( E,s1,s1,s2,F );
                    [Disp(3,2),Disp(3,4)]=KyusojinLinear6L1Fun( E,s1,s2,s2,F );

                    [Disp(4,1),Disp(4,3)]=TreaseTranslationalFun( E,s1,s2,s2,F );
                    [Disp(4,2),Disp(4,4)]=TreaseTranslationalFun( E,s1,s2,s1,F );

                    [Disp(5,1),Disp(5,3)]=XuTranslationalFun( E,s1,s2,s1,s2,F );
                    [Disp(5,2),Disp(5,4)]=XuTranslationalFun( E,s1,s1,s1,s2,F );

                    [Disp(6,1),Disp(6,3)]=SmithNotchHingeFun( E,s2,s1,s2,s2,F );
                    [Disp(6,2),Disp(6,4)]=SmithNotchHingeFun( E,s1,s1,s2,s1,F );

                    Check=zeros(n,1);

                    for i=1:n
                        Check(i)=CheckRangeFun(Disp(i,3),Disp(i,4),k);
                    end

                    names=char('SmithRectilinear','ParallelStrip','KyusojinLinear6L1',...
                        'TreaseTranslational','XuTranslational','SmithNotchHinge');
                    b=1;
                    for i=1:n
                        if Check(i)==0
                            a(b,1)=i;
                            b=b+1;
                        end
                    end
                    
                	%------------------------------------------------------
                    % Inverse of above for pareto curve production %
                    d=1;               
                    e=0;
                    for i=1:n
                        if Check(i,1)==1
                            e(d,1)=i;
                            d=d+1;
                        end
                    end

                    z = ParetoFunT_YYY( e,E,s1,s2,F);
                    %--------------------
                    sa=size(a);
                    c=sa(1);
                    for i=1:sa(1)
                        names(a(c),:)=[];
                        c=c-1;
                    end
                    fprintf('\nPossible joints for this user input using a force of %f are:\n',Fset(j))
                    disp(names)
                    a=0;
                end
                %-----------------------------------------------------%
                %%END OF N,Y,N TREE
                %-----------------------------------------------------%          
            end
        else
            fprintf('k does not have a value (na)\n')
            if fc==0
                fprintf('f has a value\n')
                %This tree - N,N,Y -> Set F as load applied, present user
                %all joints, organize by rom.
                %-----------------------------------------------------%
                n=6;
                Disp=zeros(n,5);
                for i=1:n
                    Disp(i,5)=i;
                end
                
                [Disp(1,1),Disp(1,3)]=SmithRectilinearSpringFun(E,s1,s1,s2,F);%max disp
                [Disp(1,2),Disp(1,4)]=SmithRectilinearSpringFun(E,s1,s2,s2,F);%min disp

                [Disp(2,1),Disp(2,3)]=ParallelStripFun(E,s1,s1,s2,F);
                [Disp(2,2),Disp(2,4)]=ParallelStripFun(E,s2,s1,s2,F);

                [Disp(3,1),Disp(3,3)]=KyusojinLinear6L1Fun( E,s1,s1,s2,F );
                [Disp(3,2),Disp(3,4)]=KyusojinLinear6L1Fun( E,s1,s2,s2,F );

                [Disp(4,1),Disp(4,3)]=TreaseTranslationalFun( E,s1,s2,s2,F );
                [Disp(4,2),Disp(4,4)]=TreaseTranslationalFun( E,s1,s2,s1,F );

                [Disp(5,1),Disp(5,3)]=XuTranslationalFun( E,s1,s2,s1,s2,F );
                [Disp(5,2),Disp(5,4)]=XuTranslationalFun( E,s1,s1,s1,s2,F );

                [Disp(6,1),Disp(6,3)]=SmithNotchHingeFun( E,s2,s1,s2,s2,F );
                [Disp(6,2),Disp(6,4)]=SmithNotchHingeFun( E,s1,s1,s2,s1,F );
                
                Check=zeros(n,1);

                Disp=sortrows(Disp,2);
                fprintf('\nThe following joints are organized by RoM,\nLargest to smallest, for the given force, %f N :\n',F)
                namest=char('SmithRectilinear','ParallelStrip','KyusojinLinear6L1',...
                        'TreaseTranslational','XuTranslational','SmithNotchHinge');
                names=cellstr(namest);
                for i=n:-1:1
                    name=names{Disp(i,5)};
                    fprintf('%s with %2.4f mm displacement. \n',name,Disp(i,2))

                end
                
                %------------------------------------------------------
                % Inverse of above for pareto curve production %
                d=1;               
                e=0;
                for i=1:n
                    if Check(i,1)==1
                        e(d,1)=i;
                        d=d+1;
                    end
                end
                
                z = ParetoFunT_YYY( e,E,s1,s2,F);
                %--------------------
                %-----------------------------------------------------%
                %%END OF N,N,Y TREE
                %-----------------------------------------------------%
            else
                fprintf('f does not have a value (na)\n')
                %This tree - N,N,N -> Will result in all results being 
                %returned, cannot specify with no information
                %-----------------------------------------------------%
                n=6;
                Disp=zeros(n,5);
                for i=1:n
                    Disp(i,5)=i;
                end
                
                sizefset=size(Fset);
                nfset=sizefset(2);
                %This is a loop over the user defined forces, Fset (current 3
                %forces a factor of 10 apart, starting with .1)
                for j=1:nfset
                    F=Fset(j);
                    
                    [Disp(1,1),Disp(1,3)]=SmithRectilinearSpringFun(E,s1,s1,s2,F);%max disp
                    [Disp(1,2),Disp(1,4)]=SmithRectilinearSpringFun(E,s1,s2,s2,F);%min disp

                    [Disp(2,1),Disp(2,3)]=ParallelStripFun(E,s1,s1,s2,F);
                    [Disp(2,2),Disp(2,4)]=ParallelStripFun(E,s2,s1,s2,F);

                    [Disp(3,1),Disp(3,3)]=KyusojinLinear6L1Fun( E,s1,s1,s2,F );
                    [Disp(3,2),Disp(3,4)]=KyusojinLinear6L1Fun( E,s1,s2,s2,F );

                    [Disp(4,1),Disp(4,3)]=TreaseTranslationalFun( E,s1,s2,s2,F );
                    [Disp(4,2),Disp(4,4)]=TreaseTranslationalFun( E,s1,s2,s1,F );

                    [Disp(5,1),Disp(5,3)]=XuTranslationalFun( E,s1,s2,s1,s2,F );
                    [Disp(5,2),Disp(5,4)]=XuTranslationalFun( E,s1,s1,s1,s2,F );

                    [Disp(6,1),Disp(6,3)]=SmithNotchHingeFun( E,s2,s1,s2,s2,F );
                    [Disp(6,2),Disp(6,4)]=SmithNotchHingeFun( E,s1,s1,s2,s1,F );

                    Check=zeros(n,1);

                    Disp=sortrows(Disp,2);
                    namest=char('SmithRectilinear','ParallelStrip','KyusojinLinear6L1',...
                            'TreaseTranslational','XuTranslational','SmithNotchHinge');
                    names=cellstr(namest);
                    fprintf('\nPossible joints for this user input using a force of %f N,\n organized by RoM are:\n',Fset(j))
                    for i=n:-1:1
                        name=names{Disp(i,5)};
                        fprintf('%s with %2.4f mm displacement. \n',name,Disp(i,2))

                    end
                    a=0;
                end
                %-----------------------------------------------------%
                %%END OF N,N,N TREE
                %-----------------------------------------------------%
            end
        end
    end
else
    fprintf('Rotational Joints are selected.\n')

    %ty,rom,k,s1,s2,E,p,G,maxf,fos
    %ty,rom,k,sizevalue1,sizevalue2,E,ro,G,maxload,fos
    namest=char('SmithRectilinear','ParallelStrip','KyusojinLinear6L1',...
                'TreaseTranslational','XuTranslational','SmithNotchHinge');
    namesr=char('JensenCrossAxis','LobontiuCornerFilleted','LobontiuSymmetricCircular',...
                'LobontiuSymmetricNotch','RotationallySymmetric','SmithAnnulus','SmithCartwheel',...
                'SmithCruciform','SmithTwoAxis','TangSymmetricCircular','TreaseConcept',...
                'VShape','Kyusojin6R2','ConventionalSplitTube');
    %n=# of joints in function
    n=14;
    Disp=zeros(n,5);
    for i=1:n
        Disp(i,5)=i;
    end
    if romc==0
        fprintf('rom has a value\n')
        if kc==0
            fprintf('k has a value\n')
            if fc==0
                fprintf('F has a value\n')
                %This tree - Y,Y,Y -> Search using Load as F applied,
                %find geometry that results in rom and k.
                %-----------------------------------------------------%


                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration

                %Joint 1
                [Disp(1,1),Disp(1,3)] = JensenCrossAxisFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(1,2),Disp(1,4)] = JensenCrossAxisFun(E,s1,s2,s2,s2,F);%max disp
                %Joint 2
                [Disp(2,1),Disp(2,3)] = LobontiuCornerFilletedFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(2,2),Disp(2,4)] = LobontiuCornerFilletedFun(E,s2,s2,s2,s2,F);%max disp
                %Joint 3
                [Disp(3,1),Disp(3,3)] = LobontiuSymmetricCircularFun(E,s2,s1,s2,F);%maxK
                [Disp(3,2),Disp(3,4)] = LobontiuSymmetricCircularFun(E,s1,s2,s2,F);%max disp
                %Joint 4
                [Disp(4,1),Disp(4,3)] = LobontiuSymmetricNotchFun(E,s1,s1,s2,F);%maxK
                [Disp(4,2),Disp(4,4)] = LobontiuSymmetricNotchFun(E,s1,s2,s2,F);%max disp
                %Joint 5
                [Disp(5,1),Disp(5,3)] = RotationallySymmetricLeafHingeFun(E,s2,s1,F);%maxK
                [Disp(5,2),Disp(5,4)] = RotationallySymmetricLeafHingeFun(E,s1,s2,F);%max disp
                %Joint 6
                [Disp(6,1),Disp(6,3)] = SmithAnnulusFun(E,G,s2,s2,F);%maxK
                [Disp(6,2),Disp(6,4)] = SmithAnnulusFun(E,G,s1,s1,F);%max disp
                %Joint 7
                [Disp(7,1),Disp(7,3)] = SmithCartwheelFun(E,s1,s1,s2,F);%maxK
                [Disp(7,2),Disp(7,4)] = SmithCartwheelFun(E,s1,s2,s2,F);%max disp
                %Joint 8
                [Disp(8,1),Disp(8,3)] = SmithCruciformFun(G,s1,s1,s1,F);%maxK
                [Disp(8,2),Disp(8,4)] = SmithCruciformFun(G,s1,s2,s1,F);%max disp
                %Joint 9
                [Disp(9,1),Disp(9,3)] = SmithTwoAxisFun(E,s1,s1,F);%maxK
                [Disp(9,2),Disp(9,4)] = SmithTwoAxisFun(E,s2,s1,F);%max disp
                %Joint 10
                [Disp(10,1),Disp(10,3)] = TangSymmetricCircularFun(E,s1,s1,s2,F);%maxK
                [Disp(10,2),Disp(10,4)] = TangSymmetricCircularFun(E,s2,s1,s2,F);%max disp
                %Joint 11
                [Disp(11,1),Disp(11,3)] = TreaseConceptFun(G,s1,s1,s1,F);%maxK
                [Disp(11,2),Disp(11,4)] = TreaseConceptFun(G,s1,s2,s1,F);%max disp
                %Joint 12
                [Disp(12,1),Disp(12,3)] = VShapeFun(E,s1,s1,s1,s1,s2,F);%maxK
                [Disp(12,2),Disp(12,4)] = VShapeFun(E,s1,s2,s2,s2,s2,F);%max disp
                %Joint 13
                [Disp(13,1),Disp(13,3)] = KyusojinRotational6R2Fun(E,s1,s1,s2,F);%maxK
                [Disp(13,2),Disp(13,4)] = KyusojinRotational6R2Fun(E,s1,s2,s2,F);%max disp
                %Joint 14
                [Disp(14,1),Disp(14,3)] = ConventionalSplitTubeFun(G,s1,s1,s2,F);%maxK
                [Disp(14,2),Disp(14,4)] = ConventionalSplitTubeFun(G,s1,s2,s2,F);%max disp

                Check=zeros(n,2);

                for i=1:n
                    Check(i,1)=CheckRangeFun(Disp(i,1),Disp(i,2),rom);
                    Check(i,2)=CheckRangeFun(Disp(i,4),Disp(i,3),k);
                end

                b=1;
                for i=1:n
                    if (Check(i,1)==0 || Check(i,2)==0)
                        a(b,1)=i;
                        b=b+1;
                    end
                end
                
                %------------------------------------------------------
                % Inverse of above for pareto curve production %
                d=1;                
                e=0;
                for i=1:n
                    if (Check(i,1)==1 && Check(i,2)==1)
                        e(d,1)=i;
                        d=d+1;
                    end
                end
                
                z = ParetoFunR_YYY( e,E,G,s1,s2,F);
                %--------------------
                
                sa=size(a);
                c=sa(1);
                for i=1:sa(1)
                    namesr(a(c),:)=[];
                    c=c-1;
                end
                fprintf('\nPossible joints for this user input are:\n')
                disp(namesr)
                %-----------------------------------------------------%
                %%END OF Y,Y,Y TREE
                %-----------------------------------------------------%

            else
                fprintf('F does not have a value (na)\n')
                %This tree - Y,Y,N -> Search using generic F set applied,
                %find geometry that results in rom and k.
                %-----------------------------------------------------%

                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration
                sizefset=size(Fset);
                nfset=sizefset(2);
                %This is a loop over the user defined forces, Fset (current 3
                %forces a factor of 10 apart, starting with .1)
                for j=1:nfset
                    F=Fset(j);
                    %Joint 1
                    [Disp(1,1),Disp(1,3)] = JensenCrossAxisFun(E,s1,s1,s1,s2,F);%maxK
                    [Disp(1,2),Disp(1,4)] = JensenCrossAxisFun(E,s1,s2,s2,s2,F);%max disp
                    %Joint 2
                    [Disp(2,1),Disp(2,3)] = LobontiuCornerFilletedFun(E,s1,s1,s1,s2,F);%maxK
                    [Disp(2,2),Disp(2,4)] = LobontiuCornerFilletedFun(E,s2,s2,s2,s2,F);%max disp
                    %Joint 3
                    [Disp(3,1),Disp(3,3)] = LobontiuSymmetricCircularFun(E,s2,s1,s2,F);%maxK
                    [Disp(3,2),Disp(3,4)] = LobontiuSymmetricCircularFun(E,s1,s2,s2,F);%max disp
                    %Joint 4
                    [Disp(4,1),Disp(4,3)] = LobontiuSymmetricNotchFun(E,s1,s1,s2,F);%maxK
                    [Disp(4,2),Disp(4,4)] = LobontiuSymmetricNotchFun(E,s1,s2,s2,F);%max disp
                    %Joint 5
                    [Disp(5,1),Disp(5,3)] = RotationallySymmetricLeafHingeFun(E,s2,s1,F);%maxK
                    [Disp(5,2),Disp(5,4)] = RotationallySymmetricLeafHingeFun(E,s1,s2,F);%max disp
                    %Joint 6
                    [Disp(6,1),Disp(6,3)] = SmithAnnulusFun(E,G,s2,s2,F);%maxK
                    [Disp(6,2),Disp(6,4)] = SmithAnnulusFun(E,G,s1,s1,F);%max disp
                    %Joint 7
                    [Disp(7,1),Disp(7,3)] = SmithCartwheelFun(E,s1,s1,s2,F);%maxK
                    [Disp(7,2),Disp(7,4)] = SmithCartwheelFun(E,s1,s2,s2,F);%max disp
                    %Joint 8
                    [Disp(8,1),Disp(8,3)] = SmithCruciformFun(G,s1,s1,s1,F);%maxK
                    [Disp(8,2),Disp(8,4)] = SmithCruciformFun(G,s1,s2,s1,F);%max disp
                    %Joint 9
                    [Disp(9,1),Disp(9,3)] = SmithTwoAxisFun(E,s1,s1,F);%maxK
                    [Disp(9,2),Disp(9,4)] = SmithTwoAxisFun(E,s2,s1,F);%max disp
                    %Joint 10
                    [Disp(10,1),Disp(10,3)] = TangSymmetricCircularFun(E,s1,s1,s2,F);%maxK
                    [Disp(10,2),Disp(10,4)] = TangSymmetricCircularFun(E,s2,s1,s2,F);%max disp
                    %Joint 11
                    [Disp(11,1),Disp(11,3)] = TreaseConceptFun(G,s1,s1,s1,F);%maxK
                    [Disp(11,2),Disp(11,4)] = TreaseConceptFun(G,s1,s2,s1,F);%max disp
                    %Joint 12
                    [Disp(12,1),Disp(12,3)] = VShapeFun(E,s1,s1,s1,s1,s2,F);%maxK
                    [Disp(12,2),Disp(12,4)] = VShapeFun(E,s1,s2,s2,s2,s2,F);%max disp
                    %Joint 13
                    [Disp(13,1),Disp(13,3)] = KyusojinRotational6R2Fun(E,s1,s1,s2,F);%maxK
                    [Disp(13,2),Disp(13,4)] = KyusojinRotational6R2Fun(E,s1,s2,s2,F);%max disp
                    %Joint 14
                    [Disp(14,1),Disp(14,3)] = ConventionalSplitTubeFun(G,s1,s1,s2,F);%maxK
                    [Disp(14,2),Disp(14,4)] = ConventionalSplitTubeFun(G,s1,s2,s2,F);%max disp

                    Check=zeros(n,2);

                    namesr=char('JensenCrossAxis','LobontiuCornerFilleted','LobontiuSymmetricCircular',...
                    'LobontiuSymmetricNotch','RotationallySymmetric','SmithAnnulus','SmithCartwheel',...
                    'SmithCruciform','SmithTwoAxis','TangSymmetricCircular','TreaseConcept',...
                    'VShape','Kyusojin6R2','ConventionalSplitTube');

                    for i=1:n
                        Check(i,1)=CheckRangeFun(Disp(i,1),Disp(i,2),rom);
                        Check(i,2)=CheckRangeFun(Disp(i,4),Disp(i,3),k);
                    end

                    b=1;
                    for i=1:n
                        if (Check(i,1)==0 || Check(i,2)==0)
                            a(b,1)=i;
                            b=b+1;
                        end
                    end
                    
                	%------------------------------------------------------
                    % Inverse of above for pareto curve production %
                    d=1;                
                    e=0;
                    for i=1:n
                        if (Check(i,1)==1 && Check(i,2)==1)
                            e(d,1)=i;
                            d=d+1;
                        end
                    end

                    z = ParetoFunR_YYY( e,E,G,s1,s2,F);
                    %--------------------
                    sa=size(a);
                    c=sa(1);
                    for i=1:sa(1)
                        namesr(a(c),:)=[];
                        c=c-1;
                    end
                    fprintf('\nPossible joints for this user input using a force of %f N are:\n',Fset(j))
                    disp(namesr)
                    a=0;
                end
                %-----------------------------------------------------%
                %%END OF Y,Y,N TREE
                %-----------------------------------------------------%
            end
        else
            fprintf('k does not have a value (na)\n')
            if fc==0
                fprintf('F has a value\n')
                %This tree - Y,N,Y -> Set F as load applied, check for 
                %any joints that can result in rom.
                %-----------------------------------------------------%

                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration

                %Joint 1
                [Disp(1,1),Disp(1,3)] = JensenCrossAxisFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(1,2),Disp(1,4)] = JensenCrossAxisFun(E,s1,s2,s2,s2,F);%max disp
                %Joint 2
                [Disp(2,1),Disp(2,3)] = LobontiuCornerFilletedFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(2,2),Disp(2,4)] = LobontiuCornerFilletedFun(E,s2,s2,s2,s2,F);%max disp
                %Joint 3
                [Disp(3,1),Disp(3,3)] = LobontiuSymmetricCircularFun(E,s2,s1,s2,F);%maxK
                [Disp(3,2),Disp(3,4)] = LobontiuSymmetricCircularFun(E,s1,s2,s2,F);%max disp
                %Joint 4
                [Disp(4,1),Disp(4,3)] = LobontiuSymmetricNotchFun(E,s1,s1,s2,F);%maxK
                [Disp(4,2),Disp(4,4)] = LobontiuSymmetricNotchFun(E,s1,s2,s2,F);%max disp
                %Joint 5
                [Disp(5,1),Disp(5,3)] = RotationallySymmetricLeafHingeFun(E,s2,s1,F);%maxK
                [Disp(5,2),Disp(5,4)] = RotationallySymmetricLeafHingeFun(E,s1,s2,F);%max disp
                %Joint 6
                [Disp(6,1),Disp(6,3)] = SmithAnnulusFun(E,G,s2,s2,F);%maxK
                [Disp(6,2),Disp(6,4)] = SmithAnnulusFun(E,G,s1,s1,F);%max disp
                %Joint 7
                [Disp(7,1),Disp(7,3)] = SmithCartwheelFun(E,s1,s1,s2,F);%maxK
                [Disp(7,2),Disp(7,4)] = SmithCartwheelFun(E,s1,s2,s2,F);%max disp
                %Joint 8
                [Disp(8,1),Disp(8,3)] = SmithCruciformFun(G,s1,s1,s1,F);%maxK
                [Disp(8,2),Disp(8,4)] = SmithCruciformFun(G,s1,s2,s1,F);%max disp
                %Joint 9
                [Disp(9,1),Disp(9,3)] = SmithTwoAxisFun(E,s1,s1,F);%maxK
                [Disp(9,2),Disp(9,4)] = SmithTwoAxisFun(E,s2,s1,F);%max disp
                %Joint 10
                [Disp(10,1),Disp(10,3)] = TangSymmetricCircularFun(E,s1,s1,s2,F);%maxK
                [Disp(10,2),Disp(10,4)] = TangSymmetricCircularFun(E,s2,s1,s2,F);%max disp
                %Joint 11
                [Disp(11,1),Disp(11,3)] = TreaseConceptFun(G,s1,s1,s1,F);%maxK
                [Disp(11,2),Disp(11,4)] = TreaseConceptFun(G,s1,s2,s1,F);%max disp
                %Joint 12
                [Disp(12,1),Disp(12,3)] = VShapeFun(E,s1,s1,s1,s1,s2,F);%maxK
                [Disp(12,2),Disp(12,4)] = VShapeFun(E,s1,s2,s2,s2,s2,F);%max disp
                %Joint 13
                [Disp(13,1),Disp(13,3)] = KyusojinRotational6R2Fun(E,s1,s1,s2,F);%maxK
                [Disp(13,2),Disp(13,4)] = KyusojinRotational6R2Fun(E,s1,s2,s2,F);%max disp
                %Joint 14
                [Disp(14,1),Disp(14,3)] = ConventionalSplitTubeFun(G,s1,s1,s2,F);%maxK
                [Disp(14,2),Disp(14,4)] = ConventionalSplitTubeFun(G,s1,s2,s2,F);%max disp

                Check=zeros(n,1);

                for i=1:n
                    Check(i)=CheckRangeFun(Disp(i,1),Disp(i,2),rom);
                end


                b=1;
                for i=1:n
                    if Check(i)==0
                        a(b,1)=i;
                        b=b+1;
                    end
                end
                
                %------------------------------------------------------
                % Inverse of above for pareto curve production %
                d=1;                
                e=0;
                for i=1:n
                    if Check(i,1)==1
                        e(d,1)=i;
                        d=d+1;
                    end
                end
                
                z = ParetoFunR_YYY( e,E,G,s1,s2,F);
                %--------------------
                sa=size(a);
                c=sa(1);
                for i=1:sa(1)
                    namesr(a(c),:)=[];
                    c=c-1;
                end
                fprintf('\nPossible joints for this user input are:\n')
                disp(namesr)
                %-----------------------------------------------------%
                %%END OF Y,N,Y TREE
                %-----------------------------------------------------%

            else
                fprintf('F does not have a value (na)\n')
                %This tree - Y,N,N -> Search using generic F set applied,
                %find joints that can result in rom.
                %-----------------------------------------------------%

                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration
                sizefset=size(Fset);
                nfset=sizefset(2);
                %This is a loop over the user defined forces, Fset (current 3
                %forces a factor of 10 apart, starting with .1)
                for j=1:nfset
                    F=Fset(j);
                 %Joint 1
                [Disp(1,1),Disp(1,3)] = JensenCrossAxisFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(1,2),Disp(1,4)] = JensenCrossAxisFun(E,s1,s2,s2,s2,F);%max disp
                %Joint 2
                [Disp(2,1),Disp(2,3)] = LobontiuCornerFilletedFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(2,2),Disp(2,4)] = LobontiuCornerFilletedFun(E,s2,s2,s2,s2,F);%max disp
                %Joint 3
                [Disp(3,1),Disp(3,3)] = LobontiuSymmetricCircularFun(E,s2,s1,s2,F);%maxK
                [Disp(3,2),Disp(3,4)] = LobontiuSymmetricCircularFun(E,s1,s2,s2,F);%max disp
                %Joint 4
                [Disp(4,1),Disp(4,3)] = LobontiuSymmetricNotchFun(E,s1,s1,s2,F);%maxK
                [Disp(4,2),Disp(4,4)] = LobontiuSymmetricNotchFun(E,s1,s2,s2,F);%max disp
                %Joint 5
                [Disp(5,1),Disp(5,3)] = RotationallySymmetricLeafHingeFun(E,s2,s1,F);%maxK
                [Disp(5,2),Disp(5,4)] = RotationallySymmetricLeafHingeFun(E,s1,s2,F);%max disp
                %Joint 6
                [Disp(6,1),Disp(6,3)] = SmithAnnulusFun(E,G,s2,s2,F);%maxK
                [Disp(6,2),Disp(6,4)] = SmithAnnulusFun(E,G,s1,s1,F);%max disp
                %Joint 7
                [Disp(7,1),Disp(7,3)] = SmithCartwheelFun(E,s1,s1,s2,F);%maxK
                [Disp(7,2),Disp(7,4)] = SmithCartwheelFun(E,s1,s2,s2,F);%max disp
                %Joint 8
                [Disp(8,1),Disp(8,3)] = SmithCruciformFun(G,s1,s1,s1,F);%maxK
                [Disp(8,2),Disp(8,4)] = SmithCruciformFun(G,s1,s2,s1,F);%max disp
                %Joint 9
                [Disp(9,1),Disp(9,3)] = SmithTwoAxisFun(E,s1,s1,F);%maxK
                [Disp(9,2),Disp(9,4)] = SmithTwoAxisFun(E,s2,s1,F);%max disp
                %Joint 10
                [Disp(10,1),Disp(10,3)] = TangSymmetricCircularFun(E,s1,s1,s2,F);%maxK
                [Disp(10,2),Disp(10,4)] = TangSymmetricCircularFun(E,s2,s1,s2,F);%max disp
                %Joint 11
                [Disp(11,1),Disp(11,3)] = TreaseConceptFun(G,s1,s1,s1,F);%maxK
                [Disp(11,2),Disp(11,4)] = TreaseConceptFun(G,s1,s2,s1,F);%max disp
                %Joint 12
                [Disp(12,1),Disp(12,3)] = VShapeFun(E,s1,s1,s1,s1,s2,F);%maxK
                [Disp(12,2),Disp(12,4)] = VShapeFun(E,s1,s2,s2,s2,s2,F);%max disp
                %Joint 13
                [Disp(13,1),Disp(13,3)] = KyusojinRotational6R2Fun(E,s1,s1,s2,F);%maxK
                [Disp(13,2),Disp(13,4)] = KyusojinRotational6R2Fun(E,s1,s2,s2,F);%max disp
                %Joint 14
                [Disp(14,1),Disp(14,3)] = ConventionalSplitTubeFun(G,s1,s1,s2,F);%maxK
                [Disp(14,2),Disp(14,4)] = ConventionalSplitTubeFun(G,s1,s2,s2,F);%max disp

                    Check=zeros(n,1);

                    namesr=char('JensenCrossAxis','LobontiuCornerFilleted','LobontiuSymmetricCircular',...
                    'LobontiuSymmetricNotch','RotationallySymmetric','SmithAnnulus','SmithCartwheel',...
                    'SmithCruciform','SmithTwoAxis','TangSymmetricCircular','TreaseConcept',...
                    'VShape','Kyusojin6R2','ConventionalSplitTube');

                    for i=1:n
                        Check(i)=CheckRangeFun(Disp(i,1),Disp(i,2),rom);
                    end


                    b=1;
                    for i=1:n
                        if Check(i)==0
                            a(b,1)=i;
                            b=b+1;
                        end
                    end
                    
                    %------------------------------------------------------
                    % Inverse of above for pareto curve production %
                    d=1;                
                    e=0;
                    for i=1:n
                        if Check(i,1)==1
                            e(d,1)=i;
                            d=d+1;
                        end
                    end

                    z = ParetoFunR_YYY( e,E,G,s1,s2,F);
                    %--------------------
                    sa=size(a);
                    c=sa(1);
                    for i=1:sa(1)
                        namesr(a(c),:)=[];
                        c=c-1;
                    end
                    fprintf('\nPossible joints for this user input using a force of %f N are:\n',Fset(j))
                    disp(namesr)
                    a=0;

                end
                %-----------------------------------------------------%
                %%END OF Y,N,N TREE
                %-----------------------------------------------------%           
            end 
        end
    else
        fprintf('rom does not have a value (na)\n')
        if kc==0
            fprintf('k has a value\n')
            if fc==0
                fprintf('f has a value\n')
                %This tree - N,Y,Y -> Search using Load as F applied,
                %find geometry that results in k.
                %-----------------------------------------------------%

                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration
                %Joint 1
                [Disp(1,1),Disp(1,3)] = JensenCrossAxisFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(1,2),Disp(1,4)] = JensenCrossAxisFun(E,s1,s2,s2,s2,F);%max disp
                %Joint 2
                [Disp(2,1),Disp(2,3)] = LobontiuCornerFilletedFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(2,2),Disp(2,4)] = LobontiuCornerFilletedFun(E,s2,s2,s2,s2,F);%max disp
                %Joint 3
                [Disp(3,1),Disp(3,3)] = LobontiuSymmetricCircularFun(E,s2,s1,s2,F);%maxK
                [Disp(3,2),Disp(3,4)] = LobontiuSymmetricCircularFun(E,s1,s2,s2,F);%max disp
                %Joint 4
                [Disp(4,1),Disp(4,3)] = LobontiuSymmetricNotchFun(E,s1,s1,s2,F);%maxK
                [Disp(4,2),Disp(4,4)] = LobontiuSymmetricNotchFun(E,s1,s2,s2,F);%max disp
                %Joint 5
                [Disp(5,1),Disp(5,3)] = RotationallySymmetricLeafHingeFun(E,s2,s1,F);%maxK
                [Disp(5,2),Disp(5,4)] = RotationallySymmetricLeafHingeFun(E,s1,s2,F);%max disp
                %Joint 6
                [Disp(6,1),Disp(6,3)] = SmithAnnulusFun(E,G,s2,s2,F);%maxK
                [Disp(6,2),Disp(6,4)] = SmithAnnulusFun(E,G,s1,s1,F);%max disp
                %Joint 7
                [Disp(7,1),Disp(7,3)] = SmithCartwheelFun(E,s1,s1,s2,F);%maxK
                [Disp(7,2),Disp(7,4)] = SmithCartwheelFun(E,s1,s2,s2,F);%max disp
                %Joint 8
                [Disp(8,1),Disp(8,3)] = SmithCruciformFun(G,s1,s1,s1,F);%maxK
                [Disp(8,2),Disp(8,4)] = SmithCruciformFun(G,s1,s2,s1,F);%max disp
                %Joint 9
                [Disp(9,1),Disp(9,3)] = SmithTwoAxisFun(E,s1,s1,F);%maxK
                [Disp(9,2),Disp(9,4)] = SmithTwoAxisFun(E,s2,s1,F);%max disp
                %Joint 10
                [Disp(10,1),Disp(10,3)] = TangSymmetricCircularFun(E,s1,s1,s2,F);%maxK
                [Disp(10,2),Disp(10,4)] = TangSymmetricCircularFun(E,s2,s1,s2,F);%max disp
                %Joint 11
                [Disp(11,1),Disp(11,3)] = TreaseConceptFun(G,s1,s1,s1,F);%maxK
                [Disp(11,2),Disp(11,4)] = TreaseConceptFun(G,s1,s2,s1,F);%max disp
                %Joint 12
                [Disp(12,1),Disp(12,3)] = VShapeFun(E,s1,s1,s1,s1,s2,F);%maxK
                [Disp(12,2),Disp(12,4)] = VShapeFun(E,s1,s2,s2,s2,s2,F);%max disp
                %Joint 13
                [Disp(13,1),Disp(13,3)] = KyusojinRotational6R2Fun(E,s1,s1,s2,F);%maxK
                [Disp(13,2),Disp(13,4)] = KyusojinRotational6R2Fun(E,s1,s2,s2,F);%max disp
                %Joint 14
                [Disp(14,1),Disp(14,3)] = ConventionalSplitTubeFun(G,s1,s1,s2,F);%maxK
                [Disp(14,2),Disp(14,4)] = ConventionalSplitTubeFun(G,s1,s2,s2,F);%max disp
                
                Check=zeros(n,1);

                for i=1:n
                    Check(i)=CheckRangeFun(Disp(i,4),Disp(i,3),k);
                end


                b=1;
                for i=1:n
                    if Check(i)==0
                        a(b,1)=i;
                        b=b+1;
                    end
                end
                
                %------------------------------------------------------
                % Inverse of above for pareto curve production %
                d=1;                
                e=0;
                for i=1:n
                    if Check(i,1)==1
                        e(d,1)=i;
                        d=d+1;
                    end
                end
                
                z = ParetoFunR_YYY( e,E,G,s1,s2,F);
                %--------------------
                sa=size(a);
                c=sa(1);
                for i=1:sa(1)
                    namesr(a(c),:)=[];
                    c=c-1;
                end
                fprintf('\nPossible joints for this user input are:\n')
                disp(namesr)
                %-----------------------------------------------------%
                %%END OF N,Y,Y TREE
                %-----------------------------------------------------%
            else
                fprintf('f does not have a value (na)\n')
                %This tree - N,Y,N -> Search using generic F set applied,
                %find geometry that results in k.
                %-----------------------------------------------------%


                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration
                sizefset=size(Fset);
                nfset=sizefset(2);
                %This is a loop over the user defined forces, Fset (current 3
                %forces a factor of 10 apart, starting with .1)
                for j=1:nfset
                    F=Fset(j);

                  %Joint 1
                [Disp(1,1),Disp(1,3)] = JensenCrossAxisFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(1,2),Disp(1,4)] = JensenCrossAxisFun(E,s1,s2,s2,s2,F);%max disp
                %Joint 2
                [Disp(2,1),Disp(2,3)] = LobontiuCornerFilletedFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(2,2),Disp(2,4)] = LobontiuCornerFilletedFun(E,s2,s2,s2,s2,F);%max disp
                %Joint 3
                [Disp(3,1),Disp(3,3)] = LobontiuSymmetricCircularFun(E,s2,s1,s2,F);%maxK
                [Disp(3,2),Disp(3,4)] = LobontiuSymmetricCircularFun(E,s1,s2,s2,F);%max disp
                %Joint 4
                [Disp(4,1),Disp(4,3)] = LobontiuSymmetricNotchFun(E,s1,s1,s2,F);%maxK
                [Disp(4,2),Disp(4,4)] = LobontiuSymmetricNotchFun(E,s1,s2,s2,F);%max disp
                %Joint 5
                [Disp(5,1),Disp(5,3)] = RotationallySymmetricLeafHingeFun(E,s2,s1,F);%maxK
                [Disp(5,2),Disp(5,4)] = RotationallySymmetricLeafHingeFun(E,s1,s2,F);%max disp
                %Joint 6
                [Disp(6,1),Disp(6,3)] = SmithAnnulusFun(E,G,s2,s2,F);%maxK
                [Disp(6,2),Disp(6,4)] = SmithAnnulusFun(E,G,s1,s1,F);%max disp
                %Joint 7
                [Disp(7,1),Disp(7,3)] = SmithCartwheelFun(E,s1,s1,s2,F);%maxK
                [Disp(7,2),Disp(7,4)] = SmithCartwheelFun(E,s1,s2,s2,F);%max disp
                %Joint 8
                [Disp(8,1),Disp(8,3)] = SmithCruciformFun(G,s1,s1,s1,F);%maxK
                [Disp(8,2),Disp(8,4)] = SmithCruciformFun(G,s1,s2,s1,F);%max disp
                %Joint 9
                [Disp(9,1),Disp(9,3)] = SmithTwoAxisFun(E,s1,s1,F);%maxK
                [Disp(9,2),Disp(9,4)] = SmithTwoAxisFun(E,s2,s1,F);%max disp
                %Joint 10
                [Disp(10,1),Disp(10,3)] = TangSymmetricCircularFun(E,s1,s1,s2,F);%maxK
                [Disp(10,2),Disp(10,4)] = TangSymmetricCircularFun(E,s2,s1,s2,F);%max disp
                %Joint 11
                [Disp(11,1),Disp(11,3)] = TreaseConceptFun(G,s1,s1,s1,F);%maxK
                [Disp(11,2),Disp(11,4)] = TreaseConceptFun(G,s1,s2,s1,F);%max disp
                %Joint 12
                [Disp(12,1),Disp(12,3)] = VShapeFun(E,s1,s1,s1,s1,s2,F);%maxK
                [Disp(12,2),Disp(12,4)] = VShapeFun(E,s1,s2,s2,s2,s2,F);%max disp
                %Joint 13
                [Disp(13,1),Disp(13,3)] = KyusojinRotational6R2Fun(E,s1,s1,s2,F);%maxK
                [Disp(13,2),Disp(13,4)] = KyusojinRotational6R2Fun(E,s1,s2,s2,F);%max disp
                %Joint 14
                [Disp(14,1),Disp(14,3)] = ConventionalSplitTubeFun(G,s1,s1,s2,F);%maxK
                [Disp(14,2),Disp(14,4)] = ConventionalSplitTubeFun(G,s1,s2,s2,F);%max disp

                    Check=zeros(n,1);
                    namesr=char('JensenCrossAxis','LobontiuCornerFilleted','LobontiuSymmetricCircular',...
                    'LobontiuSymmetricNotch','RotationallySymmetric','SmithAnnulus','SmithCartwheel',...
                    'SmithCruciform','SmithTwoAxis','TangSymmetricCircular','TreaseConcept',...
                    'VShape','Kyusojin6R2','ConventionalSplitTube');

                    for i=1:n
                        Check(i)=CheckRangeFun(Disp(i,4),Disp(i,3),k);
                    end


                    b=1;
                    for i=1:n
                        if Check(i)==0
                            a(b,1)=i;
                            b=b+1;
                        end
                    end
                    
                	%------------------------------------------------------
                    % Inverse of above for pareto curve production %
                    d=1;                
                    e=0;
                    for i=1:n
                        if Check(i,1)==1
                            e(d,1)=i;
                            d=d+1;
                        end
                    end

                    z = ParetoFunR_YYY( e,E,G,s1,s2,F);
                    %--------------------
                    sa=size(a);
                    c=sa(1);
                    for i=1:sa(1)
                        namesr(a(c),:)=[];
                        c=c-1;
                    end
                    fprintf('\nPossible joints for this user input using a force of %f N are:\n',Fset(j))
                    disp(namesr)
                    a=0;
                end
                %-----------------------------------------------------%
                %%END OF N,Y,N TREE
                %-----------------------------------------------------%          
            end
        else
            fprintf('k does not have a value (na)\n')
            if fc==0
                fprintf('f has a value\n')
                %This tree - N,N,Y -> Set F as load applied, present user
                %all joints, organize by rom.
                %-----------------------------------------------------%

                %Joint 1
                [Disp(1,1),Disp(1,3)] = JensenCrossAxisFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(1,2),Disp(1,4)] = JensenCrossAxisFun(E,s1,s2,s2,s2,F);%max disp
                %Joint 2
                [Disp(2,1),Disp(2,3)] = LobontiuCornerFilletedFun(E,s1,s1,s1,s2,F);%maxK
                [Disp(2,2),Disp(2,4)] = LobontiuCornerFilletedFun(E,s2,s2,s2,s2,F);%max disp
                %Joint 3
                [Disp(3,1),Disp(3,3)] = LobontiuSymmetricCircularFun(E,s2,s1,s2,F);%maxK
                [Disp(3,2),Disp(3,4)] = LobontiuSymmetricCircularFun(E,s1,s2,s2,F);%max disp
                %Joint 4
                [Disp(4,1),Disp(4,3)] = LobontiuSymmetricNotchFun(E,s1,s1,s2,F);%maxK
                [Disp(4,2),Disp(4,4)] = LobontiuSymmetricNotchFun(E,s1,s2,s2,F);%max disp
                %Joint 5
                [Disp(5,1),Disp(5,3)] = RotationallySymmetricLeafHingeFun(E,s2,s1,F);%maxK
                [Disp(5,2),Disp(5,4)] = RotationallySymmetricLeafHingeFun(E,s1,s2,F);%max disp
                %Joint 6
                [Disp(6,1),Disp(6,3)] = SmithAnnulusFun(E,G,s2,s2,F);%maxK
                [Disp(6,2),Disp(6,4)] = SmithAnnulusFun(E,G,s1,s1,F);%max disp
                %Joint 7
                [Disp(7,1),Disp(7,3)] = SmithCartwheelFun(E,s1,s1,s2,F);%maxK
                [Disp(7,2),Disp(7,4)] = SmithCartwheelFun(E,s1,s2,s2,F);%max disp
                %Joint 8
                [Disp(8,1),Disp(8,3)] = SmithCruciformFun(G,s1,s1,s1,F);%maxK
                [Disp(8,2),Disp(8,4)] = SmithCruciformFun(G,s1,s2,s1,F);%max disp
                %Joint 9
                [Disp(9,1),Disp(9,3)] = SmithTwoAxisFun(E,s1,s1,F);%maxK
                [Disp(9,2),Disp(9,4)] = SmithTwoAxisFun(E,s2,s1,F);%max disp
                %Joint 10
                [Disp(10,1),Disp(10,3)] = TangSymmetricCircularFun(E,s1,s1,s2,F);%maxK
                [Disp(10,2),Disp(10,4)] = TangSymmetricCircularFun(E,s2,s1,s2,F);%max disp
                %Joint 11
                [Disp(11,1),Disp(11,3)] = TreaseConceptFun(G,s1,s1,s1,F);%maxK
                [Disp(11,2),Disp(11,4)] = TreaseConceptFun(G,s1,s2,s1,F);%max disp
                %Joint 12
                [Disp(12,1),Disp(12,3)] = VShapeFun(E,s1,s1,s1,s1,s2,F);%maxK
                [Disp(12,2),Disp(12,4)] = VShapeFun(E,s1,s2,s2,s2,s2,F);%max disp
                %Joint 13
                [Disp(13,1),Disp(13,3)] = KyusojinRotational6R2Fun(E,s1,s1,s2,F);%maxK
                [Disp(13,2),Disp(13,4)] = KyusojinRotational6R2Fun(E,s1,s2,s2,F);%max disp
                %Joint 14
                [Disp(14,1),Disp(14,3)] = ConventionalSplitTubeFun(G,s1,s1,s2,F);%maxK
                [Disp(14,2),Disp(14,4)] = ConventionalSplitTubeFun(G,s1,s2,s2,F);%max disp
                
                Check=zeros(n,1);

                Disp=sortrows(Disp,2);
                fprintf('\nThe following joints are organized by RoM,\nLargest to smallest, for the given force, %f N :\n',F)

                names=cellstr(namesr);
                for i=n:-1:1
                    name=names{Disp(i,5)};
                    fprintf('%s with %2.4f mm displacement. \n',name,Disp(i,2))

                end
                
                %------------------------------------------------------
                % Inverse of above for pareto curve production %
                d=1;                
                e=0;
                for i=1:n
                    if Check(i,1)==1
                        e(d,1)=i;
                        d=d+1;
                    end
                end
                
                z = ParetoFunR_YYY( e,E,G,s1,s2,F);
                %--------------------


                %-----------------------------------------------------%
                %%END OF N,N,Y TREE
                %-----------------------------------------------------%
            else
                fprintf('f does not have a value (na)\n')
                %This tree - N,N,N -> Will result in all results being 
                %returned, cannot specify with no information
                %-----------------------------------------------------%
                %Find the minimum and maximum displacement for each joint - leave thickness
                %constant, vary the depth of the joint from each iteration
                sizefset=size(Fset);
                nfset=sizefset(2);
                %This is a loop over the user defined forces, Fset (current 3
                %forces a factor of 10 apart, starting with .1)
                for j=1:nfset
                    F=Fset(j);
                    %Joint 1
                    [Disp(1,1),Disp(1,3)] = JensenCrossAxisFun(E,s1,s1,s1,s2,F);%maxK
                    [Disp(1,2),Disp(1,4)] = JensenCrossAxisFun(E,s1,s2,s2,s2,F);%max disp
                    %Joint 2
                    [Disp(2,1),Disp(2,3)] = LobontiuCornerFilletedFun(E,s1,s1,s1,s2,F);%maxK
                    [Disp(2,2),Disp(2,4)] = LobontiuCornerFilletedFun(E,s2,s2,s2,s2,F);%max disp
                    %Joint 3
                    [Disp(3,1),Disp(3,3)] = LobontiuSymmetricCircularFun(E,s2,s1,s2,F);%maxK
                    [Disp(3,2),Disp(3,4)] = LobontiuSymmetricCircularFun(E,s1,s2,s2,F);%max disp
                    %Joint 4
                    [Disp(4,1),Disp(4,3)] = LobontiuSymmetricNotchFun(E,s1,s1,s2,F);%maxK
                    [Disp(4,2),Disp(4,4)] = LobontiuSymmetricNotchFun(E,s1,s2,s2,F);%max disp
                    %Joint 5
                    [Disp(5,1),Disp(5,3)] = RotationallySymmetricLeafHingeFun(E,s2,s1,F);%maxK
                    [Disp(5,2),Disp(5,4)] = RotationallySymmetricLeafHingeFun(E,s1,s2,F);%max disp
                    %Joint 6
                    [Disp(6,1),Disp(6,3)] = SmithAnnulusFun(E,G,s2,s2,F);%maxK
                    [Disp(6,2),Disp(6,4)] = SmithAnnulusFun(E,G,s1,s1,F);%max disp
                    %Joint 7
                    [Disp(7,1),Disp(7,3)] = SmithCartwheelFun(E,s1,s1,s2,F);%maxK
                    [Disp(7,2),Disp(7,4)] = SmithCartwheelFun(E,s1,s2,s2,F);%max disp
                    %Joint 8
                    [Disp(8,1),Disp(8,3)] = SmithCruciformFun(G,s1,s1,s1,F);%maxK
                    [Disp(8,2),Disp(8,4)] = SmithCruciformFun(G,s1,s2,s1,F);%max disp
                    %Joint 9
                    [Disp(9,1),Disp(9,3)] = SmithTwoAxisFun(E,s1,s1,F);%maxK
                    [Disp(9,2),Disp(9,4)] = SmithTwoAxisFun(E,s2,s1,F);%max disp
                    %Joint 10
                    [Disp(10,1),Disp(10,3)] = TangSymmetricCircularFun(E,s1,s1,s2,F);%maxK
                    [Disp(10,2),Disp(10,4)] = TangSymmetricCircularFun(E,s2,s1,s2,F);%max disp
                    %Joint 11
                    [Disp(11,1),Disp(11,3)] = TreaseConceptFun(G,s1,s1,s1,F);%maxK
                    [Disp(11,2),Disp(11,4)] = TreaseConceptFun(G,s1,s2,s1,F);%max disp
                    %Joint 12
                    [Disp(12,1),Disp(12,3)] = VShapeFun(E,s1,s1,s1,s1,s2,F);%maxK
                    [Disp(12,2),Disp(12,4)] = VShapeFun(E,s1,s2,s2,s2,s2,F);%max disp
                    %Joint 13
                    [Disp(13,1),Disp(13,3)] = KyusojinRotational6R2Fun(E,s1,s1,s2,F);%maxK
                    [Disp(13,2),Disp(13,4)] = KyusojinRotational6R2Fun(E,s1,s2,s2,F);%max disp
                    %Joint 14
                    [Disp(14,1),Disp(14,3)] = ConventionalSplitTubeFun(G,s1,s1,s2,F);%maxK
                    [Disp(14,2),Disp(14,4)] = ConventionalSplitTubeFun(G,s1,s2,s2,F);%max disp

                    Check=zeros(n,1);

                    Disp=sortrows(Disp,2);
                    fprintf('\nPossible joints for this user input using a force of %2.3f N,\n organized by RoM are:\n',Fset(j))

                    names=cellstr(namesr);
                    for i=n:-1:1
                        name=names{Disp(i,5)};
                        fprintf('%s with %2.4f mm displacement. \n',name,Disp(i,2))
                    end
                end
                %-----------------------------------------------------%
                %%END OF N,N,N TREE
                %-----------------------------------------------------%
            end
        end
    end
     
end












