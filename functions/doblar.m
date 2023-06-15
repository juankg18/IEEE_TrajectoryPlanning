function PerfilDoblado=doblar(MatrizT,AlturaCapa,numcapas,traslado)
%clc
%clear all
%close all
%load 'desdoblar.mat'
%load 'Matriz.mat'
PerfilDoblado=[];

% La funcion recibe MatrizT del programa de JC.
for NoCapa=1:numcapas+1
% seleccionar la capa a doblar
ind= MatrizT(:,3) == NoCapa;
A1 = MatrizT(ind,:);
xp = A1(:,1)';
yp = A1(:,2)';
zp = AlturaCapa(NoCapa)*ones(1,numel(xp));
angx=-1*traslado(NoCapa,5);
% Rotar negativo angulo en X
for i=1:numel(xp)
    puntoAnt=[xp(i),yp(i),zp(i)]';
    PuntoNew(i,:) = (rotx(angx)*puntoAnt)';
end
xp=PuntoNew(:,1)';
yp=PuntoNew(:,2)';
zp=PuntoNew(:,3)';

% Rotar angulo en Y
angy=-1*traslado(NoCapa,4);
    for i=1:numel(xp)
         puntoAnt = [xp(i),yp(i),zp(i)]';
         PuntoNew(i,:) = (roty(angy)*puntoAnt)';
    end
xp=PuntoNew(:,1)';
yp=PuntoNew(:,2)';
zp=PuntoNew(:,3)';

movX=traslado(NoCapa,1);
movY=traslado(NoCapa,2);
movZ=traslado(NoCapa,3);

% traslado del origen al punto original
A1x=xp - ones(1,numel(xp))*movX;
A1y=yp - ones(1,numel(yp))*movY;
A1z=zp - ones(1,numel(zp))*movZ;
PerfilDoblado=[PerfilDoblado;[A1x', A1y',A1z'],ones(numel(zp),1)*NoCapa];
figure(3)
plot3(A1x, A1y,A1z)
hold on
clear A1
end
end