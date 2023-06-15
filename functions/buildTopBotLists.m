% ==========================================================
% Copyright (C) Damien Berget 2013
% This code is only usable for non-commercial purpose and 
% provided as is with no guaranty of any sort
% ==========================================================
% 
% Matlab STL Slicer step 1.
% See http://exploreideasdaily.wordpress.com for details.
function [triInferiorList, triSuperiorList] = buildTopBotLists(vertices, mosaico)

% odenar el valor de Z como se encuentra mosaico, el valor de la matriz corresponde al valor de Z de cada triangulo
ZTri = [vertices(mosaico(:,1),3) vertices(mosaico(:,2),3) vertices(mosaico(:,3),3)]
minZ = min(ZTri,[], 2) % encontrar el minimo valor de cada fila
maxZ = max(ZTri,[], 2) % encontrar el maximo valor de cada fila

% Crea las listas de los valores minimos y maximos de Z en cada triangulo
[val, idx] = sort(minZ)
triInferiorList = [val idx]
[val, idx] = sort(maxZ)
triSuperiorList = [val idx]
