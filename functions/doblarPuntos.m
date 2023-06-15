function PerfilDoblado=doblarPuntos(MatrizT,AlturaCapa,numcapas,traslado)
%clc
%clear all
%close all
%load 'desdoblar.mat'
%load 'Matriz.mat'
PerfilDoblado=[];

% La funcion recibe MatrizT del programa de JC.
% seleccionar la capa a doblar
ind= MatrizT(:,3) == numcapas;
A1 = MatrizT(ind,:);
xp = A1(:,1)';
yp = A1(:,2)';
zp = AlturaCapa(numcapas)*ones(1,numel(xp));
angx=-1*traslado(numcapas,5);
% Rotar negativo angulo en X
for i=1:numel(xp)
    puntoAnt=[xp(i),yp(i),zp(i)]';
    PuntoNew(i,:) = (rotx(angx)*puntoAnt)';
end
xp=PuntoNew(:,1)';
yp=PuntoNew(:,2)';
zp=PuntoNew(:,3)';

% Rotar angulo en Y
angy=-1*traslado(numcapas,4);
    for i=1:numel(xp)
         puntoAnt = [xp(i),yp(i),zp(i)]';
         PuntoNew(i,:) = (roty(angy)*puntoAnt)';
    end
xp=PuntoNew(:,1)';
yp=PuntoNew(:,2)';
zp=PuntoNew(:,3)';

movX=traslado(numcapas,1);
movY=traslado(numcapas,2);
movZ=traslado(numcapas,3);

% traslado del origen al punto original
A1x=xp - ones(1,numel(xp))*movX;
A1y=yp - ones(1,numel(yp))*movY;
A1z=zp - ones(1,numel(zp))*movZ;
PerfilDoblado=[PerfilDoblado;[A1x', A1y',A1z'],ones(numel(zp),1)*numcapas];
clear A1
end