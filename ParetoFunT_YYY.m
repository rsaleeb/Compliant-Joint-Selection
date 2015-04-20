function [ fig ] = ParetoFunT_YYY( array,E,s1,s2,F,nfig )

    s1c=s1;
    s2c=s2;
    scount=(s2-s1)/10;
    Disp=[0];
    k=[0];

    sizea=size(array);
    nsubplot=sizea(1);
    width=ceil(nsubplot/2);
    height=2;
    num=1;

    fig=figure(nfig);
    b=1;
    a=ismember(1,array);
    if a == 1
        %pareto for joint 1
        for i=s1:scount:s2
            [Disp(b),k(b)]=SmithRectilinearSpringFun(E,s1c,i,s2c,F);
            b=b+1;    
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (mm)')
        ylabel('Stiffness (N/mm)')
        title('Pareto Curve for Smith Rectilinear Spring') 
        num=num+1;
    end

    b=1;
    a=ismember(2,array);
    if a == 1
        %pareto for joint 2
        for i=s1:scount:s2
            [Disp(b),k(b)]=ParallelStripFun(E,i,s1c,s2c,F);
            b=b+1;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (mm)')
        ylabel('Stiffness (N/mm)')
        title('Pareto Curve for Parallel Strip')
        num=num+1;
    end

    b=1;
    a=ismember(3,array);
    if a == 1
        %pareto for joint 3
        for i=s1:scount:s2
            [Disp(b),k(b)]=KyusojinLinear6L1Fun(E,s1c,i,s2c,F);
            b=b+1;     
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (mm)')
        ylabel('Stiffness (N/mm)')
        title('Pareto Curve for Kyusojin Linear 6L1')
        num=num+1;
    end

    b=1;
    a=ismember(4,array);
    if a == 1
        %pareto for joint 4
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=TreaseTranslationalFun( E,s1c,s2c,j,F );
            b=b+1;
            j=j-scount;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (mm)')
        ylabel('Stiffness (N/mm)')
        title('Pareto Curve for Trease Translational')
        num=num+1;
    end

    b=1;
    a=ismember(5,array);
    if a == 1
        %pareto for joint 5
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=XuTranslationalFun( E,s1c,j,s1c,s2c,F );
            b=b+1;
            j=j-scount;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (mm)')
        ylabel('Stiffness (N/mm)')
        title('Pareto Curve for Xu Translational')
        num=num+1;
    end

    b=1;
    a=ismember(6,array);
    if a == 1
        %pareto for joint 6
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=SmithNotchHingeFun(E,j,s1c,s2c,j,F);
            b=b+1;   
            j=j-scount;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (mm)')
        ylabel('Stiffness (N/mm)')
        title('Pareto Curve for Smith Notch Hinge')
    end
end

