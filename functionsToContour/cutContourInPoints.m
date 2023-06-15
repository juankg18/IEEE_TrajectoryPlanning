function [Xcutnn,Ycutnn]=cutContourInPoints(Xaux,Yaux,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi)
Fin=max(PosCutA);
Ini=min(PosCutA);
Vali=0;
Large=length(Xaux);
if Fin==Large-1 && Ini==1
Xcutnn=Xaux(1:end-1);
Ycutnn=Yaux(1:end-1);
Vali=1;
else
Xcutnn=[Xaux(Fin:end-1);Xaux(1:Ini)];
Ycutnn=[Yaux(Fin:end-1);Yaux(1:Ini)];
end
Fin2=max(PosCutB);
Ini2=min(PosCutB);
if ~(Fin2==Fin && Ini2==Ini)
if Ini2 == 1 && Fin2==Large-1
    Ini2=Large-1;
end
if Ini>=Ini2
Xcutnnv1=flip(Xcutnn(1+Vali:end-Ini+Ini2));
Ycutnnv1=flip(Ycutnn(1+Vali:end-Ini+Ini2));
Xcutnnv2=[Xcutnn(end-Ini+Ini2:end);Xcutnn(1:1+Vali)];
Ycutnnv2=[Ycutnn(end-Ini+Ini2:end);Ycutnn(1:1+Vali)];
MagIn1=sum(sqrt(diff(Xcutnnv1').^2+diff(Ycutnnv1').^2));
MagIn2=sum(sqrt(diff(Xcutnnv2').^2+diff(Ycutnnv2').^2));
if MagIn1>=MagIn2
Xcutnn=Xcutnnv1;
Ycutnn=Ycutnnv1;
else
Xcutnn=Xcutnnv2;
Ycutnn=Ycutnnv2;
end
else
Xcutnnv1=Xcutnn(Ini2-Ini+1+Vali:end);
Ycutnnv1=Ycutnn(Ini2-Ini+1+Vali:end);
Xcutnnv2=flip(Xcutnn(1:Ini2-Ini+1+Vali));
Ycutnnv2=flip(Ycutnn(1:Ini2-Ini+1+Vali));
MagIn1=sum(sqrt(diff(Xcutnnv1').^2+diff(Ycutnnv1').^2));
MagIn2=sum(sqrt(diff(Xcutnnv2').^2+diff(Ycutnnv2').^2));
if MagIn1>=MagIn2
Xcutnn=Xcutnnv1;
Ycutnn=Ycutnnv1;
else
Xcutnn=Xcutnnv2;
Ycutnn=Ycutnnv2;
end
end
end
Xcutnn=[XcutFi;Xcutnn;XcutIn];
Ycutnn=[YcutFi;Ycutnn;YcutIn];
end