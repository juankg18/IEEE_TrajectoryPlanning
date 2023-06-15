function [Boolt,x_innerOut,y_innerOut,x_outerAOut,y_outerAOut]=combinecurves(x_inner, y_inner,x_outerA, y_outerA, cho)
disp('BeginB')
Puntos=0;
for i=2:length(x_inner)
    for j=2:length(x_outerA)
        aja = [x_inner(1,i-1) y_inner(1,i-1); x_inner(1,i) y_inner(1,i)];
        bja = [x_outerA(1,j-1) y_outerA(1,j-1); x_outerA(1,j) y_outerA(1,j)];
        daja = diff(aja);
        dbja = diff(bja);
        maja = daja(2)/daja(1);
        mbja = dbja(2)/dbja(1);
        if abs(maja) == Inf
            xsol = aja(1,1);
            ysol = mbja*(xsol-bja(1,1))+bja(1,2);
        else
            if abs(mbja) == Inf
                xsol = bja(1,1);
                ysol = maja*(xsol-aja(1,1))+aja(1,2);
            else
                xsol = (maja*aja(1,1)-mbja*bja(1,1)+bja(1,2)-aja(1,2))/(maja-mbja);
                ysol = maja*(xsol-aja(1,1))+aja(1,2);
            end
        end
        if (((xsol<=x_inner(1,i-1)&&xsol>=x_inner(1,i))||(xsol>=x_inner(1,i-1)&&xsol<=x_inner(1,i)))&&((xsol<=x_outerA(1,j-1)&&xsol>=x_outerA(1,j))||(xsol>=x_outerA(1,j-1)&&xsol<=x_outerA(1,j))))&&(((ysol<=y_inner(1,i-1)&&ysol>=y_inner(1,i))||(ysol>=y_inner(1,i-1)&&ysol<=y_inner(1,i)))&&((ysol<=y_outerA(1,j-1)&&ysol>=y_outerA(1,j))||(ysol>=y_outerA(1,j-1)&&ysol<=y_outerA(1,j))))
            Puntos=Puntos+1;
            Tpi(Puntos)=i;
            Vpi(Puntos)=j;
            Xpi(Puntos)=xsol;
            Ypi(Puntos)=ysol;
            TRT=['Encontre Corte en ',num2str(xsol),' y en ',num2str(ysol)];
            disp(TRT)
        end
    end
end
if Puntos == 0
    Boolt=false;
    x_innerOut=x_inner;
    y_innerOut=y_inner;
    x_outerAOut=x_outerA;
    y_outerAOut=y_outerA;
else
    if mod(Puntos,2)==0
        if Puntos == 2      
            Vpi
            [Blun,Tlun]=sort(Vpi)
            tec=inpolygon(x_outerA(1),y_outerA(1),x_inner,y_inner);
            tec2=~inpolygon(x_inner(1),y_inner(1),x_outerA,y_outerA);
            if tec
                CorteinX=[Xpi(Tlun(2)) x_outerA(Vpi(Tlun(2)):end-1) x_outerA(1:Vpi(Tlun(1))-1) Xpi(Tlun(1))];
                CorteinY=[Ypi(Tlun(2)) y_outerA(Vpi(Tlun(2)):end-1) y_outerA(1:Vpi(Tlun(1))-1) Ypi(Tlun(1))];
            else
                CorteinX=[Xpi(Tlun(1)) x_outerA(Vpi(Tlun(1)):Vpi(Tlun(2))-1) Xpi(Tlun(2))];
                CorteinY=[Ypi(Tlun(1)) y_outerA(Vpi(Tlun(1)):Vpi(Tlun(2))-1) Ypi(Tlun(2))];
            end
            if tec2
                CorteoutX=[x_inner(Tpi(Tlun(2)):end-1) x_inner(1:Tpi(Tlun(1))-1)];
                CorteoutY=[y_inner(Tpi(Tlun(2)):end-1) y_inner(1:Tpi(Tlun(1))-1)];
            else
                CorteoutX=[x_inner(Tpi(Tlun(1)):Tpi(Tlun(2))-1)];
                CorteoutY=[y_inner(Tpi(Tlun(1)):Tpi(Tlun(2))-1)];
            end
            if ~((((CorteoutX(end)-CorteinX(end))^2+(CorteoutY(end)-CorteinY(end))^2)+((CorteoutX(1)-CorteinX(1))^2+(CorteoutY(1)-CorteinY(1))^2)>(((CorteoutX(1)-CorteinX(end))^2+(CorteoutY(1)-CorteinY(end))^2))+((CorteoutX(end)-CorteinX(1))^2+(CorteoutY(end)-CorteinY(1))^2)))
                CorteoutX=flip(CorteoutX);
                CorteoutY=flip(CorteoutY);
            end
            Boolt=true;
            x_innerOut=[CorteinX CorteoutX CorteinX(1)];
            y_innerOut=[CorteinY CorteoutY CorteinY(1)];
            x_outerAOut=[];
            y_outerAOut=[];
        end
        if Puntos == 8     
            Vpi
            [Blun,Tlun]=sort(Vpi)
            tec=~inpolygon(x_outerA(1),y_outerA(1),x_inner,y_inner);
            tec2=inpolygon(x_inner(1),y_inner(1),x_outerA,y_outerA);
            if tec
                CorteinX=[Xpi(Tlun(cho+1)) x_outerA(Vpi(Tlun(cho+1)):end-1) x_outerA(1:Vpi(Tlun(cho))-1) Xpi(Tlun(cho))];
                CorteinY=[Ypi(Tlun(cho+1)) y_outerA(Vpi(Tlun(cho+1)):end-1) y_outerA(1:Vpi(Tlun(cho))-1) Ypi(Tlun(cho))];
            else
                CorteinX=[Xpi(Tlun(cho)) x_outerA(Vpi(Tlun(cho)):Vpi(Tlun(cho+1))-1) Xpi(Tlun(cho+1))];
                CorteinY=[Ypi(Tlun(cho)) y_outerA(Vpi(Tlun(cho)):Vpi(Tlun(cho+1))-1) Ypi(Tlun(cho+1))];
            end
            if tec2
                CorteoutX=[x_inner(Tpi(Tlun(cho+1)):end-1) x_inner(1:Tpi(Tlun(cho))-1)];
                CorteoutY=[y_inner(Tpi(Tlun(cho+1)):end-1) y_inner(1:Tpi(Tlun(cho))-1)];
            else
                CorteoutX=[x_inner(Tpi(Tlun(cho)):Tpi(Tlun(cho+1))-1)];
                CorteoutY=[y_inner(Tpi(Tlun(cho)):Tpi(Tlun(cho+1))-1)];
            end
            if ~((((CorteoutX(end)-CorteinX(end))^2+(CorteoutY(end)-CorteinY(end))^2)+((CorteoutX(1)-CorteinX(1))^2+(CorteoutY(1)-CorteinY(1))^2)>(((CorteoutX(1)-CorteinX(end))^2+(CorteoutY(1)-CorteinY(end))^2))+((CorteoutX(end)-CorteinX(1))^2+(CorteoutY(end)-CorteinY(1))^2)))
                CorteoutX=flip(CorteoutX);
                CorteoutY=flip(CorteoutY);
            end
            Boolt=true;
            x_innerOut=[CorteinX CorteoutX CorteinX(1)];
            y_innerOut=[CorteinY CorteoutY CorteinY(1)];
            x_outerAOut=[];
            y_outerAOut=[];
        end
    else
        disp("Cortes impares")
    end
end