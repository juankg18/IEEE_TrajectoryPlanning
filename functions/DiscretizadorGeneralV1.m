clc
close all
%% Disretización tridimensional analizando los triangulos 
% fileName -> Nombre Archivo en stl. e.g.->'Pieza6.stl'
% DistEntreCapas-> distancia entre capas dada en milimetros
fileName= 'Pieza6.stl';
DistEntreCapas= 2;

[contornoFinal,xLimits,yLimits,numcapas]=Aplanar(fileName,DistEntreCapas);

%% Aplanado de las capas
[PerfilAplanado,traslado,AlturaCapa]=desdoblar(contornoFinal,xLimits,yLimits,numcapas);

%% Generacion de patrones JC
% Juan: aca va su programa, sugiero hacer una función. En este ejemplo usted
% recibió la matriz: PerfilAplanado y su programa retornó:MatrizT
load 'Matriz.mat'
%% perfiles doblados 
PerfilDoblado=doblar(MatrizT,AlturaCapa,numcapas,traslado);
%% propagacion
for i=1:numcapas+1
    RR=desdoblarPuntos(Cat(i,:),i,traslado)
    TT=[RR(:,1:2) RR(:,4)]
    doblarPuntos(TT,AlturaCapa,i,traslado)
end
%% Conexion
TrayTotX=[];
TrayTotY=[];
TrayTotZ=[];
Normal=[];
Diametro=0.4;
Espacio=0.2;
Inx=10;
Iny=10;
Inz=0;

    ind = contornoFinal(:,end) == 1;
    A1 = contornoFinal(ind,:);
    % plano= jx + ky + lz + m =0
    j=A1(1,end-4);
    k=A1(1,end-3);
    l=A1(1,end-2);

for i=1:13
    CC=[Inx Iny Inz i]
    TT=desdoblarPuntos(CC,i,traslado)
    ind = MatrizT(:,3) == i;
    A1 = MatrizT(ind,:);
    [Xsamp,Ysamp]=resampleborder(A1(:,1),A1(:,2),Espacio);
    [XcutFi,YcutFi,PosCutB]=nearPoint(Xsamp',Ysamp',TT(1),TT(2))
    [Xcutnn,Ycutnn]=orderTrayInPoint(Xsamp',Ysamp',PosCutB,XcutFi,YcutFi)
    [Xcutnn,Ycutnn]=desampleborder(Xcutnn',Ycutnn');
    Xcutnn=Xcutnn'
    Ycutnn=Ycutnn'
    MagIn=sqrt(diff(Xcutnn).^2+diff(Ycutnn).^2);
    Mag=sum(MagIn);
    Num=(Mag-Diametro-0.00000001)*1;
    [Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xcutnn,Ycutnn,Num,Diametro);
    LL=doblarPuntos([Xcut Ycut i*ones(length(Xcut),1)],AlturaCapa,i,traslado)
    TrayTotX=[TrayTotX;LL(:,1)];
    TrayTotY=[TrayTotY;LL(:,2)];
    TrayTotZ=[TrayTotZ;LL(:,3)];
    Normal=[Normal;j*ones(size(LL,1),1) k*ones(size(LL,1),1) l*ones(size(LL,1),1)];
    PoinX=TrayTotX(end);
    PoinY=TrayTotY(end);
    PoinZ=TrayTotZ(end);
    ind = contornoFinal(:,end) == i+1;
    A1 = contornoFinal(ind,:);
    % plano= jx + ky + lz + m =0
    j=A1(1,end-4);
    k=A1(1,end-3);
    l=A1(1,end-2);
    m=A1(1,end-1);
    lam=(-m-j*PoinX-k*PoinY-l*PoinZ)/(j*j+k*k+l*l);
    Inx=PoinX+lam*j;
    Iny=PoinY+lam*k;
    Inz=PoinZ+lam*l;
end
    i=i+1;
    CC=[Inx Iny Inz i]
    TT=desdoblarPuntos(CC,i,traslado)
    ind = MatrizT(:,3) == i;
    A1 = MatrizT(ind,:);
    [Xsamp,Ysamp]=resampleborder(A1(:,1),A1(:,2),Espacio);
    [XcutFi,YcutFi,PosCutB]=nearPoint(Xsamp',Ysamp',TT(1),TT(2))
    [Xcutnn,Ycutnn]=orderTrayInPoint(Xsamp',Ysamp',PosCutB,XcutFi,YcutFi)
    [Xcutnn,Ycutnn]=desampleborder(Xcutnn',Ycutnn');
    Xcutnn=Xcutnn'
    Ycutnn=Ycutnn'
    MagIn=sqrt(diff(Xcutnn).^2+diff(Ycutnn).^2);
    Mag=sum(MagIn);
    Num=(Mag-Diametro-0.00000001)*1;
    [Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xcutnn,Ycutnn,Num,Diametro);
    LL=doblarPuntos([Xcut Ycut i*ones(length(Xcut),1)],AlturaCapa,i,traslado)
    TrayTotX=[TrayTotX;LL(:,1)];
    TrayTotY=[TrayTotY;LL(:,2)];
    TrayTotZ=[TrayTotZ;LL(:,3)];
    Normal=[Normal;-j*ones(size(LL,1),1) -k*ones(size(LL,1),1) -l*ones(size(LL,1),1)];
    
    norm_nv=sqrt(Normal(:, 1).^2+Normal(:, 2).^2+Normal(:, 3).^2);
    uNormal(:, 1)=Normal(:, 1)./norm_nv;
    uNormal(:, 2)=Normal(:, 2)./norm_nv;
    uNormal(:, 3)=Normal(:, 3)./norm_nv;
    
    figure
    plot3(TrayTotX,TrayTotY,TrayTotZ,'r','Linewidth',2)
    hold on
    Fact=1.5;
    plot3([TrayTotX';TrayTotX'+Fact*uNormal(:, 1)'],[TrayTotY';TrayTotY'+Fact*uNormal(:, 2)'],[TrayTotZ';TrayTotZ'+Fact*uNormal(:, 3)'],'b','Linewidth',1)
    