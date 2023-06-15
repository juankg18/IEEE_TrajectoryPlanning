function [TrayTotalX,TrayTotalY]=generateCyclev3(Xtotal,Ytotal,XtotalW,YtotalW,XtotalE,YtotalE,XtotalQ,YtotalQ,XtotalA,YtotalA,XtotalB,YtotalB,Diametro)

Bin=size(Xtotal);
Bin=Bin(2);
Bb=~isnan(Xtotal(:,Bin));
%Contorno
Xaux=Xtotal(Bb,Bin);
Yaux=Ytotal(Bb,Bin);

%Punto a Cortar
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
Num=rand*Mag;

%Corte de Contorno
[Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xaux,Yaux,Num,Diametro);

%Graficar
plot(Xaux,Yaux,'b','LineWidth',2)
hold on
plot(Xcut,Ycut,'y','LineWidth',2)

%Trayectoria Total
TrayTotalX=Xcut;
TrayTotalY=Ycut;

for iii=1:1

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(Xtotal(:,Bin));
Xaux=Xtotal(Bb,Bin);
Yaux=Ytotal(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

PromPendiente=-(Xin-Xfi)/(Yin-Yfi);

[XcutIn,YcutIn,PosCutA]=nearSlopePoint(Xaux,Yaux,Xin,Yin,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(Xaux,Yaux,Xfi,Yfi,PromPendiente);

%Trayectoria Final
if ((TrayTotalX(1)-XcutFi)^2+(TrayTotalY(1)-YcutFi)^2)<((TrayTotalX(end)-XcutFi)^2+(TrayTotalY(end)-YcutFi)^2)
TrayTotalX=[XcutFi;TrayTotalX;XcutIn];
TrayTotalY=[YcutFi;TrayTotalY;YcutIn];
else
TrayTotalX=[XcutIn;TrayTotalX;XcutFi];
TrayTotalY=[YcutIn;TrayTotalY;YcutFi];
end

%Cortar Contorno en Par de Puntos
[Xcutnn,Ycutnn]=cutContourInPoints(Xaux,Yaux,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi);


%Graficar
scatter(XcutIn,YcutIn,'c')
scatter(XcutFi,YcutFi,'c')
plot(Xaux,Yaux,'b','LineWidth',2)
plot(Xcutnn,Ycutnn,'r','LineWidth',2.5)


%Contorno
Xaux=Xcutnn;
Yaux=Ycutnn;
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
MagAc=[0;cumsum(MagIn)];
Num=rand*(Mag-Diametro);
%Num=mod(iii,2)*(Mag-Diametro)*0.9999999999999;


%Cortar Contorno
[Xcut,Ycut,Xcut2,Ycut2,Xin,Yin,Xfi,Yfi]=cutCurve(Xaux,Yaux,Num,Diametro);


%Trayectoria Total
if Xcut2(1)==TrayTotalX(1) && Ycut2(1)==TrayTotalY(1)
TrayTotalX=[flip(Xcut2(2:end));TrayTotalX;flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));TrayTotalY;flip(Ycut(1:end-1))];
else
if Xcut2(1)==TrayTotalX(end) && Ycut2(1)==TrayTotalY(end)
TrayTotalX=[flip(Xcut2(2:end));flip(TrayTotalX);flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));flip(TrayTotalY);flip(Ycut(1:end-1))];
else
if Xcut2(end)==TrayTotalX(1) && Ycut2(end)==TrayTotalY(1)
TrayTotalX=[Xcut2(1:end-1);TrayTotalX;Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);TrayTotalY;Ycut(2:end)];
else
TrayTotalX=[Xcut2(1:end-1);flip(TrayTotalX);Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);flip(TrayTotalY);Ycut(2:end)];
end
end
end


%Graficar
hold on
plot(Xaux,Yaux,'b','LineWidth',2)
scatter(Xfi,Yfi,'r')
scatter(Xin,Yin,'r')
plot(Xcut,Ycut,'y','LineWidth',2)
plot(Xcut2,Ycut2,'y','LineWidth',2)


end
TrayTotalX2=TrayTotalX;
TrayTotalY2=TrayTotalY;


Bin=size(XtotalW);
Bin=Bin(2);
Bb=~isnan(XtotalW(:,Bin));
%Contorno
Xaux=XtotalW(Bb,Bin);
Yaux=YtotalW(Bb,Bin);

%Punto a Cortar
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
Num=rand*Mag;

%Corte de Contorno
[Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xaux,Yaux,Num,Diametro);

%Graficar
plot(Xaux,Yaux,'b','LineWidth',2)
hold on
plot(Xcut,Ycut,'y','LineWidth',2)

%Trayectoria Total
TrayTotalX=Xcut;
TrayTotalY=Ycut;

for iii=1:1

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(XtotalW(:,Bin));
Xaux=XtotalW(Bb,Bin);
Yaux=YtotalW(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

PromPendiente=-(Xin-Xfi)/(Yin-Yfi);

[XcutIn,YcutIn,PosCutA]=nearSlopePoint(Xaux,Yaux,Xin,Yin,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(Xaux,Yaux,Xfi,Yfi,PromPendiente);

%Trayectoria Final
if ((TrayTotalX(1)-XcutFi)^2+(TrayTotalY(1)-YcutFi)^2)<((TrayTotalX(end)-XcutFi)^2+(TrayTotalY(end)-YcutFi)^2)
TrayTotalX=[XcutFi;TrayTotalX;XcutIn];
TrayTotalY=[YcutFi;TrayTotalY;YcutIn];
else
TrayTotalX=[XcutIn;TrayTotalX;XcutFi];
TrayTotalY=[YcutIn;TrayTotalY;YcutFi];
end

%Cortar Contorno en Par de Puntos
[Xcutnn,Ycutnn]=cutContourInPoints(Xaux,Yaux,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi);


%Graficar
scatter(XcutIn,YcutIn,'c')
scatter(XcutFi,YcutFi,'c')
plot(Xaux,Yaux,'b','LineWidth',2)
plot(Xcutnn,Ycutnn,'r','LineWidth',2.5)


%Contorno
Xaux=Xcutnn;
Yaux=Ycutnn;
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
MagAc=[0;cumsum(MagIn)];
Num=rand*(Mag-Diametro);
%Num=mod(iii,2)*(Mag-Diametro)*0.9999999999999;


%Cortar Contorno
[Xcut,Ycut,Xcut2,Ycut2,Xin,Yin,Xfi,Yfi]=cutCurve(Xaux,Yaux,Num,Diametro);


%Trayectoria Total
if Xcut2(1)==TrayTotalX(1) && Ycut2(1)==TrayTotalY(1)
TrayTotalX=[flip(Xcut2(2:end));TrayTotalX;flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));TrayTotalY;flip(Ycut(1:end-1))];
else
if Xcut2(1)==TrayTotalX(end) && Ycut2(1)==TrayTotalY(end)
TrayTotalX=[flip(Xcut2(2:end));flip(TrayTotalX);flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));flip(TrayTotalY);flip(Ycut(1:end-1))];
else
if Xcut2(end)==TrayTotalX(1) && Ycut2(end)==TrayTotalY(1)
TrayTotalX=[Xcut2(1:end-1);TrayTotalX;Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);TrayTotalY;Ycut(2:end)];
else
TrayTotalX=[Xcut2(1:end-1);flip(TrayTotalX);Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);flip(TrayTotalY);Ycut(2:end)];
end
end
end


%Graficar
hold on
plot(Xaux,Yaux,'b','LineWidth',2)
scatter(Xfi,Yfi,'r')
scatter(Xin,Yin,'r')
plot(Xcut,Ycut,'y','LineWidth',2)
plot(Xcut2,Ycut2,'y','LineWidth',2)


end
TrayTotalX3=TrayTotalX;
TrayTotalY3=TrayTotalY;


Bin=size(XtotalE);
Bin=Bin(2);
Bb=~isnan(XtotalE(:,Bin));
%Contorno
Xaux=XtotalE(Bb,Bin);
Yaux=YtotalE(Bb,Bin);

%Punto a Cortar
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
Num=rand*Mag;

%Corte de Contorno
[Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xaux,Yaux,Num,Diametro);

%Graficar
plot(Xaux,Yaux,'b','LineWidth',2)
hold on
plot(Xcut,Ycut,'y','LineWidth',2)

%Trayectoria Total
TrayTotalX=Xcut;
TrayTotalY=Ycut;

for iii=1:1

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(XtotalE(:,Bin));
Xaux=XtotalE(Bb,Bin);
Yaux=YtotalE(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

PromPendiente=-(Xin-Xfi)/(Yin-Yfi);

[XcutIn,YcutIn,PosCutA]=nearSlopePoint(Xaux,Yaux,Xin,Yin,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(Xaux,Yaux,Xfi,Yfi,PromPendiente);

%Trayectoria Final
if ((TrayTotalX(1)-XcutFi)^2+(TrayTotalY(1)-YcutFi)^2)<((TrayTotalX(end)-XcutFi)^2+(TrayTotalY(end)-YcutFi)^2)
TrayTotalX=[XcutFi;TrayTotalX;XcutIn];
TrayTotalY=[YcutFi;TrayTotalY;YcutIn];
else
TrayTotalX=[XcutIn;TrayTotalX;XcutFi];
TrayTotalY=[YcutIn;TrayTotalY;YcutFi];
end

%Cortar Contorno en Par de Puntos
[Xcutnn,Ycutnn]=cutContourInPoints(Xaux,Yaux,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi);


%Graficar
scatter(XcutIn,YcutIn,'c')
scatter(XcutFi,YcutFi,'c')
plot(Xaux,Yaux,'b','LineWidth',2)
plot(Xcutnn,Ycutnn,'r','LineWidth',2.5)


%Contorno
Xaux=Xcutnn;
Yaux=Ycutnn;
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
MagAc=[0;cumsum(MagIn)];
Num=rand*(Mag-Diametro);
%Num=mod(iii,2)*(Mag-Diametro)*0.9999999999999;


%Cortar Contorno
[Xcut,Ycut,Xcut2,Ycut2,Xin,Yin,Xfi,Yfi]=cutCurve(Xaux,Yaux,Num,Diametro);


%Trayectoria Total
if Xcut2(1)==TrayTotalX(1) && Ycut2(1)==TrayTotalY(1)
TrayTotalX=[flip(Xcut2(2:end));TrayTotalX;flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));TrayTotalY;flip(Ycut(1:end-1))];
else
if Xcut2(1)==TrayTotalX(end) && Ycut2(1)==TrayTotalY(end)
TrayTotalX=[flip(Xcut2(2:end));flip(TrayTotalX);flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));flip(TrayTotalY);flip(Ycut(1:end-1))];
else
if Xcut2(end)==TrayTotalX(1) && Ycut2(end)==TrayTotalY(1)
TrayTotalX=[Xcut2(1:end-1);TrayTotalX;Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);TrayTotalY;Ycut(2:end)];
else
TrayTotalX=[Xcut2(1:end-1);flip(TrayTotalX);Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);flip(TrayTotalY);Ycut(2:end)];
end
end
end


%Graficar
hold on
plot(Xaux,Yaux,'b','LineWidth',2)
scatter(Xfi,Yfi,'r')
scatter(Xin,Yin,'r')
plot(Xcut,Ycut,'y','LineWidth',2)
plot(Xcut2,Ycut2,'y','LineWidth',2)


end
TrayTotalX4=TrayTotalX;
TrayTotalY4=TrayTotalY;


Bin=size(XtotalQ);
Bin=Bin(2);
Bb=~isnan(XtotalQ(:,Bin));
%Contorno
Xaux=XtotalQ(Bb,Bin);
Yaux=YtotalQ(Bb,Bin);

%Punto a Cortar
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
Num=rand*Mag;

%Corte de Contorno
[Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xaux,Yaux,Num,Diametro);

%Graficar
plot(Xaux,Yaux,'b','LineWidth',2)
hold on
plot(Xcut,Ycut,'y','LineWidth',2)

%Trayectoria Total
TrayTotalX=Xcut;
TrayTotalY=Ycut;

for iii=1:1

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(XtotalQ(:,Bin));
Xaux=XtotalQ(Bb,Bin);
Yaux=YtotalQ(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

PromPendiente=-(Xin-Xfi)/(Yin-Yfi);

[XcutIn,YcutIn,PosCutA]=nearSlopePoint(Xaux,Yaux,Xin,Yin,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(Xaux,Yaux,Xfi,Yfi,PromPendiente);

%Trayectoria Final
if ((TrayTotalX(1)-XcutFi)^2+(TrayTotalY(1)-YcutFi)^2)<((TrayTotalX(end)-XcutFi)^2+(TrayTotalY(end)-YcutFi)^2)
TrayTotalX=[XcutFi;TrayTotalX;XcutIn];
TrayTotalY=[YcutFi;TrayTotalY;YcutIn];
else
TrayTotalX=[XcutIn;TrayTotalX;XcutFi];
TrayTotalY=[YcutIn;TrayTotalY;YcutFi];
end

%Cortar Contorno en Par de Puntos
[Xcutnn,Ycutnn]=cutContourInPoints(Xaux,Yaux,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi);


%Graficar
scatter(XcutIn,YcutIn,'c')
scatter(XcutFi,YcutFi,'c')
plot(Xaux,Yaux,'b','LineWidth',2)
plot(Xcutnn,Ycutnn,'r','LineWidth',2.5)


%Contorno
Xaux=Xcutnn;
Yaux=Ycutnn;
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
MagAc=[0;cumsum(MagIn)];
Num=rand*(Mag-Diametro);
%Num=mod(iii,2)*(Mag-Diametro)*0.9999999999999;


%Cortar Contorno
[Xcut,Ycut,Xcut2,Ycut2,Xin,Yin,Xfi,Yfi]=cutCurve(Xaux,Yaux,Num,Diametro);


%Trayectoria Total
if Xcut2(1)==TrayTotalX(1) && Ycut2(1)==TrayTotalY(1)
TrayTotalX=[flip(Xcut2(2:end));TrayTotalX;flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));TrayTotalY;flip(Ycut(1:end-1))];
else
if Xcut2(1)==TrayTotalX(end) && Ycut2(1)==TrayTotalY(end)
TrayTotalX=[flip(Xcut2(2:end));flip(TrayTotalX);flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));flip(TrayTotalY);flip(Ycut(1:end-1))];
else
if Xcut2(end)==TrayTotalX(1) && Ycut2(end)==TrayTotalY(1)
TrayTotalX=[Xcut2(1:end-1);TrayTotalX;Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);TrayTotalY;Ycut(2:end)];
else
TrayTotalX=[Xcut2(1:end-1);flip(TrayTotalX);Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);flip(TrayTotalY);Ycut(2:end)];
end
end
end


%Graficar
hold on
plot(Xaux,Yaux,'b','LineWidth',2)
scatter(Xfi,Yfi,'r')
scatter(Xin,Yin,'r')
plot(Xcut,Ycut,'y','LineWidth',2)
plot(Xcut2,Ycut2,'y','LineWidth',2)


end
TrayTotalX5=TrayTotalX;
TrayTotalY5=TrayTotalY;

Diametro=0.4;
Bin=size(XtotalA);
Bin=Bin(2);
Bb=~isnan(XtotalA(:,Bin));
%Contorno
Xaux=XtotalA(Bb,Bin);
Yaux=YtotalA(Bb,Bin);

%Punto a Cortar
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
Num=rand*Mag;

%Corte de Contorno
[Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xaux,Yaux,Num,Diametro);

%Graficar
plot(Xaux,Yaux,'b','LineWidth',2)
hold on
plot(Xcut,Ycut,'y','LineWidth',2)

%Trayectoria Total
TrayTotalX=Xcut;
TrayTotalY=Ycut;

for iii=1:1

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(XtotalA(:,Bin));
Xaux=XtotalA(Bb,Bin);
Yaux=YtotalA(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

PromPendiente=-(Xin-Xfi)/(Yin-Yfi);

[XcutIn,YcutIn,PosCutA]=nearSlopePoint(Xaux,Yaux,Xin,Yin,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(Xaux,Yaux,Xfi,Yfi,PromPendiente);

%Trayectoria Final
if ((TrayTotalX(1)-XcutFi)^2+(TrayTotalY(1)-YcutFi)^2)<((TrayTotalX(end)-XcutFi)^2+(TrayTotalY(end)-YcutFi)^2)
TrayTotalX=[XcutFi;TrayTotalX;XcutIn];
TrayTotalY=[YcutFi;TrayTotalY;YcutIn];
else
TrayTotalX=[XcutIn;TrayTotalX;XcutFi];
TrayTotalY=[YcutIn;TrayTotalY;YcutFi];
end

%Cortar Contorno en Par de Puntos
[Xcutnn,Ycutnn]=cutContourInPoints(Xaux,Yaux,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi);


%Graficar
scatter(XcutIn,YcutIn,'c')
scatter(XcutFi,YcutFi,'c')
plot(Xaux,Yaux,'b','LineWidth',2)
plot(Xcutnn,Ycutnn,'r','LineWidth',2.5)


%Contorno
Xaux=Xcutnn;
Yaux=Ycutnn;
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
MagAc=[0;cumsum(MagIn)];
Num=rand*(Mag-Diametro);
%Num=mod(iii,2)*(Mag-Diametro)*0.9999999999999;
%if iii==4
    
%end

%Cortar Contorno
[Xcut,Ycut,Xcut2,Ycut2,Xin,Yin,Xfi,Yfi]=cutCurve(Xaux,Yaux,Num,Diametro);


%Trayectoria Total
if Xcut2(1)==TrayTotalX(1) && Ycut2(1)==TrayTotalY(1)
TrayTotalX=[flip(Xcut2(2:end));TrayTotalX;flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));TrayTotalY;flip(Ycut(1:end-1))];
else
if Xcut2(1)==TrayTotalX(end) && Ycut2(1)==TrayTotalY(end)
TrayTotalX=[flip(Xcut2(2:end));flip(TrayTotalX);flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));flip(TrayTotalY);flip(Ycut(1:end-1))];
else
if Xcut2(end)==TrayTotalX(1) && Ycut2(end)==TrayTotalY(1)
TrayTotalX=[Xcut2(1:end-1);TrayTotalX;Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);TrayTotalY;Ycut(2:end)];
else
TrayTotalX=[Xcut2(1:end-1);flip(TrayTotalX);Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);flip(TrayTotalY);Ycut(2:end)];
end
end
end


%Graficar
hold on
plot(Xaux,Yaux,'b','LineWidth',2)
scatter(Xfi,Yfi,'r')
scatter(Xin,Yin,'r')
plot(Xcut,Ycut,'y','LineWidth',2)
plot(Xcut2,Ycut2,'y','LineWidth',2)


end

%Buscar Siguiente Capa
Bin=size(XtotalB);
Bin=Bin(2)+1;

for iii=1:2

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(XtotalB(:,Bin));
Xaux=XtotalB(Bb,Bin);
Yaux=YtotalB(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

PromPendiente=-(Xin-Xfi)/(Yin-Yfi);

[XcutIn,YcutIn,PosCutA]=nearSlopePoint(Xaux,Yaux,Xin,Yin,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(Xaux,Yaux,Xfi,Yfi,PromPendiente);

%Trayectoria Final
if ((TrayTotalX(1)-XcutFi)^2+(TrayTotalY(1)-YcutFi)^2)<((TrayTotalX(end)-XcutFi)^2+(TrayTotalY(end)-YcutFi)^2)
TrayTotalX=[XcutFi;TrayTotalX;XcutIn];
TrayTotalY=[YcutFi;TrayTotalY;YcutIn];
else
TrayTotalX=[XcutIn;TrayTotalX;XcutFi];
TrayTotalY=[YcutIn;TrayTotalY;YcutFi];
end

%Cortar Contorno en Par de Puntos
[Xcutnn,Ycutnn]=cutContourInPoints(Xaux,Yaux,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi);


%Graficar
scatter(XcutIn,YcutIn,'c')
scatter(XcutFi,YcutFi,'c')
plot(Xaux,Yaux,'b','LineWidth',2)
plot(Xcutnn,Ycutnn,'r','LineWidth',2.5)


%Contorno
Xaux=Xcutnn;
Yaux=Ycutnn;
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
MagAc=[0;cumsum(MagIn)];
Num=rand*(Mag-Diametro);
%Num=mod(iii,2)*(Mag-Diametro)*0.9999999999999;


%Cortar Contorno
[Xcut,Ycut,Xcut2,Ycut2,Xin,Yin,Xfi,Yfi]=cutCurve(Xaux,Yaux,Num,Diametro);


%Trayectoria Total
if Xcut2(1)==TrayTotalX(1) && Ycut2(1)==TrayTotalY(1)
TrayTotalX=[flip(Xcut2(2:end));TrayTotalX;flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));TrayTotalY;flip(Ycut(1:end-1))];
else
if Xcut2(1)==TrayTotalX(end) && Ycut2(1)==TrayTotalY(end)
TrayTotalX=[flip(Xcut2(2:end));flip(TrayTotalX);flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));flip(TrayTotalY);flip(Ycut(1:end-1))];
else
if Xcut2(end)==TrayTotalX(1) && Ycut2(end)==TrayTotalY(1)
TrayTotalX=[Xcut2(1:end-1);TrayTotalX;Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);TrayTotalY;Ycut(2:end)];
else
TrayTotalX=[Xcut2(1:end-1);flip(TrayTotalX);Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);flip(TrayTotalY);Ycut(2:end)];
end
end
end
%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

PromPendiente=-(Xin-Xfi)/(Yin-Yfi);

[XcutIn,YcutIn,PosCutA]=nearSlopePoint(Xaux,Yaux,Xin,Yin,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(Xaux,Yaux,Xfi,Yfi,PromPendiente);

%Graficar
hold on
plot(Xaux,Yaux,'b','LineWidth',2)
scatter(Xfi,Yfi,'r')
scatter(Xin,Yin,'r')
plot(Xcut,Ycut,'y','LineWidth',2)
plot(Xcut2,Ycut2,'y','LineWidth',2)


end


%Graficar Trayectoria Total
figure
%plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
%hold on
%plot(TrayTotalX2,TrayTotalY2,'g','LineWidth',1.5)
Xinn=TrayTotalX2(1);
Yinn=TrayTotalY2(1);
Xfin=TrayTotalX2(end);
Yfin=TrayTotalY2(end);
%scatter(Xinn,Yinn,'r')
%scatter(Xfin,Yfin,'k')

PromPendiente=-(Xinn-Xfin)/(Yinn-Yfin);

[XcutIn,YcutIn,PosCutA]=nearSlopePoint(TrayTotalX,TrayTotalY,Xinn,Yinn,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(TrayTotalX,TrayTotalY,Xfin,Yfin,PromPendiente);

%scatter(XcutIn,YcutIn,'b')
%scatter(XcutFi,YcutFi,'y')

%Cortar Contorno en Par de Puntos
[Xcutnn,Ycutnn,Xcutnn2,Ycutnn2]=cutTrayInPoints(TrayTotalX,TrayTotalY,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi);
%plot(Xcutnn,Ycutnn,'k','LineWidth',1.2)
%plot(Xcutnn2,Ycutnn2,'k','LineWidth',1.2)

if ((Xcutnn(1)-TrayTotalX2(1))^2+(Ycutnn(1)-TrayTotalY2(1))^2)>((Xcutnn(1)-TrayTotalX2(end))^2+(Ycutnn(1)-TrayTotalY2(end))^2)
XTrayTotal=[Xcutnn2;TrayTotalX2;Xcutnn];
YTrayTotal=[Ycutnn2;TrayTotalY2;Ycutnn];
else
XTrayTotal=[Xcutnn2;flip(TrayTotalX2);Xcutnn];
YTrayTotal=[Ycutnn2;flip(TrayTotalY2);Ycutnn];
end

TrayTotalX=XTrayTotal;
TrayTotalY=YTrayTotal;

Xinn=TrayTotalX3(1);
Yinn=TrayTotalY3(1);
Xfin=TrayTotalX3(end);
Yfin=TrayTotalY3(end);
%scatter(Xinn,Yinn,'r')
%scatter(Xfin,Yfin,'k')

PromPendiente=-(Xinn-Xfin)/(Yinn-Yfin);

[XcutIn,YcutIn,PosCutA]=nearSlopePoint(TrayTotalX,TrayTotalY,Xinn,Yinn,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(TrayTotalX,TrayTotalY,Xfin,Yfin,PromPendiente);

%scatter(XcutIn,YcutIn,'b')
%scatter(XcutFi,YcutFi,'y')

%Cortar Contorno en Par de Puntos
[Xcutnn,Ycutnn,Xcutnn2,Ycutnn2]=cutTrayInPoints(TrayTotalX,TrayTotalY,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi);
%plot(Xcutnn,Ycutnn,'k','LineWidth',1.2)
%plot(Xcutnn2,Ycutnn2,'k','LineWidth',1.2)

if ((Xcutnn(1)-TrayTotalX3(1))^2+(Ycutnn(1)-TrayTotalY3(1))^2)>((Xcutnn(1)-TrayTotalX3(end))^2+(Ycutnn(1)-TrayTotalY3(end))^2)
XTrayTotal=[Xcutnn2;TrayTotalX3;Xcutnn];
YTrayTotal=[Ycutnn2;TrayTotalY3;Ycutnn];
else
XTrayTotal=[Xcutnn2;flip(TrayTotalX3);Xcutnn];
YTrayTotal=[Ycutnn2;flip(TrayTotalY3);Ycutnn];
end

TrayTotalX=XTrayTotal;
TrayTotalY=YTrayTotal;

Xinn=TrayTotalX4(1);
Yinn=TrayTotalY4(1);
Xfin=TrayTotalX4(end);
Yfin=TrayTotalY4(end);
%scatter(Xinn,Yinn,'r')
%scatter(Xfin,Yfin,'k')

%Punto mas cercano In
[XcutIn,YcutIn,PosCutA]=nearPoint(TrayTotalX,TrayTotalY,Xinn,Yinn);

%Punto mas cercano Fi
[XcutFi,YcutFi,PosCutB]=nearPoint(TrayTotalX,TrayTotalY,Xfin,Yfin);

%scatter(XcutIn,YcutIn,'b')
%scatter(XcutFi,YcutFi,'y')

%Cortar Contorno en Par de Puntos
[Xcutnn,Ycutnn,Xcutnn2,Ycutnn2]=cutTrayInPoints(TrayTotalX,TrayTotalY,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi);
%plot(Xcutnn,Ycutnn,'k','LineWidth',1.2)
%plot(Xcutnn2,Ycutnn2,'k','LineWidth',1.2)

if ((Xcutnn(1)-TrayTotalX4(1))^2+(Ycutnn(1)-TrayTotalY4(1))^2)>((Xcutnn(1)-TrayTotalX4(end))^2+(Ycutnn(1)-TrayTotalY4(end))^2)
XTrayTotal=[Xcutnn2;TrayTotalX4;Xcutnn];
YTrayTotal=[Ycutnn2;TrayTotalY4;Ycutnn];
else
XTrayTotal=[Xcutnn2;flip(TrayTotalX4);Xcutnn];
YTrayTotal=[Ycutnn2;flip(TrayTotalY4);Ycutnn];
end

TrayTotalX=XTrayTotal;
TrayTotalY=YTrayTotal;

Xinn=TrayTotalX5(1);
Yinn=TrayTotalY5(1);
Xfin=TrayTotalX5(end);
Yfin=TrayTotalY5(end);
%scatter(Xinn,Yinn,'r')
%scatter(Xfin,Yfin,'k')


%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

PromPendiente=-(Xinn-Xfin)/(Yinn-Yfin);

[XcutIn,YcutIn,PosCutA]=nearSlopePoint(TrayTotalX,TrayTotalY,Xinn,Yinn,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(TrayTotalX,TrayTotalY,Xfin,Yfin,PromPendiente);

%scatter(XcutIn,YcutIn,'b')
%scatter(XcutFi,YcutFi,'y')

%Cortar Contorno en Par de Puntos
[Xcutnn,Ycutnn,Xcutnn2,Ycutnn2]=cutTrayInPoints(TrayTotalX,TrayTotalY,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi);
%plot(Xcutnn,Ycutnn,'k','LineWidth',1.2)
%plot(Xcutnn2,Ycutnn2,'k','LineWidth',1.2)

if ((Xcutnn(1)-TrayTotalX5(1))^2+(Ycutnn(1)-TrayTotalY5(1))^2)>((Xcutnn(1)-TrayTotalX5(end))^2+(Ycutnn(1)-TrayTotalY5(end))^2)
XTrayTotal=[Xcutnn2;TrayTotalX5;Xcutnn;Xcutnn2(1)];
YTrayTotal=[Ycutnn2;TrayTotalY5;Ycutnn;Ycutnn2(1)];
else
XTrayTotal=[Xcutnn2;flip(TrayTotalX5);Xcutnn;Xcutnn2(1)];
YTrayTotal=[Ycutnn2;flip(TrayTotalY5);Ycutnn;Ycutnn2(1)];
end

%Graficar Trayectoria Total
TrayTotalX=XTrayTotal;
TrayTotalY=YTrayTotal;

end