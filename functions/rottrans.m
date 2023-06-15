function vertexR = rottrans(vertex,Sol)
% Orientacion Translacion
vertexR = rotation(vertex',1,Sol(1));
vertexR = rotation(vertexR,2,Sol(2));
vertexR = rotation(vertexR,3,Sol(3));
vertexR = vertexR';
% Ubicacion Minima
vertexR(3,:) = vertexR(3,:)-min(vertexR(3,:));
end