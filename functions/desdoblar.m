function [PerfilAplanado,traslado,AlturaCapa]=desdoblar(contornoFinal,xLimits,yLimits,numcapas)
% clear all
% clc
% close all
% % La funcion .mat es generada de la funcion: Cortador3DV3
% load 'PruebaEncadenamiento.mat'


PerfilAplanado=[];
traslado=[];

% separar y leer contorno de la capa=NoCapaD y lo guarda en A1
for NoCapaD=1: numcapas+1
    ind = contornoFinal(:,end) == NoCapaD;
    A1 = contornoFinal(ind,:);
    % plano= jx + ky + lz + m =0
    j=A1(1,end-4);
    k=A1(1,end-3);
    l=A1(1,end-2);
    m=A1(1,end-1);
    nc=A1(1,end);
    % divisiones para crear el plano
    divisiones =10; 
    % plano original
    xp = xLimits(1) : (xLimits(2)-xLimits(1))/divisiones : xLimits(2);
    yp = yLimits(1) : (yLimits(2)-yLimits(1))/divisiones : yLimits(2);
    zp= (-m-(j*xp) - (k*yp))/l;
    [Xp,Yp] = meshgrid(xp,yp);
    Zp= (-m-(j*Xp) - (k*Yp))/l;
    %mesh(Xp,Yp,Zp);
%     xlabel('x')
%     ylabel('y')
%     zlabel('z')
%     hold on
    % grafica del contorno original de la capa=NoCapaD
    A1x=A1(:,1);
    A1y=A1(:,2);
    A1z=A1(:,3);
    %plot3(A1x,A1y,A1z,'o-')

    % transladar el plano al origen
    movX=-min(xp);  movY=-min(yp);  movZ=-min(zp);
    traslado(NoCapaD,1:3)=[movX, movY,movZ];
    A1x=A1x+ones(1,size(A1x,2))*movX;
    A1y=A1y+ones(1,size(A1y,2))*movY;
    A1z=A1z+ones(1,size(A1z,2))*movZ;
    % angulo de rotacion en Y de los ejes
    my=(zp(1)-zp(end))/(xp(1)-xp(end));
    angy=atand(my);
    traslado(NoCapaD,4)=angy;
    for i=1:numel(A1x)
         puntoAnt=[A1x(i),A1y(i),A1z(i)]';
         PuntoNew(i,:) = (roty(angy)*puntoAnt)';
    end
    xp=PuntoNew(:,1)';
    yp=PuntoNew(:,2)';
    zp=PuntoNew(:,3)';
    % angulo de rotacion en X de los ejes
    mx=(zp(1)-zp(end))/(yp(1)-yp(end));
    if isnan(mx)~=1
        angx=atand(mx);
        traslado(NoCapaD,5)=angx;
        for i=1:numel(xp)
            puntoAnt=[xp(i),yp(i),zp(i)]';
            PuntoNew(i,:) = (rotx(angx)*puntoAnt)';
        end
        xp=PuntoNew(:,1)';
        yp=PuntoNew(:,2)';
        zp=PuntoNew(:,3)';        
    else
        angx=0;
        traslado(NoCapaD,end+1)=angx;
    end
    if std(zp)<0.05
            altZCapa=mean(zp);
            zp= altZCapa*ones(1,numel(zp));
    else
        altZCapa=mean(zp);
        zp= altZCapa*ones(1,numel(zp));
        disp('Error en la planitud de Z')
    end
    figure(2)
    plot3(xp,yp,zp,'o-');
    hold on
    PerfilAplanado= [PerfilAplanado;[xp',yp',ones(numel(xp),1)*NoCapaD]];
    AlturaCapa(NoCapaD)=altZCapa;
    clear A1    
end
end