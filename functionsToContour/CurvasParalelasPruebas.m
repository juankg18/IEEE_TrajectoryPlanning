%% CURVAS PARALELAS PRUEBAS
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
%% Resample Borde
Espacio = 0.1;
[Aato2,Aato3]=resampleborder(IntA(:,1),IntA(:,2),Espacio);
figure
plot(IntA(:,1), IntA(:,2),'r')
hold on
plot(Aato2, Aato3,'b')
%% Aplicar Parallel
[x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(Aato2, Aato3, 4, 1, 0);
%% Ciclo de contornos
Espacio = 0.01;
Spe = 2;
Xentrada=Ext(:,1);
Yentrada=Ext(:,2);
%Xentrada=[0;0;300;300;0;0;600;600;0]/20;
%Yentrada=[0;100;100;200;200;300;300;0;0]/20;
newflag=1;
clear Xtotal
clear Ytotal
figure;
plot(Xentrada, Yentrada, 'b');
Xtotal(:,1)=Xentrada;
Ytotal(:,1)=Yentrada;
hold on;
for i=1:27
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_inner', y_inner');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    Xtotal(1:length(Xentrada),i+1)=Xentrada';
    Ytotal(1:length(Yentrada),i+1)=Yentrada';
    newflag=0;
end
% [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(Xsamp, Ysamp, Spe/2, 0, 0,newflag);
% plot(x_inner, y_inner, 'r');
% Xentrada=x_inner;
% Yentrada=y_inner;
% Xtotal(1:length(Xentrada),i+1)=Xentrada';
% Ytotal(1:length(Yentrada),i+1)=Yentrada';
%% Unir contornos A
Espacio = 0.01;
Spe = 1;
Xentrada=Ext(:,1);
Yentrada=Ext(:,2);
XentradaA=IntA(:,1);
YentradaA=IntA(:,2);
%Xentrada=[0;0;300;300;0;0;600;600;0]/20;
%Yentrada=[0;100;100;200;200;300;300;0;0]/20;
newflag=1;
clear Xtotal
clear Ytotal
clear XtotalA
clear YtotalA
figure;
plot(Xentrada, Yentrada, 'b');
hold on;
plot(XentradaA, YentradaA, 'g');
Xtotal(:,1)=Xentrada;
Ytotal(:,1)=Yentrada;
XtotalA(:,1)=XentradaA;
YtotalA(:,1)=YentradaA;
hold on;
Die=0;
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
    plot(x_inner(1,:)', y_inner(1,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    Xtotal(1:length(Xentrada),i+1)=Xentrada';
    Ytotal(1:length(Yentrada),i+1)=Yentrada';
    if Die == 0
    plot(x_outerA', y_outerA');
    XentradaA=x_outerA(1,:);
    YentradaA=y_outerA(1,:);
    XtotalA(1:length(XentradaA),i+1)=XentradaA';
    YtotalA(1:length(YentradaA),i+1)=YentradaA';
    end
    newflag=0;
    pause(0.01)
end
%%
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_inner(1:2,:)', y_inner(1:2,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    Xtotal(1:length(Xentrada),i+1)=Xentrada';
    Ytotal(1:length(Yentrada),i+1)=Yentrada';
    newflag=0;
    pause(0.01)
%% 
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
%%
for i=1:13
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_inner(1,:)', y_inner(1,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    newflag=0;
    pause(0.01)
end
%%
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_inner(1,:)', y_inner(1,:)');
    plot(x_inner(3,:)', y_inner(3,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    newflag=0;
    pause(0.01)
%%
for i=1:8
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_inner(1,:)', y_inner(1,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    newflag=0;
    pause(0.01)
end
%%
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_inner(1,:)', y_inner(1,:)');
    plot(x_inner(5,:)', y_inner(5,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    newflag=0;
    pause(0.01)
%%
for i=1:3
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_inner(1,:)', y_inner(1,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    newflag=0;
    pause(0.01)
end
%%
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_inner(2,:)', y_inner(2,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    newflag=0;
    pause(0.01)
%% Unir contornos B
Espacio = 0.01;
Spe = 1;
Xentrada=Ext(:,1);
Yentrada=Ext(:,2);
XentradaA=IntB(:,1);
YentradaA=IntB(:,2);
%Xentrada=[0;0;300;300;0;0;600;600;0]/20;
%Yentrada=[0;100;100;200;200;300;300;0;0]/20;
newflag=1;
clear Xtotal
clear Ytotal
clear XtotalA
clear YtotalA
figure;
plot(Xentrada, Yentrada, 'b');
hold on;
plot(XentradaA, YentradaA, 'g');
Xtotal(:,1)=Xentrada;
Ytotal(:,1)=Yentrada;
XtotalA(:,1)=XentradaA;
YtotalA(:,1)=YentradaA;
hold on;
Die=0;
for i=1:43
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
    plot(x_inner(1,:)', y_inner(1,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    Xtotal(1:length(Xentrada),i+1)=Xentrada';
    Ytotal(1:length(Yentrada),i+1)=Yentrada';
    if Die == 0
    plot(x_outerA', y_outerA');
    XentradaA=x_outerA(1,:);
    YentradaA=y_outerA(1,:);
    XtotalA(1:length(XentradaA),i+1)=XentradaA';
    YtotalA(1:length(YentradaA),i+1)=YentradaA';
    end
    newflag=0;
    pause(0.01)
end
%% Unir contornos C
Espacio = 0.01;
Spe = 1;
Xentrada=Ext(:,1);
Yentrada=Ext(:,2);
XentradaA=IntA(:,1);
YentradaA=IntA(:,2);
XentradaB=IntB(:,1);
YentradaB=IntB(:,2);
newflag=1;
figure;
plot(Xentrada, Yentrada, 'b');
hold on;
plot(XentradaA, YentradaA, 'g');
hold on;
plot(XentradaB, YentradaB, 'g');
hold on;
DieA=0;
DieB=0;
for i=1:6
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    if DieA == 0
    [XsampA,YsampA]=resampleborder(XentradaA,YentradaA,Espacio);
    [x_innerA, y_innerA, x_outerA, y_outerA, R, unv, concavity, overlap]=parallel_curvepamejor(XsampA, YsampA, Spe/(newflag+1), 0, 0,newflag);
    [Boolt,x_innerOut,y_innerOut,x_outerAOut,y_outerAOut]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerA(1,:),y_outerA(1,:));
    end
    if DieB == 0
    [XsampB,YsampB]=resampleborder(XentradaB,YentradaB,Espacio);
    [x_innerB, y_innerB, x_outerB, y_outerB, R, unv, concavity, overlap]=parallel_curvepamejor(XsampB, YsampB, Spe/(newflag+1), 0, 0,newflag);
    [BooltB,x_innerOutB,y_innerOutB,x_outerAOutB,y_outerAOutB]=combinecurves(x_inner(1,:),y_inner(1,:),x_outerB(1,:),y_outerB(1,:));
    end
    x_innerAux=x_inner;
    y_innerAux=y_inner;
    if Boolt==1
        x_inner=x_innerOut;
        y_inner=y_innerOut;
        x_outerA=[];
        y_outerA=[];
        DieA=1;
        Boolt=0;
    end
    if BooltB==1
        x_inner=x_innerOutB;
        y_inner=y_innerOutB;
        x_outerB=[];
        y_outerB=[];
        DieB=1;
        BooltB=0;
    end
    plot(x_inner(1,:)', y_inner(1,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    if DieA == 0
    plot(x_outerA', y_outerA');
    XentradaA=x_outerA(1,:);
    YentradaA=y_outerA(1,:);
    end
    if DieB == 0
    plot(x_outerB', y_outerB');
    XentradaB=x_outerB(1,:);
    YentradaB=y_outerB(1,:);
    end
    newflag=0;
    pause(0.01)
end
plot(x_innerAux(2,:)', y_innerAux(2,:)');
%%
XentradaB=x_innerAux(2,:);
YentradaB=y_innerAux(2,:);
for i=1:3
    [Xsamp,Ysamp]=resampleborder(XentradaB,YentradaB,Espacio);
    [x_innerP, y_innerP, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_innerP(1,:)', y_innerP(1,:)');
    XentradaB=x_innerP(1,:);
    YentradaB=y_innerP(1,:);
    newflag=0;
    pause(0.01)
end
%%
for i=1:7
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_inner(1,:)', y_inner(1,:)');
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    newflag=0;
    pause(0.01)
end
    plot(x_inner(2,:)', y_inner(2,:)');
    x_innerAux=x_inner;
    y_innerAux=y_inner;
%%
XentradaB=x_innerAux(1,:);
YentradaB=y_innerAux(1,:);
for i=1:15
    [Xsamp,Ysamp]=resampleborder(XentradaB,YentradaB,Espacio);
    [x_innerP, y_innerP, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_innerP(1,:)', y_innerP(1,:)');
    XentradaB=x_innerP(1,:);
    YentradaB=y_innerP(1,:);
    newflag=0;
    pause(0.01)
end
%%
XentradaB=x_innerAux(2,:);
YentradaB=y_innerAux(2,:);
for i=1:6
    [Xsamp,Ysamp]=resampleborder(XentradaB,YentradaB,Espacio);
    [x_innerP, y_innerP, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_innerP(1,:)', y_innerP(1,:)');
    XentradaB=x_innerP(1,:);
    YentradaB=y_innerP(1,:);
    newflag=0;
    pause(0.01)
end
%%
    [Xsamp,Ysamp]=resampleborder(XentradaB,YentradaB,Espacio);
    [x_innerP, y_innerP, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_innerP(2,:)', y_innerP(2,:)');
    plot(x_innerP(3,:)', y_innerP(3,:)');
    XentradaB=x_innerP(2,:);
    YentradaB=y_innerP(2,:);
    newflag=0;
    pause(0.01)
%%
    [Xsamp,Ysamp]=resampleborder(XentradaB,YentradaB,Espacio);
    [x_innerP, y_innerP, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    plot(x_innerP(2,:)', y_innerP(2,:)');
    XentradaB=x_innerP(1,:);
    YentradaB=y_innerP(1,:);
    newflag=0;
    pause(0.01)