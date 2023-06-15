function facesInf = surfaceSTL3(vertexR,faces,Norm,Decision,Factor,Alt)
    % Guardar solo caras con orientacion diferente de vertical u horizontal
    FacI=[];
    if Decision == "Inferior"
        for i=1:length(faces)
            if sum(vertexR(3,faces(:,i))<=Alt)>0 %&& ~(abs(Norm(i,3))>1-Factor)
                FacI=[FacI i];
            end
        end
    elseif Decision == "Superior"
        for i=1:length(faces)
            if sum(vertexR(3,faces(:,i))>=Alt)>0 %&& ~(abs(Norm(i,3))>1-Factor)
                FacI=[FacI i];
            end
        end
    else
        disp('Bad decision value')
    end
    facesInf=faces(:,FacI);
end