function [Xcut,Ycut,Zcut,Xin,Yin,Zin,Xfi,Yfi,Zfi]=cutContour3D(Xaux,Yaux,Zaux,Num,Diametro)
Large=length(Xaux);
MagIn=sqrt(diff(Xaux).^2+diff(Yaux).^2+diff(Zaux).^2);
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
ResZ=Zaux(PosInB+1)-Zaux(PosInB);
MagB=sqrt(ResX^2+ResY^2+ResZ^2);
Xfi=Xaux(PosInB)+MagCutB*(ResX)/MagB;
Yfi=Yaux(PosInB)+MagCutB*(ResY)/MagB;
Zfi=Zaux(PosInB)+MagCutB*(ResZ)/MagB;
ResX=Xaux(PosInA+1)-Xaux(PosInA);
ResY=Yaux(PosInA+1)-Yaux(PosInA);
ResZ=Zaux(PosInA+1)-Zaux(PosInA);
MagB=sqrt(ResX^2+ResY^2+ResZ^2);
Xin=Xaux(PosInA)+MagCutA*(ResX)/MagB;
Yin=Yaux(PosInA)+MagCutA*(ResY)/MagB;
Zin=Zaux(PosInA)+MagCutA*(ResZ)/MagB;
if Ind
Xcut=[Xfi;Xaux(PosInB+1:PosInA);Xin];
Ycut=[Yfi;Yaux(PosInB+1:PosInA);Yin];
Zcut=[Zfi;Zaux(PosInB+1:PosInA);Zin];
else
Xcut=[Xfi;Xaux(PosInB+1:end);Xaux(1:PosInA);Xin];
Ycut=[Yfi;Yaux(PosInB+1:end);Yaux(1:PosInA);Yin];
Zcut=[Zfi;Zaux(PosInB+1:end);Zaux(1:PosInA);Zin];
end
end