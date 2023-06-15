function Norm = normByFaces(vertexR,faces)
    Num=length(faces);
    Norm=[];
    for i=1:Num
        E=vertexR(:,faces(:,i));
        AB=E(:,1)-E(:,3);
        AC=E(:,2)-E(:,3);
        T=cross(AB',AC');
        Norm(i,:)=T/norm(T);
    end
end