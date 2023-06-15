%%
close all
RectaX=[0 0.6];
RectaY=[0 0.6];
Diametro=1;
flag=0;
pgonD=lineToPoly(RectaX,RectaY,Diametro,flag);
RectaX2=[4 7];
RectaY2=[3 1];
pgonD2=lineToPoly(RectaX2,RectaY2,Diametro,flag);
polyout = intersect(pgonD,pgonD2);
plot(polyout)
axis equal
%%
close all
RectaX=[0 0.6];
RectaY=[0 0.6];
Diametro=1;
flag=1;
pgonD=lineToPoly(RectaX,RectaY,Diametro,flag);
RectaX2=[4 7];
RectaY2=[3 1];
pgonD2=lineToPoly(RectaX2,RectaY2,Diametro,flag);
polyout = union(pgonD,pgonD2);
plot(polyout)
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1);
Yentrada=IntA(:,2);
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=1;
flag=1;
figure
pgonD=lineToPoly(TrayTotalX(1:2),TrayTotalY(1:2),Diametro,flag);
for i=3:LargeT
pgonD2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyout=union(pgonD,pgonD2);
pgonD=polyout;
disp(i)
end
plot(pgonD)
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1);
Yentrada=IntA(:,2);
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=1;
flag=0;
pgonX=polyshape();
figure
for i=3:LargeT
pgonV=lineToPoly(TrayTotalX(i-2:i-1),TrayTotalY(i-2:i-1),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
plot(pgonOut)
hold on
pgonUnder=subtract(pgonOut,pgonD)
plot(pgonUnder)
figure
plot(Xentrada, Yentrada, 'g');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
%%
[Aato2,Aato3]=resampleborder(TrayTotalX,TrayTotalY,0.03);
dx=gradient(Aato2');
dy=gradient(Aato3');
dx2=gradient(dx);
dy2=gradient(dy);
nv=[dy, -dx];
unv=zeros(size(nv));
norm_nv=sqrt(nv(:, 1).^2+nv(:, 2).^2);
unv(:, 1)=nv(:, 1)./norm_nv;
unv(:, 2)=nv(:, 2)./norm_nv;
marca=[0 abs(diff(atan(unv(:,2)./unv(:,1)))')]>0.001;
x = Aato2(~marca);  
y = Aato3(~marca);
figure
plot(TrayTotalX,TrayTotalY)
knots = [x; y];
areaOfPolygon = polyarea(x,y);
numberOfPoints = length(x);
originalSpacing = 1 : numberOfPoints;
finerSpacing = 1 : 0.1 : numberOfPoints;
splineXY = pchip(originalSpacing, knots, finerSpacing);
figure
plot(splineXY(1, :), splineXY(2, :), 'b');
Xsa=splineXY(1, :);
Ysa=splineXY(2, :);
dx=gradient(Xsa');
dy=gradient(Ysa');
dx2=gradient(dx);
dy2=gradient(dy);
nv=[dy, -dx];
unv=zeros(size(nv));
norm_nv=sqrt(nv(:, 1).^2+nv(:, 2).^2);
unv(:, 1)=nv(:, 1)./norm_nv;
unv(:, 2)=nv(:, 2)./norm_nv;
marca=[1 abs(diff(atan(unv(:,2)./unv(:,1)))')]>0.0001;
marca(end)=1;
xsa = Xsa(marca);
ysa = Ysa(marca);
figure
plot(xsa, ysa, 'b');
%%
figure
plot(xsa,ysa,'g','LineWidth',1.5)
Xentrada=IntA(:,1);
Yentrada=IntA(:,2);
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(xsa);
Diametro=1;
flag=1;
figure
pgonD=lineToPoly(xsa(1:2),ysa(1:2),Diametro,flag);
for i=3:LargeT
pgonD2=lineToPoly(xsa(i-1:i),ysa(i-1:i),Diametro,flag);
polyout=union(pgonD,pgonD2);
pgonD=polyout;
disp(i)
end
plot(pgonD)
axis equal
%%
figure
plot(xsa,ysa,'g','LineWidth',1.5)
Xentrada=IntA(:,1);
Yentrada=IntA(:,2);
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(xsa);
Diametro=1;
flag=0;
pgonX=polyshape();
figure
for i=3:LargeT
pgonV=lineToPoly(xsa(i-2:i-1),ysa(i-2:i-1),Diametro,flag);
pgonV2=lineToPoly(xsa(i-1:i),ysa(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
plot(pgonOut)
hold on
pgonUnder=subtract(pgonOut,pgonD)
plot(pgonUnder)
figure
plot(Xentrada, Yentrada, 'g');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)