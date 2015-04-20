function [ fig ] = ParetoFunR_YYY( array,E,G,s1,s2,F,nfig )

    s1c=s1;
    s2c=s2;
    scount=abs(s2-s1)/10;
    Disp=[0];
    k=[0];

    sizea=size(array);
    nsubplot=sizea(1);
    width=ceil(nsubplot/2);
    height=3;
    num=1;

    fig=figure(nfig);
    b=1;
    a=ismember(1,array);
    if a == 1
        %pareto for joint 1
        for i=s1:scount:s2
            [Disp(b),k(b)]=JensenCrossAxisFun(E,s1c,i,i,s2c,F);
            b=b+1;    
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Jensen Cross Axis')
        num=num+1;
    end

    b=1;
    a=ismember(2,array);
    if a == 1
        %pareto for joint 2
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=LobontiuCornerFilletedFun(E,i,i,i,s2c,F);
            b=b+1;
            j=j-scount;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Lobontiu Corner Filleted')
        num=num+1;
    end

    b=1;
    a=ismember(3,array);
    if a == 1
        %pareto for joint 3
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=LobontiuSymmetricCircularFun(E,s1c,i,s2c,F);
            b=b+1;
            j=j-scount;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Lobontiu Symmetric Circular')
        num=num+1;
    end

    b=1;
    a=ismember(4,array);
    if a == 1
        %pareto for joint 4
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=LobontiuSymmetricNotchFun(E,s1c,i,s2c,F);
            b=b+1;
            j=j-scount;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Lobontiu Symmetric Notch')
        num=num+1;
    end

    b=1;
    a=ismember(5,array);
    if a == 1
        %pareto for joint 5
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=RotationallySymmetricLeafHingeFun(E,s1c,i,F);
            b=b+1;
            j=j-scount;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Rotationally Symmetric Leaf Hinge')
        num=num+1;
    end

    b=1;
    a=ismember(6,array);
    if a == 1
        %pareto for joint 6
        for i=s1:scount:s2
            [Disp(b),k(b)]=SmithAnnulusFun(E,G,i,i,F);
            b=b+1;    
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Smith Annulus') 
        num=num+1;
    end

    b=1;
    a=ismember(7,array);
    if a == 1
        %pareto for joint 7
        for i=s1:scount:s2
            [Disp(b),k(b)]=SmithCartwheelFun(E,s1c,i,s2c,F);
            b=b+1;    
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Smith Cartwheel')
        num=num+1;
    end

    b=1;
    a=ismember(8,array);
    if a == 1
        %pareto for joint 8
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=SmithCruciformFun(G,s1c,j,s1c,F);
            b=b+1;  
            j=j-scount;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Smith Cruciform')
        num=num+1;
    end
    
    b=1;
    a=ismember(9,array);
    if a == 1
        %pareto for joint 9
        for i=s1:scount:s2
            [Disp(b),k(b)]=SmithTwoAxisFun(E,i,s1c,F);
            b=b+1;    
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Smith Two Axis')
        num=num+1;
    end
    
    b=1;
    a=ismember(10,array);
    if a == 1
        %pareto for joint 10
        for i=s1:scount:s2
            [Disp(b),k(b)]=TangSymmetricCircularFun(E,i,s1c,s2c,F);
            b=b+1;    
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Tang Symmetric Circular')
        num=num+1;
    end
    
    b=1;
    a=ismember(11,array);
    if a == 1
        %pareto for joint 11

        for i=s1:scount:s2
            [Disp(b),k(b)]=TreaseConceptFun(G,s1c,i,s1c,F);
            b=b+1;  
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Trease Concept')
        num=num+1;
    end
    
    b=1;
    a=ismember(12,array);
    if a == 1
        %pareto for joint 12
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=VShapeFun(E,s1c,i,i,i,s2c,F);
            b=b+1;  
            j=j-scount;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for V Shape Flexure')
        num=num+1;
    end
    
    b=1;
    a=ismember(13,array);
    if a == 1
        %pareto for joint 13
        j=s2;
        for i=s1:scount:s2
            [Disp(b),k(b)]=KyusojinRotational6R2Fun(E,s1c,i,s2c,F);
            b=b+1;  
            j=j-scount;
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Kyusojin Rotational 6R2')
        num=num+1;
    end
    
    b=1;
    a=ismember(14,array);
    if a == 1
        %pareto for joint 14
        for i=s1:scount:s2
            [Disp(b),k(b)]=ConventionalSplitTubeFun(G,s1c,i,s2c,F);
            b=b+1;  
        end
        subplot(height,width,num)
        plot(Disp,k)
        xlabel('Displacement (degrees)')
        ylabel('Stiffness (Nmm/degree)')
        title('Pareto Curve for Conventional Split Tube')
    end
end

