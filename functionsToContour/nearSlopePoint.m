function [XcutFi,YcutFi,PosCutB]=nearSlopePoint(Xaux,Yaux,Xfi,Yfi,Pendiente)
Large=length(Xaux);
Dist=Inf;
XcutFi=[];
YcutFi=[];
PosCutB=[];
tol=0.01;
for j=2:Large
    aja = [Xfi Yfi];
    bja = [Xaux(j-1) Yaux(j-1); Xaux(j) Yaux(j)];
    dbja = diff(bja);
    maja = Pendiente;
    mbja = dbja(2)/dbja(1);
    if abs(maja) == Inf
        xsol = aja(1,1);
        ysol = mbja*(xsol-bja(1,1))+bja(1,2);
    else
        if abs(mbja) == Inf
            xsol = bja(1,1);
            ysol = maja*(xsol-aja(1,1))+aja(1,2);
        else
            xsol = (maja*aja(1,1)-mbja*bja(1,1)+bja(1,2)-aja(1,2))/(maja-mbja);
            ysol = maja*(xsol-aja(1,1))+aja(1,2);
        end
    end
    if abs(mbja) < 1e-5
        exp=(xsol-tol<=Xaux(j-1)&&xsol+tol>=Xaux(j))||(xsol+tol>=Xaux(j-1)&&xsol-tol<=Xaux(j));
    else
        exp=((xsol-tol<=Xaux(j-1)&&xsol+tol>=Xaux(j))||(xsol+tol>=Xaux(j-1)&&xsol-tol<=Xaux(j)))&&((ysol-tol<=Yaux(j-1)&&ysol+tol>=Yaux(j))||(ysol+tol>=Yaux(j-1)&&ysol-tol<=Yaux(j)));
    end
    if exp
        Distin=sqrt((xsol-Xfi)^2+(ysol-Yfi)^2);
        if Distin<Dist
            XcutFi=xsol;
            YcutFi=ysol;
            PosCutB=[j-1 j];
            Dist=Distin;
        end
    end
end
end