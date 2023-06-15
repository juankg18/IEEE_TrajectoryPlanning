function [triInferiorList, triSuperiorList] = ListasExtremos(vertices, mosaico)
% triInferiorList valores minimos de Z de cada triangulo
% triSuperiorList valores maximos de Z de cada triangulo

% leer el triangulo i
% minimos valores de Z y sus correspondientes valores en X y Y

%for i=1:mosaico(end,end)/3
for i=1:size(mosaico,1)
    triangulo=vertices(mosaico(i,:),:);
    [Min,Imin]=min(triangulo(:,3));
    minX=triangulo(Imin,1);
    minY=triangulo(Imin,2);
    minZ=triangulo(Imin,3);
    % Si el valor es pequeño redondearlo a 0
    if minZ<0.01
        minZ=0;
    end
    Vminimo(i,:)= [minX,minY,minZ];
    % maximos valores de Z y sus correspondientes valores en X y Y
    [Max,Imax]=max(triangulo(:,3));
    maxX=triangulo(Imax,1);
    maxY=triangulo(Imax,2);
    maxZ=triangulo(Imax,3);
    if maxZ<0.01
        maxZ=0;
    end
    Vmaximo(i,:)= [maxX,maxY,maxZ];
end
[val,idx]=sortrows(Vminimo,3);
triInferiorList = [val, idx];
[val,idx]=sortrows(Vmaximo,3);
triSuperiorList = [val, idx];
end
