function [Xcut,Ycut,Xin,Yin,Xfi,Yfi]=cutContour(Xaux,Yaux,Num,Diametro)
Large=length(Xaux);
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2);
Mag=sum(MagIn);
MagAc=[0;cumsum(MagIn)];
NumB=Num;
PosInA=sum(Num>=MagAc);
PosInB=sum((NumB+Diametro)>=MagAc);
Ind=0;
if PosInB==Large
    NumB=NumB-Mag;
    PosInB=sum((NumB+Diametro)>=MagAc);
    Ind=1;
end
MagCutA=Num-MagAc(PosInA);
MagCutB=NumB+Diametro-MagAc(PosInB);
ResX=Xaux(PosInB+1)-Xaux(PosInB);
ResY=Yaux(PosInB+1)-Yaux(PosInB);
MagB=sqrt(ResX^2+ResY^2);
Xfi=Xaux(PosInB)+MagCutB*(ResX)/MagB;
Yfi=Yaux(PosInB)+MagCutB*(ResY)/MagB;
ResX=Xaux(PosInA+1)-Xaux(PosInA);
ResY=Yaux(PosInA+1)-Yaux(PosInA);
MagB=sqrt(ResX^2+ResY^2);
Xin=Xaux(PosInA)+MagCutA*(ResX)/MagB;
Yin=Yaux(PosInA)+MagCutA*(ResY)/MagB;
if Ind
Xcut=[Xfi;Xaux(PosInB+1:PosInA);Xin];
Ycut=[Yfi;Yaux(PosInB+1:PosInA);Yin];
else
Xcut=[Xfi;Xaux(PosInB+1:end);Xaux(1:PosInA);Xin];
Ycut=[Yfi;Yaux(PosInB+1:end);Yaux(1:PosInA);Yin];
end
end