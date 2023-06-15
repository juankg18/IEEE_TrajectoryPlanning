function PerfilDesdoblado=desdoblarPuntos(MatrizT,numcapas,traslado)
%clc
%clear all
%close all
%load 'desdoblar.mat'
%load 'Matriz.mat'
PerfilDesdoblado=[];

% La funcion recibe MatrizT del programa de JC.
% seleccionar la capa a doblar
ind= MatrizT(:,4) == numcapas;
A1 = MatrizT(ind,:);
xp = A1(:,1)';
yp = A1(:,2)';
zp = A1(:,3)';

movX=traslado(numcapas,1);
movY=traslado(numcapas,2);
movZ=traslado(numcapas,3);

% traslado del origen al punto original
xp=xp + ones(1,numel(xp))*movX;
yp=yp + ones(1,numel(yp))*movY;
zp=zp + ones(1,numel(zp))*movZ;

% Rotar angulo en Y
angy=traslado(numcapas,4);
    for i=1:numel(xp)
         puntoAnt = [xp(i),yp(i),zp(i)]';
         PuntoNew(i,:) = (roty(angy)*puntoAnt)';
    end
xp=PuntoNew(:,1)';
yp=PuntoNew(:,2)';
zp=PuntoNew(:,3)';

angx=traslado(numcapas,5);
% Rotar negativo angulo en X
for i=1:numel(xp)
    puntoAnt=[xp(i),yp(i),zp(i)]';
    PuntoNew(i,:) = (rotx(angx)*puntoAnt)';
end
A1x=PuntoNew(:,1)';
A1y=PuntoNew(:,2)';
A1z=PuntoNew(:,3)';

PerfilDesdoblado=[PerfilDesdoblado;[A1x', A1y',A1z'],ones(numel(zp),1)*numcapas];
clear A1
end