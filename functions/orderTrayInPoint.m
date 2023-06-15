function [Xcutnn,Ycutnn]=orderTrayInPoint(Xaux,Yaux,PosCutA,XcutIn,YcutIn)
Fin=max(PosCutA);
Ini=min(PosCutA);
Xcutnn=Xaux(Fin:end);
Ycutnn=Yaux(Fin:end);
Xcutnn2=Xaux(2:Ini);
Ycutnn2=Yaux(2:Ini);
Xcutnn=[XcutIn;Xcutnn;Xcutnn2;XcutIn];
Ycutnn=[YcutIn;Ycutnn;Ycutnn2;YcutIn];
end