%% IMPORTAR PIEZA INICIAL B
CentPieza=[-3.8031 -1.8154 0]';
[vertex, faces, n, name] = stlRead('Sphere.stl');
vertex=vertex'/78.4816*14*0.2;
faces=faces';
options.name = name;
n = size(vertex,2);
Sol=[0 0 0];
vertexR=rottrans(vertex,Sol)-CentPieza;
figure
plot_mesh(vertexR,faces, options);
shading faceted;
%% PARA FUNCION B
%tic
DiametroInt=0.38;
DiametroExt=0.32;
SuavizarV=0.2;
Conex=1;
Discret=0;
ww=[DiametroInt DiametroExt SuavizarV Conex Discret]
%[xt,yt,zt,v]=generarTrayectoriaB(vertexR,faces,options,ww,contornoFinal);
%toc



    %% Matriz Normal de Caras
    Norm=normByFaces(vertexR,faces);
    %% Superficies Inferior y Superior
    facesInf = surfaceSTL(vertexR,faces,Norm,"Inferior",0.001);
    facesSup = surfaceSTL(vertexR,faces,Norm,"Superior",0.001);
    unqInf = unique(facesInf);
    vertexInf = vertexR(:,unqInf);
    for i=1:length(unqInf)
        facesInf(facesInf==unqInf(i))=i;
    end
    unqSup = unique(facesSup);
    vertexSup = vertexR(:,unqSup);
    for i=1:length(unqInf)
        facesSup(facesSup==unqSup(i))=i;
    end
    %% Propagacion Superficie
    Esp=DiametroExt;
    NumCapas = 4;
    vertexFull=vertexInf;
    dimVtx=size(vertexInf,2);
    facesFull=facesInf;
    dimFac=size(facesInf,2);
    for i=1:NumCapas
        Tolerancia = ((0.5-0.1)/(2-34)*(i-1)+0.5)*0-1;
        if i==1
            [vertexAct,facesAct]=createSurface(vertexFull(:,1:dimVtx(i),i),facesFull(:,1:dimFac(i),i),Esp/2,-1,1,Tolerancia);
        else
            [vertexAct,facesAct]=createSurface(vertexFull(:,1:dimVtx(i-1),i-1),facesFull(:,1:dimFac(i-1),i-1),Esp,-1,1,Tolerancia);
        end
        dimVtx(i)=size(vertexAct,2);
        dimFac(i)=size(facesAct,2);
        vertexFull(:,:,i)=NaN;
        vertexFull(:,1:dimVtx(i),i)=vertexAct;
        facesFull(:,:,i)=NaN;
        facesFull(:,1:dimFac(i),i)=facesAct;
    end
    %% Propagacion Aplanar
    icenter = 1;
    irotate = 1;
    vertexFlatten=[];
    for j=1:NumCapas
        vertexAct= geodesicFlatten(vertexFull(:,1:dimVtx(j),j),facesFull(:,1:dimFac(j),j),icenter,irotate);
        if j>1
            vertexFlatten(:,:,j)=NaN;
            vertexFlatten(:,1:dimVtx(j),j)=vertexAct;
        else
            vertexFlatten=vertexAct;
        end
    end
    %% Contornos Paralelos + Ciclo
    Espacio = 0.01;
    TrayFullX=[];
    TrayFullY=[];
    for j=1:NumCapas
        if j < 3
            Diametro = DiametroExt;
        else
            Diametro = DiametroInt;
        end
        %Contorno
        boundary = compute_boundary(facesFull(:,1:dimFac(j),j), options);
        Rr=vertexFlatten(:,boundary,j);
        Xentrada=[Rr(1,:) Rr(1,1)];
        Yentrada=[Rr(2,:) Rr(2,1)];
        %Contornos Paralelos
        Can=ceil(((min([max(Xentrada)-min(Xentrada) max(Yentrada)-min(Yentrada)]))^(1.2))/(Diametro*4));
        myflag = 1;
        while myflag>0
        [Xtotal,Ytotal]=parallelContour(Xentrada,Yentrada,Espacio,Diametro,Can);
        %Ciclo
        Cantidad=size(Xtotal,2)-1;
            try
                if Cantidad == 0
                TrayTotalX=Xtotal(~isnan(Xtotal));TrayTotalY=Ytotal(~isnan(Xtotal));
                else
                [TrayTotalX,TrayTotalY]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad,Conex,1);
                end
                if SuavizarV > 0 && myflag < 10
                Can=Can+1;
                [TrayTotalX,TrayTotalY]=suavizar(TrayTotalX,TrayTotalY,SuavizarV,1);
                end
               myflag = 0;
            catch
                myflag=myflag+1;
                Can=Can-1;
                if myflag>10
                    error('Bad variable')
                end
            end
        end
        %Discretizar
        [TrayTotalXd,TrayTotalYd]=resampleborder(TrayTotalX,TrayTotalY,0.1);
        %Guardar
        Ta=size(TrayFullX,1);
        Sa=length(TrayTotalXd);
        if Sa>Ta
            TrayFullX(Ta+1:Sa,1:j)=NaN;
            TrayFullY(Ta+1:Sa,1:j)=NaN;
        else
            TrayFullX(:,j)=NaN;
            TrayFullY(:,j)=NaN;
        end
        TrayFullX(1:Sa,j)=TrayTotalXd';
        TrayFullY(1:Sa,j)=TrayTotalYd';
    end
    %% Ciclo Desaplanar + Conexion
    TrayTotX=[];
    TrayTotY=[];
    TrayTotZ=[];
    PoinX=0;
    PoinY=0;
    PoinZ=0;
    for j=1:NumCapas
        if j < 3
            Diametro = DiametroExt;
        else
            Diametro = DiametroInt;
        end
        Pol=~isnan(TrayFullX(:,j));
        Final=unFlatten(vertexFull(:,1:dimVtx(j),j),vertexFlatten(:,1:dimVtx(j),j),facesFull(:,1:dimFac(j),j),TrayFullX(Pol,j)',TrayFullY(Pol,j)');
        [XcutFi,YcutFi,ZcutFi,PosCutB]=nearPoint3D(Final(1,:)',Final(2,:)',Final(3,:)',PoinX,PoinY,PoinZ);
        [Xcutnn,Ycutnn,Zcutnn]=orderTrayInPoint3D(Final(1,:)',Final(2,:)',Final(3,:)',PosCutB,XcutFi,YcutFi,ZcutFi);
        MagIn=sqrt(diff(Xcutnn).^2+diff(Ycutnn).^2+diff(Zcutnn).^2);
        Mag=sum(MagIn);
        Num=(Mag-Diametro-0.00000001)*1;
        if Num > 0
        [Xcut,Ycut,Zcut,Xin,Yin,Zin,Xfi,Yfi,Zfi]=cutContour3D(Xcutnn,Ycutnn,Zcutnn,Num,Diametro);
        else
        Xcut=mean(Xcutnn);Ycut=mean(Ycutnn);Zcut=mean(Zcutnn);
        end
        TrayTotX=[TrayTotX;Xcut];
        TrayTotY=[TrayTotY;Ycut];
        TrayTotZ=[TrayTotZ;Zcut];
        PoinX=TrayTotX(end);
        PoinY=TrayTotY(end);
        PoinZ=TrayTotZ(end);
    end
    %% SUPERFICIE SUPERIOR
    %% Propagacion Superficie
    NumCapas = 4;
    vertexFull=vertexSup;
    dimVtx=size(vertexSup,2);
    facesFull=facesSup;
    dimFac=size(facesSup,2);
    for i=1:NumCapas
        Tolerancia = ((0.5-0.1)/(2-34)*(i-1)+0.5)*0-1;
        if i==1
            [vertexAct,facesAct]=createSurface(vertexFull(:,1:dimVtx(i),i),facesFull(:,1:dimFac(i),i),Esp/2,-1,1,Tolerancia);
        else
            [vertexAct,facesAct]=createSurface(vertexFull(:,1:dimVtx(i-1),i-1),facesFull(:,1:dimFac(i-1),i-1),Esp,-1,1,Tolerancia);
        end
        dimVtx(i)=size(vertexAct,2);
        dimFac(i)=size(facesAct,2);
        vertexFull(:,:,i)=NaN;
        vertexFull(:,1:dimVtx(i),i)=vertexAct;
        facesFull(:,:,i)=NaN;
        facesFull(:,1:dimFac(i),i)=facesAct;
    end
    %% Propagacion Aplanar
    icenter = 1;
    irotate = 1;
    vertexFlatten=[];
    for j=1:NumCapas
        vertexAct= geodesicFlatten(vertexFull(:,1:dimVtx(j),j),facesFull(:,1:dimFac(j),j),icenter,irotate);
        if j>1
            vertexFlatten(:,:,j)=NaN;
            vertexFlatten(:,1:dimVtx(j),j)=vertexAct;
        else
            vertexFlatten=vertexAct;
        end
    end
    %% Contornos Paralelos + Ciclo
    Espacio = 0.01;
    TrayFullX=[];
    TrayFullY=[];
    for j=1:NumCapas
        if j < 3
            Diametro = DiametroExt;
        else
            Diametro = DiametroInt;
        end
        %Contorno
        boundary = compute_boundary(facesFull(:,1:dimFac(j),j), options);
        Rr=vertexFlatten(:,boundary,j);
        Xentrada=[Rr(1,:) Rr(1,1)];
        Yentrada=[Rr(2,:) Rr(2,1)];
        %Contornos Paralelos
        Can=ceil(((min([max(Xentrada)-min(Xentrada) max(Yentrada)-min(Yentrada)]))^(1.12))/(Diametro*3.1));
        myflag = 1;
        while myflag>0
        [Xtotal,Ytotal]=parallelContour(Xentrada,Yentrada,Espacio,Diametro,Can);
        %Ciclo
        Cantidad=size(Xtotal,2)-1;
            try
                if Cantidad == 0
                TrayTotalX=Xtotal(~isnan(Xtotal));TrayTotalY=Ytotal(~isnan(Xtotal));
                else
                [TrayTotalX,TrayTotalY]=generateCycle(Xtotal,Ytotal,Diametro,Cantidad,Conex,1);
                end
                if SuavizarV > 0 && myflag < 10
                Can=Can+1;
                [TrayTotalX,TrayTotalY]=suavizar(TrayTotalX,TrayTotalY,SuavizarV,1);
                end
               myflag = 0;
            catch
                myflag=myflag+1;
                Can=Can-1;
                if myflag>10
                    error('Bad variable')
                end
            end
        end
        %Discretizar
        [TrayTotalXd,TrayTotalYd]=resampleborder(TrayTotalX,TrayTotalY,0.1);
        %Guardar
        Ta=size(TrayFullX,1);
        Sa=length(TrayTotalXd);
        if Sa>Ta
            TrayFullX(Ta+1:Sa,1:j)=NaN;
            TrayFullY(Ta+1:Sa,1:j)=NaN;
        else
            TrayFullX(:,j)=NaN;
            TrayFullY(:,j)=NaN;
        end
        TrayFullX(1:Sa,j)=TrayTotalXd';
        TrayFullY(1:Sa,j)=TrayTotalYd';
    end
    %% Ciclo Desaplanar + Conexion
    for j=flip(1:NumCapas)
        Pol=~isnan(TrayFullX(:,j));
        Final=unFlatten(vertexFull(:,1:dimVtx(j),j),vertexFlatten(:,1:dimVtx(j),j),facesFull(:,1:dimFac(j),j),TrayFullX(Pol,j)',TrayFullY(Pol,j)');
        [XcutFi,YcutFi,ZcutFi,PosCutB]=nearPoint3D(Final(1,:)',Final(2,:)',Final(3,:)',PoinX,PoinY,PoinZ);
        [Xcutnn,Ycutnn,Zcutnn]=orderTrayInPoint3D(Final(1,:)',Final(2,:)',Final(3,:)',PosCutB,XcutFi,YcutFi,ZcutFi);
        MagIn=sqrt(diff(Xcutnn).^2+diff(Ycutnn).^2+diff(Zcutnn).^2);
        Mag=sum(MagIn);
        Num=(Mag-Diametro-0.00000001)*1;
        if Num > 0
        [Xcut,Ycut,Zcut,Xin,Yin,Zin,Xfi,Yfi,Zfi]=cutContour3D(Xcutnn,Ycutnn,Zcutnn,Num,Diametro);
        else
        Xcut=mean(Xcutnn);Ycut=mean(Ycutnn);Zcut=mean(Zcutnn);
        end
        TrayTotX=[TrayTotX;Xcut];
        TrayTotY=[TrayTotY;Ycut];
        TrayTotZ=[TrayTotZ;Zcut];
        PoinX=TrayTotX(end);
        PoinY=TrayTotY(end);
        PoinZ=TrayTotZ(end);
    end
    %% Discret Inverso
    pot=1;
    cont=0;
    for i=2:length(TrayTotX)-1
        d1=[TrayTotX(i)-TrayTotX(i-1) TrayTotY(i)-TrayTotY(i-1) TrayTotZ(i)-TrayTotZ(i-1)];
        d2=[TrayTotX(i+1)-TrayTotX(i) TrayTotY(i+1)-TrayTotY(i) TrayTotZ(i+1)-TrayTotZ(i)];
        if (abs(atan2(norm(cross(d1,d2)),dot(d1,d2)))>1e-4)
            pot=[pot i];
        end
    end
    pot=[pot length(TrayTotX)];
    x=TrayTotX(pot)';
    y=TrayTotY(pot)';
    z=TrayTotZ(pot)';
    v=ones(size(x));

%% DIBUJAR B
figure
plot3(x,y,z)
%% DIBUJAR A
figure
for i=1:3
subplot(1,3,i)
set(gcf,'color','w');
plot_mesh(vertexR,faces, options);
shading flat;
alpha(0.1)
hold on
plot3(x,y,z,'k','LineWidth',i+1)
axis equal
view([45 30])
end