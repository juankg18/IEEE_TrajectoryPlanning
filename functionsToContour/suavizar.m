function [xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,Par,Par2)
Largo=length(TrayTotalX);
posic=[];
for i=2:Largo-1
    theta=cart2pol(TrayTotalX(i)-TrayTotalX(i-1),TrayTotalY(i)-TrayTotalY(i-1));
    theta2=cart2pol(TrayTotalX(i+1)-TrayTotalX(i),TrayTotalY(i+1)-TrayTotalY(i));
    if ~((abs(angdiff(theta2,theta))*180/pi)<30)
        posic=[posic i];
    end
end
Xaux=TrayTotalX;
Yaux=TrayTotalY;
Ta=0;
Tb=0;
Ac=0;
for i=1:length(posic)
Ac=Tb-Ta+Ac;
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
MagAc=[0;cumsum(MagIn)];
Num=MagAc(posic(i)+Ac)-Par/2;
Ta=length(Xaux);
[Xcut,Ycut,Xcut2,Ycut2]=cutCurve(Xaux,Yaux,Num,Par);
Xaux=[Xcut2;Xcut];
Yaux=[Ycut2;Ycut];
Tb=length(Xaux);
end
x = Xaux'; 
y = Yaux';
knots = [x; y];
numberOfPoints = length(x);
originalSpacing = 1 : numberOfPoints;
finerSpacing = 1 : Par2 : numberOfPoints;
splineXY = pchip(originalSpacing, knots, finerSpacing);
Xsa=splineXY(1, :);
Ysa=splineXY(2, :);
dx=gradient(Xsa');
dy=gradient(Ysa');
nv=[dy, -dx];
unv=zeros(size(nv));
norm_nv=sqrt(nv(:, 1).^2+nv(:, 2).^2);
unv(:, 1)=nv(:, 1)./norm_nv;
unv(:, 2)=nv(:, 2)./norm_nv;
marca=[1 abs(diff(atan(unv(:,2)./unv(:,1)))')]>0.0001;
marca(end)=1;
xsa = Xsa(marca);
ysa = Ysa(marca);
end