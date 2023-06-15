function [XcutFi,YcutFi,ZcutFi,PosCutB]=nearPoint3D(Xaux,Yaux,Zaux,Xfi,Yfi,Zfi)
    MagIn=sqrt((Xaux-Xfi).^2+(Yaux-Yfi).^2+(Zaux-Zfi).^2);
    Large=length(Xaux);
    [Min,PosMin]=min(MagIn);
    if PosMin==1
        Anterior=Large-1;
    else
        Anterior=PosMin-1;
    end
        Uan=[Xaux(PosMin+1)-Xaux(PosMin) Yaux(PosMin+1)-Yaux(PosMin) Zaux(PosMin+1)-Zaux(PosMin)];
        Dan=-dot(Uan,[Xfi Yfi Zfi]);
        Lan=-((dot(Uan,[Xaux(PosMin) Yaux(PosMin) Zaux(PosMin)])+Dan)/dot(Uan,Uan));
        XcutAn=Uan(1)*Lan+Xaux(PosMin);
        YcutAn=Uan(2)*Lan+Yaux(PosMin);
        ZcutAn=Uan(3)*Lan+Zaux(PosMin);
    DistAn=sqrt((Xfi-XcutAn)^2+(Yfi-YcutAn)^2+(Zfi-ZcutAn)^2);
        Uan=[Xaux(Anterior)-Xaux(PosMin) Yaux(Anterior)-Yaux(PosMin) Zaux(Anterior)-Zaux(PosMin)];
        Dan=-dot(Uan,[Xfi Yfi Zfi]);
        Lan=-((dot(Uan,[Xaux(PosMin) Yaux(PosMin) Zaux(PosMin)])+Dan)/dot(Uan,Uan));
        XcutBn=Uan(1)*Lan+Xaux(PosMin);
        YcutBn=Uan(2)*Lan+Yaux(PosMin);
        ZcutBn=Uan(3)*Lan+Zaux(PosMin);
    DistBn=sqrt((Xfi-XcutBn)^2+(Yfi-YcutBn)^2+(Zfi-ZcutBn)^2);
    if DistBn>=DistAn && (((Yaux(PosMin+1)>=YcutAn && Yaux(PosMin)<=YcutAn)||(Yaux(PosMin+1)<=YcutAn && Yaux(PosMin)>=YcutAn))&&((Xaux(PosMin+1)>=XcutAn && Xaux(PosMin)<=XcutAn)||(Xaux(PosMin+1)<=XcutAn && Xaux(PosMin)>=XcutAn)))
        XcutFi=XcutAn;
        YcutFi=YcutAn;
        ZcutFi=ZcutAn;
        PosCutB=[PosMin+1 PosMin];
    else
    if DistBn<=DistAn && (((Yaux(Anterior)>=YcutAn && Yaux(PosMin)<=YcutAn)||(Yaux(Anterior)<=YcutAn && Yaux(PosMin)>=YcutAn))&&((Xaux(Anterior)>=XcutAn && Xaux(PosMin)<=XcutAn)||(Xaux(Anterior)<=XcutAn && Xaux(PosMin)>=XcutAn)))
        XcutFi=XcutBn;
        YcutFi=YcutBn;
        ZcutFi=ZcutBn;
        PosCutB=[Anterior PosMin];
    else
        XcutFi=Xaux(PosMin);
        YcutFi=Yaux(PosMin);
        ZcutFi=Zaux(PosMin);
        PosCutB=[PosMin+1 Anterior];
    end
    end
end