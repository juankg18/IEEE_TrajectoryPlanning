%% Cont
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayCpPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
TrayTotalX=((TrayZigX-90))+3.2;
TrayTotalY=((TrayZigY-90))+3.2;
plot(TrayTotalX, TrayTotalY, 'r','LineWidth',2);
Dis=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
end
Dis
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
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
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
for j=i+1:LargeT
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Pa hil
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayHiPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
TrayTotalX=((TrayZigX-90))+3.2;
TrayTotalY=((TrayZigY-90))+3.2;
plot(TrayTotalX, TrayTotalY, 'r','LineWidth',2);
figure
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
Dis=0;
Dis2=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
    if Act<1.3 && (i>49 || i<41) && (i>66 || i<58) && (i>220 || i<211)
        hold on
        plot(TrayTotalX(i:i+1), TrayTotalY(i:i+1), 'r','LineWidth',2);
        Dis2=Dis2+Act;
    end
end
Dis
Dis2
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=1;
figure
pgonD=lineToPoly(TrayTotalX(1:2),TrayTotalY(1:2),Diametro,flag);
for i=3:LargeT
Act=sqrt((TrayTotalX(i-1)-TrayTotalX(i))^2+(TrayTotalY(i-1)-TrayTotalY(i))^2);
if Act<1.3 && (i>50 || i<42) && (i>67 || i<59) && (i>221 || i<212)
pgonD2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyout=union(pgonD,pgonD2);
pgonD=polyout;
disp(i)
end
end
plot(pgonD)
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
Act=sqrt((TrayTotalX(i-1)-TrayTotalX(i))^2+(TrayTotalY(i-1)-TrayTotalY(i))^2);
if Act<1.3 && (i>50 || i<42) && (i>67 || i<59) && (i>221 || i<212)
for j=i+1:LargeT
Act=sqrt((TrayTotalX(j-1)-TrayTotalX(j))^2+(TrayTotalY(j-1)-TrayTotalY(j))^2);
if Act<1.3 && (j>50 || j<42) && (j>67 || j<59) && (j>221 || j<212)
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
end
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Pa Oc
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayOcPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
%plot(TrayHilbX+3.2-3.627,TrayHilbY+3.2-7.253)
%plot(TrayTotalX,TrayTotalY)
%plot(TrayTotalXTan,TrayTotalYTan)
TrayTotalX=((TrayZigX-90))+3.2;
TrayTotalY=((TrayZigY-90))+3.2;
plot(TrayTotalX, TrayTotalY, 'r','LineWidth',2);
figure
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
Dis=0;
Dis2=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
    %if ((Act<1.5 || i==46) && i~=8) && (i>83 || i<78)
    %if Act<1.78 && i~=4 && i~=8 && i~=12 && i~=16 && i~=20 && i~=24 && i~=28 
    if Act<1.78 && (i>8 || i<7) && (i>22 || i<15)  && i~=25 && (i>83 || i<75) && i~=91  && (i>109 || i<99) && (i>130 || i<123) && (i>144 || i<138)
        hold on
        plot(TrayTotalX(i:i+1), TrayTotalY(i:i+1), 'r','LineWidth',2);
        Dis2=Dis2+Act;
    end
end
Dis
Dis2
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=1;
figure
pgonD=lineToPoly(TrayTotalX(1:2),TrayTotalY(1:2),Diametro,flag);
for i=3:LargeT
Act=sqrt((TrayTotalX(i-1)-TrayTotalX(i))^2+(TrayTotalY(i-1)-TrayTotalY(i))^2);
if Act<1.78 && (i>9 || i<8) && (i>23 || i<16)  && i~=26 && (i>84 || i<76) && i~=92  && (i>110 || i<100) && (i>131 || i<124) && (i>145 || i<139)
pgonD2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyout=union(pgonD,pgonD2);
pgonD=polyout;
disp(i)
end
end
plot(pgonD)
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
Act=sqrt((TrayTotalX(i-1)-TrayTotalX(i))^2+(TrayTotalY(i-1)-TrayTotalY(i))^2);
if Act<1.78 && (i>9 || i<8) && (i>23 || i<16)  && i~=26 && (i>84 || i<76) && i~=92  && (i>110 || i<100) && (i>131 || i<124) && (i>145 || i<139)
for j=i+1:LargeT
Act=sqrt((TrayTotalX(j-1)-TrayTotalX(j))^2+(TrayTotalY(j-1)-TrayTotalY(j))^2);
if Act<1.78 && (j>9 || j<8) && (j>23 || j<16)  && j~=26 && (j>84 || j<76) && j~=92  && (j>110 || j<100) && (j>131 || j<124) && (j>145 || j<139)
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
end
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Rect
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayZzPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
%plot(TrayHilbX+3.2-3.627,TrayHilbY+3.2-7.253)
%plot(TrayTotalX,TrayTotalY)
%plot(TrayTotalXTan,TrayTotalYTan)
TrayTotalX=((TrayZigX(1:end)-90))+3.2;
TrayTotalY=((TrayZigY(1:end)-90))+3.2;
plot(TrayTotalX, TrayTotalY, 'r','LineWidth',2);
Dis=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
end
Dis
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
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
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
for j=i+1:LargeT
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Acorder de arq
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayAaPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
%plot(TrayHilbX+3.2-3.627,TrayHilbY+3.2-7.253)
%plot(TrayTotalX,TrayTotalY)
%plot(TrayTotalXTan,TrayTotalYTan)
TrayTotalX=((TrayZigX-90))+3.2;
TrayTotalY=((TrayZigY-90))+3.2;
plot(TrayTotalX, TrayTotalY, 'r','LineWidth',2);
Dis=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
end
Dis
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
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
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
for j=i+1:LargeT
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Contorno A
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayAaPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
%plot(TrayHilbX+3.2-3.627,TrayHilbY+3.2-7.253)
%plot(TrayTotalX,TrayTotalY,'r','LineWidth',2)
plot(TrayTotalXTan,TrayTotalYTan,'r','LineWidth',2)
%plot(((TrayZigX-90)*6.4/4.8)+3.2,((TrayZigY-90)*6.4/4.8)+3.2,'r','LineWidth',2)
TrayTotalX=TrayTotalXTan;
TrayTotalY=TrayTotalYTan;
Dis=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
end
Dis
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
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
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
for j=i+1:LargeT
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Contorno B
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayAaPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
%plot(TrayHilbX+3.2-3.627,TrayHilbY+3.2-7.253)
plot(TrayTotalX,TrayTotalY,'r','LineWidth',2)
%plot(TrayTotalXTan,TrayTotalYTan,'r','LineWidth',2)
%plot(((TrayZigX-90)*6.4/4.8)+3.2,((TrayZigY-90)*6.4/4.8)+3.2,'r','LineWidth',2)
TrayTotalX=TrayTotalX;
TrayTotalY=TrayTotalY;
Dis=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
end
Dis
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
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
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
for j=i+1:LargeT
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Hilbert Modificado
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayAaPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
plot(TrayHilbX+3.2-3.627,TrayHilbY+3.2-7.253,'r','LineWidth',2)
%plot(TrayTotalX,TrayTotalY,'r','LineWidth',2)
%plot(TrayTotalXTan,TrayTotalYTan,'r','LineWidth',2)
%plot(((TrayZigX-90)*6.4/4.8)+3.2,((TrayZigY-90)*6.4/4.8)+3.2,'r','LineWidth',2)
TrayTotalX=TrayHilbX+3.2-3.627;
TrayTotalY=TrayHilbY+3.2-7.253;
Dis=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
end
Dis
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
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
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
for j=i+1:LargeT
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Rect Suavizado
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayZzPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
%plot(TrayHilbX+3.2-3.627,TrayHilbY+3.2-7.253)
%plot(TrayTotalX,TrayTotalY)
%plot(TrayTotalXTan,TrayTotalYTan)
TrayTotalX=((TrayZigX(1:end)-90))+3.2;
TrayTotalY=((TrayZigY(1:end)-90))+3.2;
TrayTotalX=TrayTotalX(1:end)';
TrayTotalY=TrayTotalY(1:end)';
[xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.25,0.5);
TrayTotalX=xsa;
TrayTotalY=ysa;
Dis=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
end
plot(TrayTotalX,TrayTotalY,'r','LineWidth',2)
Dis
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
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
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
for j=i+1:LargeT
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Contorno A Suaviz
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayAaPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
%plot(TrayHilbX+3.2-3.627,TrayHilbY+3.2-7.253)
%plot(TrayTotalX,TrayTotalY,'r','LineWidth',2)
%plot(((TrayZigX-90)*6.4/4.8)+3.2,((TrayZigY-90)*6.4/4.8)+3.2,'r','LineWidth',2)
TrayTotalX=TrayTotalXTan;
TrayTotalY=TrayTotalYTan;
[xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
TrayTotalX=xsa;
TrayTotalY=ysa;
Dis=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
end
Dis
plot(TrayTotalX,TrayTotalY,'r','LineWidth',2)
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
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
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
for j=i+1:LargeT
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Contorno B Suaviz
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayAaPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
%plot(TrayHilbX+3.2-3.627,TrayHilbY+3.2-7.253)
%plot(TrayTotalXTan,TrayTotalYTan,'r','LineWidth',2)
%plot(((TrayZigX-90)*6.4/4.8)+3.2,((TrayZigY-90)*6.4/4.8)+3.2,'r','LineWidth',2)
[xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
TrayTotalX=xsa;
TrayTotalY=ysa;
Dis=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
end
Dis
plot(TrayTotalX,TrayTotalY,'r','LineWidth',2)
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
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
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
for j=i+1:LargeT
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal
%% Hilbert Modificado Suaviz
clear all
close all
clc
load('TrayCpZz.mat')
load('TrayHilb.mat')
load('TrayAaPrusa.mat')
load('IntA.mat')
figure
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
plot(Xentrada, Yentrada, 'b','LineWidth',2);
hold on
%plot(TrayTotalX,TrayTotalY,'r','LineWidth',2)
%plot(TrayTotalXTan,TrayTotalYTan,'r','LineWidth',2)
%plot(((TrayZigX-90)*6.4/4.8)+3.2,((TrayZigY-90)*6.4/4.8)+3.2,'r','LineWidth',2)
TrayTotalX=TrayHilbX+3.2-3.627;
TrayTotalY=TrayHilbY+3.2-7.253;
[xsa,ysa]=suavizar(TrayTotalX,TrayTotalY,0.2,0.5);
TrayTotalX=xsa;
TrayTotalY=ysa;
Dis=0;
for i=1:length(TrayTotalX)-1
    Act=sqrt((TrayTotalX(i+1)-TrayTotalX(i))^2+(TrayTotalY(i+1)-TrayTotalY(i))^2);
    Dis=Dis+Act;
end
Dis
plot(TrayTotalX,TrayTotalY,'r','LineWidth',2)
axis equal
%%
close all
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
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
hold on
plot(Xentrada, Yentrada, 'y');
axis equal
%%
figure
plot(TrayTotalX,TrayTotalY,'g','LineWidth',1.5)
Xentrada=IntA(:,1)*6.4/60-3.627+3.2;
Yentrada=IntA(:,2)*6.4/60-7.253+3.2;
hold on
plot(Xentrada, Yentrada, 'b');
LargeT=length(TrayTotalX);
Diametro=0.4;
flag=0;
pgonX=polyshape();
figure
for i=2:LargeT-1
for j=i+1:LargeT
pgonV=lineToPoly(TrayTotalX(j-1:j),TrayTotalY(j-1:j),Diametro,flag);
pgonV2=lineToPoly(TrayTotalX(i-1:i),TrayTotalY(i-1:i),Diametro,flag);
polyV3=intersect(pgonV,pgonV2);
pgonX=union(pgonX,polyV3);
end
disp(i)
end
plot(pgonX)
axis equal
%%
figure
pgonOut = polyshape(Xentrada,Yentrada);
hold on
pgonUnder=subtract(pgonOut,pgonD)
pgonOuter=subtract(pgonD,pgonOut)
figure
plot(Xentrada, Yentrada, 'y');
hold on
plot(pgonD,'FaceColor','blue','FaceAlpha',0.1)
plot(pgonX,'FaceColor','green','FaceAlpha',0.9)
plot(pgonUnder,'FaceColor','red','FaceAlpha',0.9)
plot(pgonOuter,'FaceColor','yellow','FaceAlpha',0.9)
UnderFill=area(pgonUnder)
OverFill=area(pgonX)
OuterFill=area(pgonOuter)
axis equal