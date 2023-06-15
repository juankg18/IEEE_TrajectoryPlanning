function [Xcutnn,Ycutnn,Xcutnn2,Ycutnn2]=cutTrayInPoints(Xaux,Yaux,PosCutA,PosCutB,XcutIn,YcutIn,XcutFi,YcutFi)
Fin=max([PosCutA PosCutB]);
Ini=min([PosCutA PosCutB]);
Xcutnn=Xaux(Fin:end);
Ycutnn=Yaux(Fin:end);
Xcutnn2=Xaux(1:Ini);
Ycutnn2=Yaux(1:Ini);
if ((Xcutnn(1)-XcutFi)^2+(Ycutnn(1)-YcutFi)^2)<((Xcutnn(1)-XcutIn)^2+(Ycutnn(1)-YcutIn)^2)
Xcutnn=[XcutFi;Xcutnn];
Ycutnn=[YcutFi;Ycutnn];
Xcutnn2=[Xcutnn2;XcutIn];
Ycutnn2=[Ycutnn2;YcutIn];
else
Xcutnn=[XcutIn;Xcutnn];
Ycutnn=[YcutIn;Ycutnn];
Xcutnn2=[Xcutnn2;XcutFi];
Ycutnn2=[Ycutnn2;YcutFi];
end
end