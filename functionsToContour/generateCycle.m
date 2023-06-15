function [TrayTotalX,TrayTotalY,Numi]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad,Conx,Des)
if nargin<5
  Conx = 1;
end
if nargin<6
  Des = 0;
end
Numi=[];
Marc=2;
Bin=size(Xtotal);
Bin=Bin(2);
Bb=~isnan(Xtotal(:,Bin));
%Contorno
Xaux=Xtotal(Bb,Bin);
Yaux=Ytotal(Bb,Bin);
    
%Punto a Cortar
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
%if Des==1
%Num=Mag-Diametro-1e-4;
%Num=0;
%else
Num=rand*Mag;
%end
%Corte de Contorno
[Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xaux,Yaux,Num,Diametro);

%Trayectoria Total
TrayTotalX=Xcut;
TrayTotalY=Ycut;

for iii=1:Cantidad-1

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(Xtotal(:,Bin));
Xaux=Xtotal(Bb,Bin);
Yaux=Ytotal(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

if Conx == 1
PromPendiente=-(Xin-Xfi)/(Yin-Yfi);
[XcutIn,YcutIn,PosCutA]=nearSlopePoint(Xaux,Yaux,Xin,Yin,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(Xaux,Yaux,Xfi,Yfi,PromPendiente);
else
[XcutIn,YcutIn,PosCutA]=nearPoint(Xaux,Yaux,Xin,Yin);
[XcutFi,YcutFi,PosCutB]=nearPoint(Xaux,Yaux,Xfi,Yfi);
end

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

%Contorno
Xaux=Xcutnn;
Yaux=Ycutnn;
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
MagAc=[0;cumsum(MagIn)];
if Des==1
if mod(iii,2)==1
Num=Mag-Diametro-1e-4;
else
Num=0;
end
else
Num=rand*(Mag-Diametro-1e-4);
end

%Cortar Contorno
[Xcut,Ycut,Xcut2,Ycut2,Xin,Yin,Xfi,Yfi]=cutCurve(Xaux,Yaux,Num,Diametro);

%Trayectoria Total
if Xcut2(1)==TrayTotalX(1) && Ycut2(1)==TrayTotalY(1)
TrayTotalX=[flip(Xcut2(2:end));TrayTotalX;flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));TrayTotalY;flip(Ycut(1:end-1))];
Marc=0;
else
if Xcut2(1)==TrayTotalX(end) && Ycut2(1)==TrayTotalY(end)
TrayTotalX=[flip(Xcut2(2:end));flip(TrayTotalX);flip(Xcut(1:end-1))];
TrayTotalY=[flip(Ycut2(2:end));flip(TrayTotalY);flip(Ycut(1:end-1))];
Marc=1;
else
if Xcut2(end)==TrayTotalX(1) && Ycut2(end)==TrayTotalY(1)
TrayTotalX=[Xcut2(1:end-1);TrayTotalX;Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);TrayTotalY;Ycut(2:end)];
Marc=1;
else
TrayTotalX=[Xcut2(1:end-1);flip(TrayTotalX);Xcut(2:end)];
TrayTotalY=[Ycut2(1:end-1);flip(TrayTotalY);Ycut(2:end)];
Marc=0;
end
end
end

if (Marc + mod(iii,2)==1)==1
Numi(iii,1)=length(TrayTotalX);
Numi(iii,2)=length(Xcut);
Numi(iii,3)=length(Xcut2);
else
Numi(iii,1)=length(TrayTotalX);
Numi(iii,2)=length(Xcut2);
Numi(iii,3)=length(Xcut);   
end

end

%Buscar Siguiente Capa
Bin=Bin-1;
Bb=~isnan(Xtotal(:,Bin));
Xaux=Xtotal(Bb,Bin);
Yaux=Ytotal(Bb,Bin);

%Remuestrear Contorno
[Xaux,Yaux]=resampleborder(Xaux,Yaux,0.5);
Xaux=Xaux';
Yaux=Yaux';

if Conx == 1
PromPendiente=-(Xin-Xfi)/(Yin-Yfi);
[XcutIn,YcutIn,PosCutA]=nearSlopePoint(Xaux,Yaux,Xin,Yin,PromPendiente);
[XcutFi,YcutFi,PosCutB]=nearSlopePoint(Xaux,Yaux,Xfi,Yfi,PromPendiente);
else
[XcutIn,YcutIn,PosCutA]=nearPoint(Xaux,Yaux,Xin,Yin);
[XcutFi,YcutFi,PosCutB]=nearPoint(Xaux,Yaux,Xfi,Yfi);
end


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

%Trayectoria Total
if Xcutnn(1)==TrayTotalX(1) && Ycutnn(1)==TrayTotalY(1)
TrayTotalX=[flip(Xcutnn(2:end));TrayTotalX];
TrayTotalY=[flip(Ycutnn(2:end));TrayTotalY];
else
TrayTotalX=[flip(Xcutnn(2:end));flip(TrayTotalX)];
TrayTotalY=[flip(Ycutnn(2:end));flip(TrayTotalY)];
end
Numi(iii+1,1)=length(TrayTotalX);
Numi(iii+1,2)=length(Xcutnn);
Numi(iii+1,3)=0;
end