function [XcutFi,YcutFi,PosCutB]=nearPoint(Xaux,Yaux,Xfi,Yfi)
MagIn=sqrt((Xaux-Xfi).^2+(Yaux-Yfi).^2);
Large=length(Xaux);
[Min,PosMin]=min(MagIn);
if PosMin==1
    Anterior=Large-1;
else
    Anterior=PosMin-1;
end
    Pendiente=(Yaux(PosMin+1)-Yaux(PosMin))/(Xaux(PosMin+1)-Xaux(PosMin));
    if Pendiente==0
        XcutAn=Xfi;
        YcutAn=Yaux(PosMin);
    else
    if abs(Pendiente)==Inf
        XcutAn=Xaux(PosMin);
        YcutAn=Yfi;
    else
        XcutAn=(Xfi/Pendiente+Yfi+Pendiente*Xaux(PosMin)-Yaux(PosMin))/(Pendiente+(1/Pendiente));
        YcutAn=Pendiente*(XcutAn-Xaux(PosMin))+Yaux(PosMin);
    end
    end
DistAn=sqrt((Xfi-XcutAn)^2+(Yfi-YcutAn)^2);
    Pendiente=(Yaux(Anterior)-Yaux(PosMin))/(Xaux(Anterior)-Xaux(PosMin));
    if Pendiente==0
        XcutBn=Xfi;
        YcutBn=Yaux(PosMin);
    else
    if abs(Pendiente)==Inf
        XcutBn=Xaux(PosMin);
        YcutBn=Yfi;
    else
        XcutBn=(Xfi/Pendiente+Yfi+Pendiente*Xaux(PosMin)-Yaux(PosMin))/(Pendiente+(1/Pendiente));
        YcutBn=Pendiente*(XcutBn-Xaux(PosMin))+Yaux(PosMin);
    end
    end
DistBn=sqrt((Xfi-XcutBn)^2+(Yfi-YcutBn)^2);
if DistBn>=DistAn && (((Yaux(PosMin+1)>=YcutAn && Yaux(PosMin)<=YcutAn)||(Yaux(PosMin+1)<=YcutAn && Yaux(PosMin)>=YcutAn))&&((Xaux(PosMin+1)>=XcutAn && Xaux(PosMin)<=XcutAn)||(Xaux(PosMin+1)<=XcutAn && Xaux(PosMin)>=XcutAn)))
    XcutFi=XcutAn;
    YcutFi=YcutAn;
    PosCutB=[PosMin+1 PosMin];
else
if DistBn<=DistAn && (((Yaux(Anterior)>=YcutAn && Yaux(PosMin)<=YcutAn)||(Yaux(Anterior)<=YcutAn && Yaux(PosMin)>=YcutAn))&&((Xaux(Anterior)>=XcutAn && Xaux(PosMin)<=XcutAn)||(Xaux(Anterior)<=XcutAn && Xaux(PosMin)>=XcutAn)))
    XcutFi=XcutBn;
    YcutFi=YcutBn;
    PosCutB=[Anterior PosMin];
else
    XcutFi=Xaux(PosMin);
    YcutFi=Yaux(PosMin);
    PosCutB=[PosMin+1 Anterior];
end
end
end