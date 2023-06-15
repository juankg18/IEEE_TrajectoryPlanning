function [Xcutnn,Ycutnn,Zcutnn]=orderTrayInPoint3D(Xaux,Yaux,Zaux,PosCutA,XcutIn,YcutIn,ZcutIn)
Fin=max(PosCutA);
Ini=min(PosCutA);
Xcutnn=Xaux(Fin:end);
Ycutnn=Yaux(Fin:end);
Zcutnn=Zaux(Fin:end);
Xcutnn2=Xaux(2:Ini);
Ycutnn2=Yaux(2:Ini);
Zcutnn2=Zaux(2:Ini);
Xcutnn=[XcutIn;Xcutnn;Xcutnn2;XcutIn];
Ycutnn=[YcutIn;Ycutnn;Ycutnn2;YcutIn];
Zcutnn=[ZcutIn;Zcutnn;Zcutnn2;ZcutIn];
end