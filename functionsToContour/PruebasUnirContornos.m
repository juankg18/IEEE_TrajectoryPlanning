%% PRUEBAS UNIR CONTORNOS
close all
clc

Centrado=0;
Exacto=0;
Diametro=0.4;
Gyro=0;

Ext=[Externo(:,1:2);Externo(1,1:2)];
%Ext=[InternoA(:,1:2);InternoA(1,1:2)];
Exti=Ext;
%Centrar Pieza
Centro=max(Ext)/2;

Referencia=min(Ext);
Ext=Ext-Centro;
IntA=[InternoA(:,1:2);InternoA(1,1:2)]-Centro;
IntB=[InternoB(:,1:2);InternoB(1,1:2)]-Centro;
Ext=[cos(Gyro) -sin(Gyro);sin(Gyro) cos(Gyro)]*Ext(:,1:2)';
if Centrado == 1
    Tr=0;
else
    Tr=min(Ext');
end
Ext=Ext'-Tr;
IntA=[cos(Gyro) -sin(Gyro);sin(Gyro) cos(Gyro)]*IntA(:,1:2)';
IntA=IntA'-Tr;
IntB=[cos(Gyro) -sin(Gyro);sin(Gyro) cos(Gyro)]*IntB(:,1:2)';
IntB=IntB'-Tr;
figure
plot(Ext(:,1), Ext(:,2),'r')
hold on
plot(IntA(:,1), IntA(:,2),'b')
hold on
plot(IntB(:,1), IntB(:,2),'b')
%% Ciclo de contornos
Espacio = 0.01;
Spe = 1;
Xentrada=Ext(:,1);
Yentrada=Ext(:,2);
%Xentrada=[0;0;300;300;0;0;600;600;0]/20;
%Yentrada=[0;100;100;200;200;300;300;0;0]/20;
newflag=1;
clear Xtotal
clear Ytotal
figure;
plot(Xentrada, Yentrada, 'b');
Xtotal=[];
Ytotal=[];
hold on;
for i=1:54
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    Xtotal(:,i)=NaN;
    Ytotal(:,i)=NaN;
    Xtotal(1:length(Xentrada),i)=Xentrada';
    Ytotal(1:length(Yentrada),i)=Yentrada';
    if i==1
        Tab=length(Xentrada);
    end
    newflag=0;
end
Xtotal=Xtotal(1:Tab,:);
Ytotal=Ytotal(1:Tab,:);
plot(Xtotal,Ytotal)
%% Ciclo de contornos
Espacio = 0.01;
Spe = 1;
Xentrada=IntA(:,1);
Yentrada=IntA(:,2);
newflag=1;
clear Xtotal
clear Ytotal
figure;
plot(Xentrada, Yentrada, 'b');
Xtotal=[];
Ytotal=[];
hold on;
for i=1:30
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    Xtotal(:,i)=NaN;
    Ytotal(:,i)=NaN;
    Xtotal(1:length(Xentrada),i)=Xentrada';
    Ytotal(1:length(Yentrada),i)=Yentrada';
    if i==1
        Tab=length(Xentrada);
    end
    newflag=0;
end
Xtotal=Xtotal(1:Tab,:);
Ytotal=Ytotal(1:Tab,:);
plot(Xtotal,Ytotal)
%% Unir contornos B
Espacio = 0.01;
Spe = 1;
Xentrada=Ext(:,1);
Yentrada=Ext(:,2);
XentradaA=IntB(:,1);
YentradaA=IntB(:,2);
newflag=1;
clear Xtotal
clear Ytotal
clear XtotalA
clear YtotalA
clear XtotalB
clear YtotalB
figure;
plot(Xentrada, Yentrada, 'b');
hold on;
plot(XentradaA, YentradaA, 'g');
Xtotal=[];
Ytotal=[];
XtotalA=[];
YtotalA=[];
XtotalB=[];
YtotalB=[];
hold on;
Die=0;
KL=true;
for i=1:43
%for i=1:5
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    if Die == 0
    [XsampA,YsampA]=resampleborder(XentradaA,YentradaA,Espacio);
    [x_innerA, y_innerA, x_outerA, y_outerA, R, unv, concavity, overlap]=parallel_curvepamejor(XsampA, YsampA, Spe/(newflag+1), 0, 0,newflag);
    [Boolt,x_innerOut,y_innerOut,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerA(1,:),y_outerA(1,:));
    end
    if Boolt==1
        x_inner=x_innerOut;
        y_inner=y_innerOut;
        x_outerA=[];
        y_outerA=[];
        Die=1;
        Boolt=0;
    end
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if Die == 0
    XentradaA=x_outerA(1,:);
    YentradaA=y_outerA(1,:);
    TaA=size(XtotalA);
    SaA=length(XentradaA);
    if SaA(1)>TaA
    XtotalA(TaA+1:SaA,1:i)=NaN;
    YtotalA(TaA+1:SaA,1:i)=NaN;
    else
    XtotalA(:,i)=NaN;
    YtotalA(:,i)=NaN;
    end
    XtotalA(1:length(XentradaA),i)=XentradaA';
    YtotalA(1:length(YentradaA),i)=YentradaA';
    TaB=size(XtotalB);
    SaB=length(Xentrada);
    if SaB(1)>TaB
    XtotalB(TaB+1:SaB,1:i)=NaN;
    YtotalB(TaB+1:SaB,1:i)=NaN;
    else
    XtotalB(:,i)=NaN;
    YtotalB(:,i)=NaN;
    end
    XtotalB(1:length(Xentrada),i)=Xentrada';
    YtotalB(1:length(Yentrada),i)=Yentrada';
    else
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(Xtotal);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    Xtotal(Ta+1:Sa,1:i-pon)=NaN;
    Ytotal(Ta+1:Sa,1:i-pon)=NaN;
    else
    Xtotal(:,i-pon)=NaN;
    Ytotal(:,i-pon)=NaN;
    end
    Xtotal(1:length(Xentrada),i-pon)=Xentrada';
    Ytotal(1:length(Yentrada),i-pon)=Yentrada';
    end
    %if i==1
    %    Tab=length(Xentrada);
    %end
    newflag=0;
    pause(0.01)
    disp(i)
end
%Xtotal=Xtotal(1:Tab,:);
%Ytotal=Ytotal(1:Tab,:);
plot(Xtotal,Ytotal)
XtotalA=flip(XtotalA,2);
YtotalA=flip(YtotalA,2);
plot(XtotalA,YtotalA)
plot(XtotalB,YtotalB)
%% Unir contornos A
Espacio = 0.01;
Spe = 1;
Xentrada=Ext(:,1);
Yentrada=Ext(:,2);
XentradaA=IntA(:,1);
YentradaA=IntA(:,2);
newflag=1;
clear Xtotal
clear Ytotal
clear XtotalA
clear YtotalA
clear XtotalB
clear YtotalB
figure;
plot(Xentrada, Yentrada, 'b');
hold on;
plot(XentradaA, YentradaA, 'g');
Xtotal=[];
Ytotal=[];
XtotalA=[];
YtotalA=[];
XtotalB=[];
YtotalB=[];
hold on;
Die=0;
KL=true;
for i=1:5
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    if Die == 0
    [XsampA,YsampA]=resampleborder(XentradaA,YentradaA,Espacio);
    [x_innerA, y_innerA, x_outerA, y_outerA, R, unv, concavity, overlap]=parallel_curvepamejor(XsampA, YsampA, Spe/(newflag+1), 0, 0,newflag);
    [Boolt,x_innerOut,y_innerOut,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerA(1,:),y_outerA(1,:));
    end
    if Boolt==1
        x_inner=x_innerOut;
        y_inner=y_innerOut;
        x_outerA=[];
        y_outerA=[];
        Die=1;
        Boolt=0;
    end
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if Die == 0
    XentradaA=x_outerA(1,:);
    YentradaA=y_outerA(1,:);
    TaA=size(XtotalA);
    SaA=length(XentradaA);
    if SaA(1)>TaA
    XtotalA(TaA+1:SaA,1:i)=NaN;
    YtotalA(TaA+1:SaA,1:i)=NaN;
    else
    XtotalA(:,i)=NaN;
    YtotalA(:,i)=NaN;
    end
    XtotalA(1:length(XentradaA),i)=XentradaA';
    YtotalA(1:length(YentradaA),i)=YentradaA';
    TaB=size(XtotalB);
    SaB=length(Xentrada);
    if SaB(1)>TaB
    XtotalB(TaB+1:SaB,1:i)=NaN;
    YtotalB(TaB+1:SaB,1:i)=NaN;
    else
    XtotalB(:,i)=NaN;
    YtotalB(:,i)=NaN;
    end
    XtotalB(1:length(Xentrada),i)=Xentrada';
    YtotalB(1:length(Yentrada),i)=Yentrada';
    else
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(Xtotal);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    Xtotal(Ta+1:Sa,1:i-pon)=NaN;
    Ytotal(Ta+1:Sa,1:i-pon)=NaN;
    else
    Xtotal(:,i-pon)=NaN;
    Ytotal(:,i-pon)=NaN;
    end
    Xtotal(1:length(Xentrada),i-pon)=Xentrada';
    Ytotal(1:length(Yentrada),i-pon)=Yentrada';
    end
    newflag=0;
    pause(0.01)
    disp(i)
end
plot(Xtotal,Ytotal)
XtotalA=flip(XtotalA,2);
YtotalA=flip(YtotalA,2);
plot(XtotalA,YtotalA)
plot(XtotalB,YtotalB)

clear XtotalC
clear YtotalC
clear XtotalD
clear YtotalD
XtotalC=[];
YtotalC=[];
XtotalD=[];
YtotalD=[];

[Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
[x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
Xentrada=x_inner(1,:);
Yentrada=y_inner(1,:);


Ta=size(XtotalC);
Sa=length(Xentrada);
if Sa(1)>Ta
XtotalC(Ta+1:Sa,1:i-pon)=NaN;
YtotalC(Ta+1:Sa,1:i-pon)=NaN;
else
XtotalC(:,i-pon)=NaN;
YtotalC(:,i-pon)=NaN;
end
XtotalC(1:length(Xentrada),i-pon)=Xentrada';
YtotalC(1:length(Yentrada),i-pon)=Yentrada';


x_innerP=x_inner;
y_innerP=y_inner;
XentradaB=x_innerP(2,:);
YentradaB=y_innerP(2,:);
for i=1:3
    [Xsamp,Ysamp]=resampleborder(XentradaB,YentradaB,Espacio);
    [x_innerP, y_innerP, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_innerP(1,:)', y_innerP(1,:)');
    XentradaB=x_innerP(1,:);
    YentradaB=y_innerP(1,:);
    newflag=0;
    pause(0.01)
end
%% Comienzo de Random
figure
Diametro=1;
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

for iii=1:29

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(Xtotal(:,Bin));
Xaux=Xtotal(Bb,Bin);
Yaux=Ytotal(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

%Punto mas cercano In
[XcutIn,YcutIn,PosCutA]=nearPoint(Xaux,Yaux,Xin,Yin);

%Punto mas cercano Fi
[XcutFi,YcutFi,PosCutB]=nearPoint(Xaux,Yaux,Xfi,Yfi);

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


%Graficar Trayectoria Total
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
%% Comienzo de Random
Diametro=1;
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

for iii=1:37

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(Xtotal(:,Bin));
Xaux=Xtotal(Bb,Bin);
Yaux=Ytotal(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

%Punto mas cercano In
[XcutIn,YcutIn,PosCutA]=nearPoint(Xaux,Yaux,Xin,Yin);

%Punto mas cercano Fi
[XcutFi,YcutFi,PosCutB]=nearPoint(Xaux,Yaux,Xfi,Yfi);

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

Diametro=1;
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

for iii=1:4

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(XtotalA(:,Bin));
Xaux=XtotalA(Bb,Bin);
Yaux=YtotalA(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

%Punto mas cercano In
[XcutIn,YcutIn,PosCutA]=nearPoint(Xaux,Yaux,Xin,Yin);

%Punto mas cercano Fi
[XcutFi,YcutFi,PosCutB]=nearPoint(Xaux,Yaux,Xfi,Yfi);

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

for iii=1:5

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(XtotalB(:,Bin));
Xaux=XtotalB(Bb,Bin);
Yaux=YtotalB(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

%Punto mas cercano In
[XcutIn,YcutIn,PosCutA]=nearPoint(Xaux,Yaux,Xin,Yin);

%Punto mas cercano Fi
[XcutFi,YcutFi,PosCutB]=nearPoint(Xaux,Yaux,Xfi,Yfi);

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

if ((Xcutnn(1)-TrayTotalX2(1))^2+(Ycutnn(1)-TrayTotalY2(1))^2)>((Xcutnn(1)-TrayTotalX2(end))^2+(Ycutnn(1)-TrayTotalY2(end))^2)
XTrayTotal=[Xcutnn2;TrayTotalX2;Xcutnn];
YTrayTotal=[Ycutnn2;TrayTotalY2;Ycutnn];
else
XTrayTotal=[Xcutnn2;flip(TrayTotalX2);Xcutnn];
YTrayTotal=[Ycutnn2;flip(TrayTotalY2);Ycutnn];
end

plot(XTrayTotal,YTrayTotal,'g','LineWidth',1)
%% Comienzo de Random Otra Isla
Diametro=1;
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

for iii=1:37

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(Xtotal(:,Bin));
Xaux=Xtotal(Bb,Bin);
Yaux=Ytotal(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

%Punto mas cercano In
[XcutIn,YcutIn,PosCutA]=nearPoint(Xaux,Yaux,Xin,Yin);

%Punto mas cercano Fi
[XcutFi,YcutFi,PosCutB]=nearPoint(Xaux,Yaux,Xfi,Yfi);

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

Diametro=1;
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

for iii=1:4

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(XtotalA(:,Bin));
Xaux=XtotalA(Bb,Bin);
Yaux=YtotalA(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

%Punto mas cercano In
[XcutIn,YcutIn,PosCutA]=nearPoint(Xaux,Yaux,Xin,Yin);

%Punto mas cercano Fi
[XcutFi,YcutFi,PosCutB]=nearPoint(Xaux,Yaux,Xfi,Yfi);

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

for iii=1:5

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(XtotalB(:,Bin));
Xaux=XtotalB(Bb,Bin);
Yaux=YtotalB(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

%Punto mas cercano In
[XcutIn,YcutIn,PosCutA]=nearPoint(Xaux,Yaux,Xin,Yin);

%Punto mas cercano Fi
[XcutFi,YcutFi,PosCutB]=nearPoint(Xaux,Yaux,Xfi,Yfi);

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

if ((Xcutnn(1)-TrayTotalX2(1))^2+(Ycutnn(1)-TrayTotalY2(1))^2)>((Xcutnn(1)-TrayTotalX2(end))^2+(Ycutnn(1)-TrayTotalY2(end))^2)
XTrayTotal=[Xcutnn2;TrayTotalX2;Xcutnn];
YTrayTotal=[Ycutnn2;TrayTotalY2;Ycutnn];
else
XTrayTotal=[Xcutnn2;flip(TrayTotalX2);Xcutnn];
YTrayTotal=[Ycutnn2;flip(TrayTotalY2);Ycutnn];
end

plot(XTrayTotal,YTrayTotal,'g','LineWidth',1)