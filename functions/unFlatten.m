function Final=unFlatten(vertex,vertexF,faces,TrayTotalXd,TrayTotalYd)
    Final=zeros(3,length(TrayTotalXd));
    Normal=zeros(3,length(TrayTotalXd));
    xq=TrayTotalXd';
    yq=TrayTotalYd';
    for i=1:length(faces)
        xv=vertexF(1,[faces(:,i);faces(1,i)]);
        yv=vertexF(2,[faces(:,i);faces(1,i)]);
        [in,on] = inpolygon(xq,yq,xv,yv);
        Rd=numel(xq(in));
        if Rd>0
            Pd=[xq(in)';yq(in)'];
            Lic=vertex(:,faces(:,i));
            Loc=vertexF(:,faces(:,i));
            Ac=Loc(:,1)-Loc(:,3);
            Bc=Loc(:,2)-Loc(:,3);
            Cte=inv([Ac Bc])*(Pd-Loc(:,3));
            Acd=Lic(:,1)-Lic(:,3);
            Bcd=Lic(:,2)-Lic(:,3);
            Final(:,in)=Acd*Cte(1,:)+Bcd*Cte(2,:)+Lic(:,3);
        end
    end
end