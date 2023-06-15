function [vertexR2, facesInf, NormI] = createSurface(vertexR,facesInf,Dist,Direccion,Planar,Tolerancia)
    Area=[];
    Lon=[];
    for i=1:length(facesInf)
        R=vertexR(:,facesInf(:,i))';
        Lon(i)=min(abs([norm(R(2,:)-R(1,:)) norm(R(3,:)-R(1,:)) norm(R(2,:)-R(3,:))]));
        Area(i)=sqrt(sum(cross(R(2,:)-R(1,:),R(3,:)-R(1,:)).^2))/2;
    end
    %Reducir Surface
    TriMi=Lon<Tolerancia;
    Nk=max(vertexR(3,:));
    if sum(TriMi)>0
        p=[];
        p.faces=facesInf';
        p.vertices=vertexR';
        nfv = reducepatch(p,sum(~TriMi));
        facesInf=nfv.faces';
        vertexR=nfv.vertices';
    end
    vertexR2=zeros(size(vertexR));
    NormI = normByFaces(vertexR,facesInf);
    vecVex=unique(facesInf);
    if Planar == 1
        for i=1:length(vecVex)
            Ubq=logical(sum(vecVex(i)==facesInf));
            NormIt=NormI(Ubq,:)*Direccion;
            NormIt1=unique(round(NormIt,10),'rows');
            if size(NormIt1,1) == 2
                SOLV=inv([NormIt1;[0 0 -1]])*[1;1;0]*5;
            else
                SOLV=sum(pinv(NormIt1),2)*5;
            end
            Vn=NormIt1(1,:);
            Alf=Dist/dot(SOLV,Vn);
            NewVertex=[SOLV(1)*Alf+vertexR(1,vecVex(i)),SOLV(2)*Alf+vertexR(2,vecVex(i)),SOLV(3)*Alf+vertexR(3,vecVex(i))];
            vertexR2(:,vecVex(i))=NewVertex';
        end
    else
        for i=1:length(vecVex)
            Ubq=logical(sum(vecVex(i)==facesInf));
            NormIt=NormI(Ubq,:)*Direccion;
            NormIt1=unique(round(NormIt,15),'rows');
            SOLV=sum(pinv(NormIt1),2)*5;
            Vn=NormIt1(1,:);
            Alf=Dist/dot(SOLV,Vn);
            NewVertex=[SOLV(1)*Alf+vertexR(1,vecVex(i)),SOLV(2)*Alf+vertexR(2,vecVex(i)),SOLV(3)*Alf+vertexR(3,vecVex(i))];
            vertexR2(:,vecVex(i))=NewVertex';
        end
    end
    vertexR2(3,vertexR2(3,:)>Nk)=Nk;
    %NormCC = normByFaces(vertexR2,facesInf);
    
end