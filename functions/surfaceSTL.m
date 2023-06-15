function facesInf = surfaceSTL(vertexR,faces,Norm,Decision,Factor)
    % Guardar solo caras con orientacion diferente de vertical
    Ve=~((Norm(:,3)<Factor) & (Norm(:,3)>-Factor));
    facesT=faces(:,Ve);
    % Minimo - Maximo
    Numd=length(facesT);
    D=vertexR(3,facesT(:,:)');
    Dd=reshape(D,Numd,3);
    if Decision == "Inferior"
        [Val,Pos]=min(sum(Dd.^2,2));
    elseif Decision == "Superior"
        [Val,Pos]=max(sum(Dd.^2,2));
    else
        disp('Bad decision value')
    end
    W=facesT(:,Pos)';
    FacI=Pos;
    i=1;
    while i<=length(W)
        Q=ceil(find(facesT==W(i))/3);
        X=facesT(:,Q);
        X=reshape(X,1,[]);
        W=[W X];
        FacI=[FacI Q'];
        W=unique(W,'stable');
        FacI=unique(FacI,'stable');
        i=i+1;
    end
    facesInf=facesT(:,FacI);
end