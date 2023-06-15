%% Pieza
% Ir a C:\Users\ASUS\Desktop\Maestria\ContornosPar
%close all
clc
load('Contour.mat')
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
Spe = 0.4;
Xentrada=(IntA(:,1)-4)*6.4/60;
Yentrada=(IntA(:,2)-38)*6.4/60;
newflag=1;
clear Xtotal
clear Ytotal
figure;
plot(Xentrada, Yentrada, 'b');
Xtotal=[];
Ytotal=[];
hold on;
for i=1:8
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
Spe = 0.4;
IntA=[[0 6.4 6.4 0 0]' [0 0 6.4 6.4 0]']
Xentrada=(IntA(:,1));
Yentrada=(IntA(:,2));
newflag=1;
clear Xtotal
clear Ytotal
figure;
plot(Xentrada, Yentrada, 'b');
Xtotal=[];
Ytotal=[];
hold on;
for i=1:8
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
%% Prueba contornos
Espacio = 0.01;
Spe = 0.4;
XentradaA=(IntA(:,1)-4)*6.4/60+3.2;
YentradaA=(IntA(:,2)-38)*6.4/60+3.2;
Xentrada=[1 1 -1 -1 1]'*3.2*2+3.2*2;
Yentrada=[1 -1 -1 1 1]'*3.2*2+3.2*2;
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
XtotalQ=[];
YtotalQ=[];
XtotalW=[];
YtotalW=[];
XtotalE=[];
YtotalE=[];
XtotalA=[];
YtotalA=[];
XtotalB=[];
YtotalB=[];
hold on;
Die=0;
KL=true;
for i=1:4
%for i=1:5
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    if Die == 0
    [XsampA,YsampA]=resampleborder(XentradaA,YentradaA,Espacio);
    [x_innerA, y_innerA, x_outerA, y_outerA, R, unv, concavity, overlap]=parallel_curvepamejor(XsampA, YsampA, Spe/(newflag+1), 0, 0,newflag);
    [Boolt,x_innerOut,y_innerOut,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerA(1,:),y_outerA(1,:),1);
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

    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    [XsampA,YsampA]=resampleborder(XentradaA,YentradaA,Espacio);
    [x_innerA, y_innerA, x_outerA, y_outerA, R, unv, concavity, overlap]=parallel_curvepamejor(XsampA, YsampA, Spe/(newflag+1), 0, 0,newflag);
    [Boolt,x_innerOutA,y_innerOutA,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerA(1,:),y_outerA(1,:),2);
    [Boolt,x_innerOutB,y_innerOutB,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerA(1,:),y_outerA(1,:),4);
    [Boolt,x_innerOutC,y_innerOutC,x_outerAOut,y_outerAOut]=combinecurves([x_inner(1,2:end-1) x_inner(1,1:2)],[y_inner(1,2:end-1) y_inner(1,1:2)],[x_outerA(1,7:end-1) x_outerA(1,1:7)],[y_outerA(1,7:end-1) y_outerA(1,1:7)],6);
    [Boolt,x_innerOutD,y_innerOutD,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),[x_outerA(1,500:end-1) x_outerA(1,1:500)],[y_outerA(1,500:end-1) y_outerA(1,1:500)],6);
    %[Boolt,x_innerOutA,y_innerOutA,x_outerAOut,y_outerAOut]=combinecurves([x_inner(1,2:end-1) x_inner(1,1:2)],[y_inner(1,2:end-1) y_inner(1,1:2)],[x_outerA(1,7:end-1) x_outerA(1,1:7)],[y_outerA(1,7:end-1) y_outerA(1,1:7)],6);
    %[Boolt,x_innerOutA,y_innerOutA,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),[x_outerA(1,500:end-1) x_outerA(1,1:500)],[y_outerA(1,500:end-1) y_outerA(1,1:500)],6);

        x_inner=x_innerOutB;
        y_inner=y_innerOutB;

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalQ);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalQ(Ta+1:Sa,1:i-pon)=NaN;
    YtotalQ(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalQ(:,i-pon)=NaN;
    YtotalQ(:,i-pon)=NaN;
    end
    XtotalQ(1:length(Xentrada),i-pon)=Xentrada';
    YtotalQ(1:length(Yentrada),i-pon)=Yentrada';
    
    XentradaQ=Xentrada;
    YentradaQ=Yentrada;
    
        x_inner=x_innerOutC;
        y_inner=y_innerOutC;

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalW);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalW(Ta+1:Sa,1:i-pon)=NaN;
    YtotalW(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalW(:,i-pon)=NaN;
    YtotalW(:,i-pon)=NaN;
    end
    XtotalW(1:length(Xentrada),i-pon)=Xentrada';
    YtotalW(1:length(Yentrada),i-pon)=Yentrada';
    
    XentradaW=Xentrada;
    YentradaW=Yentrada;
    
        x_inner=x_innerOutD;
        y_inner=y_innerOutD;

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalE);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalE(Ta+1:Sa,1:i-pon)=NaN;
    YtotalE(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalE(:,i-pon)=NaN;
    YtotalE(:,i-pon)=NaN;
    end
    XtotalE(1:length(Xentrada),i-pon)=Xentrada';
    YtotalE(1:length(Yentrada),i-pon)=Yentrada';
    
    XentradaE=Xentrada;
    YentradaE=Yentrada;
    
        x_inner=x_innerOutA;
        y_inner=y_innerOutA;

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
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
    
    i=i+1;
    
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);

    Xentrada=x_inner(3,:);
    Yentrada=y_inner(3,:);
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
    
    
    
    [Xsamp,Ysamp]=resampleborder(XentradaQ,YentradaQ,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);

    Xentrada=x_inner(3,:);
    Yentrada=y_inner(3,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalQ);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalQ(Ta+1:Sa,1:i-pon)=NaN;
    YtotalQ(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalQ(:,i-pon)=NaN;
    YtotalQ(:,i-pon)=NaN;
    end
    XtotalQ(1:length(Xentrada),i-pon)=Xentrada';
    YtotalQ(1:length(Yentrada),i-pon)=Yentrada';
    
    
    [Xsamp,Ysamp]=resampleborder(XentradaW,YentradaW,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);

    Xentrada=x_inner(3,:);
    Yentrada=y_inner(3,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalW);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalW(Ta+1:Sa,1:i-pon)=NaN;
    YtotalW(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalW(:,i-pon)=NaN;
    YtotalW(:,i-pon)=NaN;
    end
    XtotalW(1:length(Xentrada),i-pon)=Xentrada';
    YtotalW(1:length(Yentrada),i-pon)=Yentrada';
    
    
    [Xsamp,Ysamp]=resampleborder(XentradaE,YentradaE,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);

    Xentrada=x_inner(3,:);
    Yentrada=y_inner(3,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalE);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalE(Ta+1:Sa,1:i-pon)=NaN;
    YtotalE(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalE(:,i-pon)=NaN;
    YtotalE(:,i-pon)=NaN;
    end
    XtotalE(1:length(Xentrada),i-pon)=Xentrada';
    YtotalE(1:length(Yentrada),i-pon)=Yentrada';
    
    
% Xtotal=Xtotal(1:Tab,:);
% Ytotal=Ytotal(1:Tab,:);
plot(Xtotal,Ytotal)
plot(XtotalQ,YtotalQ)
plot(XtotalW,YtotalW)
plot(XtotalE,YtotalE)
XtotalA=flip(XtotalA,2);
YtotalA=flip(YtotalA,2);
plot(XtotalA,YtotalA)
plot(XtotalB,YtotalB)
XaUXa=XtotalA;
XtotalA=Xtotal;
Xtotal=XaUXa;
XaUXa=YtotalA;
YtotalA=Ytotal;
Ytotal=XaUXa;
%% Prueba contornos
Espacio = 0.01;
Spe = 0.4;
Xentrada=(IntA(:,1)-4)*6.4*2/60;
Yentrada=(IntA(:,2)-38)*6.4*2/60;
XentradaA=[1 1 -1 -1 1]'*3.2+3.2*2;
YentradaA=[1 -1 -1 1 1]'*3.2+3.2*2;
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
XtotalQ=[];
YtotalQ=[];
XtotalW=[];
YtotalW=[];
XtotalE=[];
YtotalE=[];
XtotalA=[];
YtotalA=[];
XtotalB=[];
YtotalB=[];
hold on;
Die=0;
KL=true;
for i=1:2
%for i=1:5
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    if Die == 0
    [XsampA,YsampA]=resampleborder(XentradaA,YentradaA,Espacio);
    [x_innerA, y_innerA, x_outerA, y_outerA, R, unv, concavity, overlap]=parallel_curvepamejor(XsampA, YsampA, Spe/(newflag+1), 0, 0,newflag);
    [Boolt,x_innerOut,y_innerOut,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerA(1,:),y_outerA(1,:),1);
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

    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    [XsampA,YsampA]=resampleborder(XentradaA,YentradaA,Espacio);
    [x_innerA, y_innerA, x_outerA, y_outerA, R, unv, concavity, overlap]=parallel_curvepamejor(XsampA, YsampA, Spe/(newflag+1), 0, 0,newflag);
    [Boolt,x_innerOutA,y_innerOutA,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerA(1,:),y_outerA(1,:),1);
    [Boolt,x_innerOutB,y_innerOutB,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerA(1,:),y_outerA(1,:),3);
    [Boolt,x_innerOutC,y_innerOutC,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerA(1,:),y_outerA(1,:),5);
    [Boolt,x_innerOutD,y_innerOutD,x_outerAOut,y_outerAOut]=combinecurves([x_inner(1,5:end-1) x_inner(1,1:5)],[y_inner(1,5:end-1) y_inner(1,1:5)],x_outerA(1,:),y_outerA(1,:),7);
    
        x_inner=x_innerOutB;
        y_inner=y_innerOutB;

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalQ);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalQ(Ta+1:Sa,1:i-pon)=NaN;
    YtotalQ(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalQ(:,i-pon)=NaN;
    YtotalQ(:,i-pon)=NaN;
    end
    XtotalQ(1:length(Xentrada),i-pon)=Xentrada';
    YtotalQ(1:length(Yentrada),i-pon)=Yentrada';
    
    XentradaQ=Xentrada;
    YentradaQ=Yentrada;
    
        x_inner=x_innerOutC;
        y_inner=y_innerOutC;

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalW);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalW(Ta+1:Sa,1:i-pon)=NaN;
    YtotalW(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalW(:,i-pon)=NaN;
    YtotalW(:,i-pon)=NaN;
    end
    XtotalW(1:length(Xentrada),i-pon)=Xentrada';
    YtotalW(1:length(Yentrada),i-pon)=Yentrada';
    
    XentradaW=Xentrada;
    YentradaW=Yentrada;
    
        x_inner=x_innerOutD;
        y_inner=y_innerOutD;

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalE);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalE(Ta+1:Sa,1:i-pon)=NaN;
    YtotalE(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalE(:,i-pon)=NaN;
    YtotalE(:,i-pon)=NaN;
    end
    XtotalE(1:length(Xentrada),i-pon)=Xentrada';
    YtotalE(1:length(Yentrada),i-pon)=Yentrada';
    
    XentradaE=Xentrada;
    YentradaE=Yentrada;
    
        x_inner=x_innerOutA;
        y_inner=y_innerOutA;

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
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
    
    i=i+1;
    
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
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
    
    
    
    [Xsamp,Ysamp]=resampleborder(XentradaQ,YentradaQ,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalQ);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalQ(Ta+1:Sa,1:i-pon)=NaN;
    YtotalQ(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalQ(:,i-pon)=NaN;
    YtotalQ(:,i-pon)=NaN;
    end
    XtotalQ(1:length(Xentrada),i-pon)=Xentrada';
    YtotalQ(1:length(Yentrada),i-pon)=Yentrada';
    
    
    [Xsamp,Ysamp]=resampleborder(XentradaW,YentradaW,Espacio);
    [x_inner, y_inner, ~, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalW);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalW(Ta+1:Sa,1:i-pon)=NaN;
    YtotalW(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalW(:,i-pon)=NaN;
    YtotalW(:,i-pon)=NaN;
    end
    XtotalW(1:length(Xentrada),i-pon)=Xentrada';
    YtotalW(1:length(Yentrada),i-pon)=Yentrada';
    
    
    [Xsamp,Ysamp]=resampleborder(XentradaE,YentradaE,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);

    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if KL
        pon=i-1;
        KL=false;
    end
    Ta=size(XtotalE);
    Sa=length(Xentrada);
    if Sa(1)>Ta
    XtotalE(Ta+1:Sa,1:i-pon)=NaN;
    YtotalE(Ta+1:Sa,1:i-pon)=NaN;
    else
    XtotalE(:,i-pon)=NaN;
    YtotalE(:,i-pon)=NaN;
    end
    XtotalE(1:length(Xentrada),i-pon)=Xentrada';
    YtotalE(1:length(Yentrada),i-pon)=Yentrada';
    
    
%Xtotal=Xtotal(1:Tab,:);
%Ytotal=Ytotal(1:Tab,:);
plot(Xtotal,Ytotal)
plot(XtotalQ,YtotalQ)
plot(XtotalW,YtotalW)
plot(XtotalE,YtotalE)
XtotalA=flip(XtotalA,2);
YtotalA=flip(YtotalA,2);
plot(XtotalA,YtotalA)
plot(XtotalB,YtotalB)
XaUXa=XtotalA;
XtotalA=Xtotal;
Xtotal=XaUXa;
XaUXa=YtotalA;
YtotalA=Ytotal;
Ytotal=XaUXa;
%% Ciclo de contornos Nivel
Espacio = 0.01;
Spe = 0.4;
Dime=12;
IntA=[[-1 1 1 -1 -1]' [-1 -1 1 1 -1]']*Dime/2+Dime/2;
figure
[Xtotal,Ytotal]=contornosByLevel(IntA,Espacio,Spe,Dime);
Diametro=0.4;
Cantidad=floor(Dime/0.8)-1;
[TrayTotalX,TrayTotalY]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad);
[xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
TrayTotalX=xsa;
TrayTotalY=ysa;
plot(TrayTotalX,TrayTotalY,'Color',[23 63 95]/255,'LineWidth',3)
xlim([0 Dime+0.4])
ylim([0 Dime+0.4])
axis equal
%% Ciclo de contornos Nivel version mas unido
Espacio = 0.01;
Spe = 0.4;
Dime=12;
IntA=[[-1 1 1 -1 -1]' [-1 -1 1 1 -1]']*Dime/2+Dime/2;
figure
[Xtotal,Ytotal]=contornosByLevelv2(IntA,Espacio,Spe,Dime);
Diametro=0.4;
Cantidad=(floor((Dime-0.8)/0.7)+2)-1;
[TrayTotalX,TrayTotalY]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad);
[xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
TrayTotalX=xsa;
TrayTotalY=ysa;
plot(TrayTotalX,TrayTotalY,'Color',[23 63 95]/255,'LineWidth',3)
xlim([0 Dime+0.4])
ylim([0 Dime+0.4])
axis equal
%% Comienzo de Random Angulo Medio
Diametro=0.4;
Cantidad=14;
[TrayTotalX,TrayTotalY]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad);
[xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
TrayTotalX=xsa;
TrayTotalY=ysa;
%Graficar Trayectoria Total
figure
plot(TrayTotalX,TrayTotalY,'Color',[23 63 95]/255,'LineWidth',3)
xlim([0 Dime+0.4])
ylim([0 Dime+0.4])
axis equal
%% Comienzo de Random Angulo Medio
Diametro=0.4;
Cantidad=7;
[TrayTotalX,TrayTotalY]=generateCyclev2(Xtotal,Ytotal,XtotalW,YtotalW,XtotalE,YtotalE,XtotalQ,YtotalQ,XtotalA,YtotalA,XtotalB,YtotalB,Diametro)
[xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
TrayTotalX=xsa;
TrayTotalY=ysa;
%Graficar Trayectoria Total
figure
plot(TrayTotalX,TrayTotalY,'Color',[23 63 95]/255,'LineWidth',3)
xlim([-2 14])
ylim([-2 14])
axis equal
%% Comienzo de Random Angulo Medio v3
Diametro=0.4;
Cantidad=7;
[TrayTotalX,TrayTotalY]=generateCyclev3(Xtotal,Ytotal,XtotalW,YtotalW,XtotalE,YtotalE,XtotalQ,YtotalQ,XtotalA,YtotalA,XtotalB,YtotalB,Diametro)
[xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
TrayTotalX=xsa;
TrayTotalY=ysa;
%Graficar Trayectoria Total
figure
plot(TrayTotalX,TrayTotalY,'Color',[23 63 95]/255,'LineWidth',3)
xlim([-2 14])
ylim([-2 14])
axis equal
%% Estructura Matriz Total
Diametro=0.4;
Cantidad=14;
dim=[];
z=0.15:0.2:12;
MatrizTotal=[];
for i=1:length(z)
    [TrayTotalX,TrayTotalY]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad);
    [xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
    TrayTotalX=xsa;
    TrayTotalY=ysa;
    dim(i)=length(TrayTotalX);
    MatrizTotal(1:dim(i),1,i)=TrayTotalX;
    MatrizTotal(1:dim(i),2,i)=TrayTotalY;
    MatrizTotal(1:dim(i),3,i)=z(i)*ones(length(TrayTotalX),1);
end
%% Estructura Matriz Total
Diametro=0.4;
Cantidad=14;
dim=[];
z=0.15:0.2:12;
MatrizTotal=[];
for i=1:length(z)
    [TrayTotalX,TrayTotalY,Numi]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad);
%     [xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
%     TrayTotalX=xsa;
%     TrayTotalY=ysa;
    
    Capas=2;
    inda=Numi(end,2);
    indb=Numi(end,1);
    for in=2:Capas
        inda=inda+Numi(end-in+1,3);
        indb=indb-Numi(end-in+1,2);
    end
    [xsa,ysa]=suavizar(TrayTotalX(inda:indb),TrayTotalY(inda:indb),0.2,0.5);
    TrayTotalX=[TrayTotalX(1:inda-1)' xsa TrayTotalX(indb+1:end)'];
    TrayTotalY=[TrayTotalY(1:inda-1)' ysa TrayTotalY(indb+1:end)'];
    
    dx=gradient(TrayTotalX');
    dy=gradient(TrayTotalY');
    nv=[dy, -dx];
    unv=zeros(size(nv));
    norm_nv=sqrt(nv(:, 1).^2+nv(:, 2).^2);
    unv(:, 1)=nv(:, 1)./norm_nv;
    unv(:, 2)=nv(:, 2)./norm_nv;
    marca=[1 abs(diff(atan(unv(:,2)./unv(:,1)))')]>0.0001;
    marca(end)=1;
    TrayTotalX = TrayTotalX(marca);
    TrayTotalY = TrayTotalY(marca);
    
    dim(i)=length(TrayTotalX);
    MatrizTotal(1:dim(i),1,i)=TrayTotalX;
    MatrizTotal(1:dim(i),2,i)=TrayTotalY;
    MatrizTotal(1:dim(i),3,i)=z(i)*ones(length(TrayTotalX),1);
end
%% Estructura Matriz Total con v2 contornos
Espacio = 0.01;
Spe = 0.4;
Dime=12;
IntA=[[-1 1 1 -1 -1]' [-1 -1 1 1 -1]']*Dime/2+Dime/2;
[Xtotal,Ytotal]=contornosByLevel(IntA,Espacio,Spe,Dime);
[Xtotalv2,Ytotalv2]=contornosByLevelv2(IntA,Espacio,Spe,Dime);
[Xtotal,Ytotal]=contornosByLevelv3(IntA,Espacio,Spe,Dime,1.55);
Diametro=0.4;
Cantidad=4;
Cantidadv2=17;
dim=[];
z=0.15:0.2:12;
MatrizTotal=[];
for i=1:length(z)
    if i>4 && i<57
        [TrayTotalX,TrayTotalY,Numi]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad);
            Capas=2;
            inda=Numi(end,2);
            indb=Numi(end,1);
            for in=2:Capas
                inda=inda+Numi(end-in+1,3);
                indb=indb-Numi(end-in+1,2);
            end
            [xsa,ysa]=suavizar(TrayTotalX(inda:indb),TrayTotalY(inda:indb),0.2,0.5);
            TrayTotalX=[TrayTotalX(1:inda-1)' xsa TrayTotalX(indb+1:end)'];
            TrayTotalY=[TrayTotalY(1:inda-1)' ysa TrayTotalY(indb+1:end)'];
    else
        [TrayTotalX,TrayTotalY,Numi]=generateCycle(Xtotalv2,Ytotalv2,Diametro,Cantidadv2);
        TrayTotalX=TrayTotalX';
        TrayTotalY=TrayTotalY';
    end
%     [xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
%     TrayTotalX=xsa;
%     TrayTotalY=ysa;
    

    
    dx=gradient(TrayTotalX');
    dy=gradient(TrayTotalY');
    nv=[dy, -dx];
    unv=zeros(size(nv));
    norm_nv=sqrt(nv(:, 1).^2+nv(:, 2).^2);
    unv(:, 1)=nv(:, 1)./norm_nv;
    unv(:, 2)=nv(:, 2)./norm_nv;
    marca=[1 abs(diff(atan(unv(:,2)./unv(:,1)))')]>0.0001;
    marca(end)=1;
    TrayTotalX = TrayTotalX(marca);
    TrayTotalY = TrayTotalY(marca);
    
    dim(i)=length(TrayTotalX);
    MatrizTotal(1:dim(i),1,i)=TrayTotalX;
    MatrizTotal(1:dim(i),2,i)=TrayTotalY;
    MatrizTotal(1:dim(i),3,i)=z(i)*ones(length(TrayTotalX),1);
end
%% Plotear 3d
figure
hold on
for i=1:60
    plot3(MatrizTotal(1:dim(i),1,i),MatrizTotal(1:dim(i),2,i),MatrizTotal(1:dim(i),3,i))
end
%% Estructura Matriz Total Inclinado
Diametro=0.4;
Cantidad=7;
dim=[];
z=[0.2 0.6 1 1.4 1.8 2.2 2.6 3 3.4 3.8 4.2 4.6 5];
MatrizTotal=[];
Espacio = 0.01;
Spe = 0.4;
Diametro=0.4;
IntB=IntA;
for i=1:length(z)
    Dime=-0.99*z(i)+6.6;
    IntA=[[-1 1 1 -1 -1]' [-1 -1 1 1 -1]']*Dime/2+3.2;
    %IntB(:,1)=(IntA(:,1)-4)*Dime/60+(3.2-Dime/2);
    %IntB(:,2)=(IntA(:,2)-38)*Dime/60+(3.2-Dime/2);
    [Xtotal,Ytotal]=contornosByLevel(IntA,Espacio,Spe,Dime);
    Cantidad=floor(Dime/0.8)-1;
    [TrayTotalX,TrayTotalY]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad);
    [xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
    TrayTotalX=xsa;
    TrayTotalY=ysa;
    dim(i)=length(TrayTotalX);
    MatrizTotal(1:dim(i),1,i)=TrayTotalX;
    MatrizTotal(1:dim(i),2,i)=TrayTotalY;
    MatrizTotal(1:dim(i),3,i)=z(i)*ones(length(TrayTotalX),1);
end

%% Estructura Matriz Total Agujeros Circ
Diametro=0.4;
Cantidad=7;
dim=[];
z=[0.2 0.6 1 1.4 1.8 2.2 2.6 3 3.4 3.8 4.2 4.6 5];
MatrizTotal=[];
Espacio = 0.01;
Spe = 0.4;
Diametro=0.4;
IntB=IntA;
for i=1:length(z)
    Dime=-0.99*(double(z(i)>2.7)*2.4+0.2)+6.6;
    IntB(:,1)=(IntA(:,1)-4)*6.4*2/60;
    IntB(:,2)=(IntA(:,2)-38)*6.4*2/60;
    [Xtotal,Ytotal]=contornosByLevel(IntB,Espacio,Spe,Dime);
    Cantidad=floor(Dime/0.8)-1;
    [TrayTotalX,TrayTotalY]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad);
    [xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
    TrayTotalX=xsa;
    TrayTotalY=ysa;
    dim(i)=length(TrayTotalX);
    MatrizTotal(1:dim(i),1,i)=TrayTotalX;
    MatrizTotal(1:dim(i),2,i)=TrayTotalY;
    MatrizTotal(1:dim(i),3,i)=z(i)*ones(length(TrayTotalX),1);
end
%% Estructura Matriz Total
Diametro=0.4;
Cantidad=7;
dim=[];
z=[0.2 0.6 1 1.4 1.8 2.2 2.6 3 3.4 3.8 4.2 4.6 5];
MatrizTotal=[];
for i=1:length(z)
    [TrayTotalX,TrayTotalY]=generateCyclev2(Xtotal,Ytotal,XtotalW,YtotalW,XtotalE,YtotalE,XtotalQ,YtotalQ,XtotalA,YtotalA,XtotalB,YtotalB,Diametro);
    [xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
    TrayTotalX=xsa;
    TrayTotalY=ysa;
    dim(i)=length(TrayTotalX);
    MatrizTotal(1:dim(i),1,i)=TrayTotalX;
    MatrizTotal(1:dim(i),2,i)=TrayTotalY;
    MatrizTotal(1:dim(i),3,i)=z(i)*ones(length(TrayTotalX),1);
end
%% Estructura Matriz Total
Diametro=0.4;
Cantidad=7;
dim=[];
z=[0.2 0.6 1 1.4 1.8 2.2 2.6 3 3.4 3.8 4.2 4.6 5];
MatrizTotal=[];
IntB=IntA;
for i=1:length(z)
    if i>6
    [TrayTotalX,TrayTotalY]=generateCyclev3(Xtotal,Ytotal,XtotalW,YtotalW,XtotalE,YtotalE,XtotalQ,YtotalQ,XtotalA,YtotalA,XtotalB,YtotalB,Diametro);
    else
    Dime=6.4*2-0.1;
    IntB(:,1)=(IntA(:,1)-4)*6.4*2/60;
    IntB(:,2)=(IntA(:,2)-38)*6.4*2/60;
    [XtotalR,YtotalR]=contornosByLevel(IntB,Espacio,Spe,Dime);
    Cantidad=floor(Dime/0.8)-1;
    [TrayTotalX,TrayTotalY]=generateCycle(XtotalR,YtotalR,Diametro,Cantidad);
    end
    [xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
    TrayTotalX=xsa;
    TrayTotalY=ysa;
    dim(i)=length(TrayTotalX);
    MatrizTotal(1:dim(i),1,i)=TrayTotalX;
    MatrizTotal(1:dim(i),2,i)=TrayTotalY;
    MatrizTotal(1:dim(i),3,i)=z(i)*ones(length(TrayTotalX),1);
end
%% Plotear 3d
figure
hold on
for i=1:length(z)
    plot3(MatrizTotal(1:dim(i),1,i),MatrizTotal(1:dim(i),2,i),MatrizTotal(1:dim(i),3,i))
end
%% Unir Matriz
figure
TrayTotX=[];
TrayTotY=[];
TrayTotZ=[];
PoinX=3;
PoinY=3;
Diametro=0.4;

for i=1:length(z)
[XcutFi,YcutFi,PosCutB]=nearPoint(MatrizTotal(1:dim(i),1,i),MatrizTotal(1:dim(i),2,i),PoinX,PoinY);
[Xcutnn,Ycutnn]=orderTrayInPoint(MatrizTotal(1:dim(i),1,i),MatrizTotal(1:dim(i),2,i),PosCutB,XcutFi,YcutFi);
MagIn=sqrt(diff(Xcutnn).^2+diff(Ycutnn).^2);
Mag=sum(MagIn);
Num=(Mag-Diametro-0.00000001)*1;
[Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xcutnn,Ycutnn,Num,Diametro);
TrayTotX=[TrayTotX;Xcut];
TrayTotY=[TrayTotY;Ycut];
TrayTotZ=[TrayTotZ;MatrizTotal(1,3,i)*ones(length(Xcut),1)];
PoinX=TrayTotX(end);
PoinY=TrayTotY(end);
end

plot3(TrayTotX,TrayTotY,TrayTotZ)

%% PRUEBA CON PERFIL APLANADO
PerfAplan=PerfilAplanado(1:118,:);
NumCapas=PerfAplan(end,3);
Diametro=0.4;
Espacio = 0.01;
MatrizT=[];
for i=1:NumCapas
    figure
    hold on
    Pos=PerfAplan(:,3)==i;
    plot(PerfAplan(Pos,1),PerfAplan(Pos,2),'b')
    Dime=min([max(PerfAplan(Pos,1))-min(PerfAplan(Pos,1)) max(PerfAplan(Pos,2))-min(PerfAplan(Pos,2))])+0.3;
    [Xtotal,Ytotal]=contornosByLevel(PerfAplan(Pos,1:2),Espacio,Diametro,Dime);
    Cantidad=floor(Dime/0.8)-1;
    [TrayTotalX,TrayTotalY]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad);
    [xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
    TrayTotalX=xsa;
    TrayTotalY=ysa;
    plot(TrayTotalX,TrayTotalY,'r')
    MatrizT=[MatrizT;TrayTotalX' TrayTotalY' i*ones(length(TrayTotalX),1)];
    axis equal
end
%% TrayTotal
NumCapas=PerfilDoblado(end,4);
for i=1:NumCapas
    figure
    Pos=PerfilDoblado(:,4)==i;
    plot3(PerfilDoblado(Pos,1),PerfilDoblado(Pos,2),PerfilDoblado(Pos,3),'b')
end
%% Unir Matriz Total Curvo
figure
TrayTotX=[];
TrayTotY=[];
TrayTotZ=[];
PoinX=0;
PoinY=0;
Diametro=0.4;
NumCapas=PerfilDoblado(end,4);

for i=1:NumCapas
[XcutFi,YcutFi,PosCutB]=nearPoint(MatrizTotal(1:dim(i),1,i),MatrizTotal(1:dim(i),2,i),PoinX,PoinY);
[Xcutnn,Ycutnn]=orderTrayInPoint(MatrizTotal(1:dim(i),1,i),MatrizTotal(1:dim(i),2,i),PosCutB,XcutFi,YcutFi);
MagIn=sqrt(diff(Xcutnn).^2+diff(Ycutnn).^2);
Mag=sum(MagIn);
Num=(Mag-Diametro-0.00000001)*1;
[Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xcutnn,Ycutnn,Num,Diametro);
TrayTotX=[TrayTotX;Xcut];
TrayTotY=[TrayTotY;Ycut];
TrayTotZ=[TrayTotZ;MatrizTotal(1,3,i)*ones(length(Xcut),1)];
PoinX=TrayTotX(end);
PoinY=TrayTotY(end);
end

plot3(TrayTotX,TrayTotY,TrayTotZ)