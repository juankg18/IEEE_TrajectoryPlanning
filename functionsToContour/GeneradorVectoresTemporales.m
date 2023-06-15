%% Centrar
Xx=(TrayTotX'-10);
Yy=(TrayTotY'-10);
Zz=TrayTotZ';
%% Vectores de Tiempo Distancia con Rampa de Velocidad
AceleracionPaUsar=1000*60*60;
VelocidadPaUsar=1000;
Distancia=sqrt(diff(Xx).^2+diff(Yy).^2+diff(Zz).^2);
VecX=Xx(Distancia~=0);
VecY=Yy(Distancia~=0);
VecZ=Zz(Distancia~=0);
VecFf=VelocidadPaUsar*ones(1,length(VecX));
newnn=length(VecX);
Distancia=sqrt(diff(VecX(1:newnn)).^2+diff(VecY(1:newnn)).^2+diff(VecZ(1:newnn)).^2);
VelPromedio=VecFf(1:newnn-1);
tx=VelPromedio(1:newnn-1)/AceleracionPaUsar;
DifTiempo=Distancia(1:newnn-1)./VelPromedio(1:newnn-1)+tx;
Triangulo=Distancia(1:newnn-1)./VelPromedio(1:newnn-1)<tx;
DifTiempo(Triangulo)=sqrt(4*Distancia(Triangulo)/AceleracionPaUsar);
tx(Triangulo)=DifTiempo(Triangulo)/2;
VelPromedio(Triangulo)=AceleracionPaUsar*DifTiempo(Triangulo)/2;
Tiempo=[0 cumsum(DifTiempo)];
%plot(Tiempo,[VelPromedio 0])
Tiempox3=kron(Tiempo, ones(1,3))+[0 0 kron(tx, [1 0 0]) 0]-[0 0 0 kron(tx, [1 0 0])];
Tiempox3=Tiempox3(2:end-1);
Vx=diff(VecX(1:newnn))./(DifTiempo(1:newnn-1)-tx);
Vx3=[kron(Vx, [0 1 1]) 0];
Vy=diff(VecY(1:newnn))./(DifTiempo(1:newnn-1)-tx);
Vy3=[kron(Vy, [0 1 1]) 0];
Vz=diff(VecZ(1:newnn))./(DifTiempo(1:newnn-1)-tx);
Vz3=[kron(Vz, [0 1 1]) 0];
Ax=[0 kron(diff(Vx3)./diff(Tiempox3),[1 1]) 0];
Ay=[0 kron(diff(Vy3)./diff(Tiempox3),[1 1]) 0];
Az=[0 kron(diff(Vz3)./diff(Tiempox3),[1 1]) 0];
Tiempox4=kron(Tiempox3,[1 1]);
Tiempo=Tiempo*60;
Tiempox3=Tiempox3*60;
Tiempox4=Tiempox4*60;
Vx3=Vx3/60;
Vy3=Vy3/60;
Vz3=Vz3/60;
Ax=Ax/(60*60);
Ay=Ay/(60*60);
Az=Az/(60*60);
figure
Gf(1)=subplot(3,3,1)
plot(Tiempo,VecX)
Gf(2)=subplot(3,3,2)
plot(Tiempo,VecY)
Gf(3)=subplot(3,3,3)
plot(Tiempo,VecZ)
Gf(4)=subplot(3,3,4)
plot(Tiempox3,Vx3)
Gf(5)=subplot(3,3,5)
plot(Tiempox3,Vy3)
Gf(6)=subplot(3,3,6)
plot(Tiempox3,Vz3)
Gf(7)=subplot(3,3,7)
plot(Tiempox4,Ax)
Gf(8)=subplot(3,3,8)
plot(Tiempox4,Ay)
Gf(9)=subplot(3,3,9)
plot(Tiempox4,Az)
%xlim(Gf,[60*1 60*2])
%% REMUESTREAR SEÑALES
Tmuestreo=0.005;
TrayectoriaX=cumtrapz(Tiempox3,Vx3)+VecX(1);
TrayectoriaY=cumtrapz(Tiempox3,Vy3)+VecY(1);
TrayectoriaZ=cumtrapz(Tiempox3,Vz3)+VecZ(1);
[TiempoAce,AceleracionEnX,AceleracionEnY,AceleracionEnZ]=resampleaceleraciones(Tiempox4,Ax,Ay,Az,Tmuestreo);
[TiempoVel,VelocidadEnX,VelocidadEnY,VelocidadEnZ]=resamplevelocidades(Tiempox3,Vx3,Vy3,Vz3,Tmuestreo);
[TiempoPos,PosicionEnX,PosicionEnY,PosicionEnZ]=resampleposiciones(Tiempox3,TrayectoriaX,Vx3,TrayectoriaY,Vy3,TrayectoriaZ,Vz3,Tmuestreo);
Aceleraciones=[AceleracionEnX;AceleracionEnY;AceleracionEnZ];
Velocidades=[VelocidadEnX;VelocidadEnY;VelocidadEnZ];
Posiciones=[PosicionEnX;PosicionEnY;PosicionEnZ];
VectorDeTiempo=TiempoPos;
MatrizLineal=[Posiciones;Velocidades;Aceleraciones];
%% ANGULOS
Distancia=sqrt(diff(Xx).^2+diff(Yy).^2+diff(Zz).^2);
AngX=uNormal(Distancia~=0,1)';
AngY=uNormal(Distancia~=0,2)';
AngZ=uNormal(Distancia~=0,3)';
Alfa=asin(AngY);
Beta=atan2(-AngX,-AngZ);
Gamma=zeros(1,length(Alfa));
Walfa=[diff(Alfa)./diff(Tiempo) 0];
Wbeta=[diff(Beta)./diff(Tiempo) 0];
Wgamma=[diff(Gamma)./diff(Tiempo) 0];
[TiempoAng,AnguloAlfa,AnguloBeta,AnguloGamma]=resamplevelocidades(Tiempo,Alfa,Beta,Gamma,Tmuestreo);
[TiempoW,WangularAlfa,WangularBeta,WangularGamma]=resampleaceleraciones(Tiempo,Walfa,Wbeta,Wgamma,Tmuestreo);
Angulos=[AnguloAlfa;AnguloBeta;AnguloGamma];
VelocidadAngular=[WangularAlfa;WangularBeta;WangularGamma];
AceleracionAngular=zeros(3,length(AnguloAlfa));
MatrizAngular=[Angulos;VelocidadAngular;AceleracionAngular];