function [contornoFinal,xLimits,yLimits,numcapas]=Aplanar(fileName,DistEntreCapas)
%DistEntreCapas -> distancia dada en mm.

contorno2=[];contornoFinal=[];
%fileName = 'Pieza6.stl';
[vertices, mosaico] = leerStl(fileName);

vertices=round(vertices,3);
  
%crear una lista de los vertices de los triangulos y listarlos en vertices
%infriorees y superiores
[triInferiorList, triSuperiorList] = ListasExtremos(vertices, mosaico);
  
% maximos y minimos de X y Y
xLimits = [min(vertices(:,1)) max(vertices(:,1))];
yLimits = [min(vertices(:,2)) max(vertices(:,2))];
%  
% Z inferior de cada triangulo
 %currZ = triInferiorList(1,1);
%  
 botIdx = 0; topIdx = 0; % indicadores de posicion de la lista de extemos superiores e inferiores

%lista del triangulo activo actual
currTri = [];

contorno=[];
vector=[];
numcapas=round(triSuperiorList(end, 3)/DistEntreCapas);
  
% Analizar todos los triangulos y promediar las alturas de cada triangulo
% para encontrar el triangulo mas alto y mas ajo
PromAltMayor=0;
PromAltMenor=1e10;
for i=1:3:size(vertices,1)
    PromAltTriangulo=mean([vertices(i,3), vertices(i+1,3),vertices(i+2,3)]);
    % si este promedio es el mas alto guardar ese triangulo
    if PromAltTriangulo>PromAltMayor
        PromAltMayor=PromAltTriangulo;
        CoordTrianAlto= [vertices(i,:); vertices(i+1,:); vertices(i+2,:)];
    end
    % si este promedio es el mas bajo guardar ese triangulo
    if PromAltTriangulo<PromAltMenor
        PromAltMenor=PromAltTriangulo;
        CoordTrianBajo= [vertices(i,:); vertices(i+1,:); vertices(i+2,:)];
    end
end

% Generación de capas
% analisis del punto i de los triangulos
Puntos(1,:)=plano3puntos(CoordTrianBajo(1,:), CoordTrianBajo(2,:), CoordTrianBajo(3,:), xLimits, yLimits);
Puntos(end+1,:)=plano3puntos(CoordTrianAlto(1,:), CoordTrianAlto(2,:), CoordTrianAlto(3,:), xLimits, yLimits);
J= Puntos(:,1)';    K= Puntos(:,2)';    L= Puntos(:,3)';    M= Puntos(:,4)';
% determinando los vertice del plano inferior
c=1;
x=xLimits(1);   y=yLimits(1);
vi(1,3)=(-M(c)-(J(c)*x) - (K(c)*y))/L(c);
vi(1,1)=x;  vi(1,2)=y;
y=yLimits(2);
vi(2,3)=(-M(c)-(J(c)*x) - (K(c)*y))/L(c);
vi(2,1)=x;
vi(2,2)=y;
x=xLimits(2);
vi(3,3)=(-M(c)-(J(c)*x) - (K(c)*y))/L(c);
vi(3,1)=x;
vi(3,2)=y;
% determinando los vertice del plano superior
c=2;
x=xLimits(1);
y=yLimits(1);
vs(1,3)=(-M(c)-(J(c)*x) - (K(c)*y))/L(c);
vs(1,1)=x;
vs(1,2)=y;
y=yLimits(2);
vs(2,3)=(-M(c)-(J(c)*x) - (K(c)*y))/L(c);
vs(2,1)=x;
vs(2,2)=y;
x=xLimits(2);
vs(3,3)=(-M(c)-(J(c)*x) - (K(c)*y))/L(c);
vs(3,1)=x;
vs(3,2)=y;

% 
 for c=1:numcapas-1
     for i=1:3
         v(i,:)=vs(i,:)-vi(i,:);
         div(1,:)=v(i, 1)/numcapas; %eje xi
         div(2,:)=v(i, 2)/numcapas; %eje yi
         div(3,:)=v(i, 3)/numcapas; %eje zi
         Npunto(i,:) = vi(i,:)+(c*div)';
     end
 Puntos(c+1,:)=plano3puntos(Npunto(1,:), Npunto(2,:), Npunto(3,:), xLimits, yLimits);
 end
% Crear ecuación del plano más alto
Puntos(end+1,:)=plano3puntos(CoordTrianAlto(1,:), CoordTrianAlto(2,:), CoordTrianAlto(3,:), xLimits, yLimits);
close all
 
% vector de valores de discretización de los planos
% plano= Jx + Ky + Lz + M
  J= Puntos(:,1)';
  K= Puntos(:,2)';
  L= Puntos(:,3)';
  M= Puntos(:,4)';
  vs=[];  
  for c=1:numcapas+1
      %dibujar plano capa 2
      %DibujoCapa(xLimits, yLimits, J(c), K(c), L(c), M(c));
       i=1;
 %%  
      while i<=size(triInferiorList,1)
          % define la ecuación de la capa
           x= triInferiorList(i,1);
           y= triInferiorList(i,2);
           z= triInferiorList(i,3);
           currZ= (-M(c)-(J(c)*x) - (K(c)*y))/L(c);
           if currZ < 0.01
               currZ=0;
           end
           % guardar los triangulos que estan igual o por debajo del nivel que se esta estudiando, eliminando aquellos que sus 3 vertices esten por encima del plano discretizador
           % si el vertice más baja del triangulo esta por debajo de la capa discretizadora
            if triInferiorList(i,3) <= currZ
                currTri(end + 1) = triInferiorList(i,end);               
            else
                break;
            end
            i=i+1;
      end
    
  %   Borrar los triangulos por encima del nivel de discretización Z
      remList = [];
      i=1;
      while i<=size(triSuperiorList,1)
          % define la ecuación de la capa
           x= triSuperiorList(i,1);
           y= triSuperiorList(i,2);
           z= triSuperiorList(i,3);
           currZ= (-M(c)-(J(c)*x) - (K(c)*y))/L(c);
           if currZ < 0.01
               currZ=0;
           end           
           % guardar los triangulos que estan igual o por debajo del nivel que se esta estudiando, eliminando aquellos que sus 3 vertices esten por encima del plano discretizador
           % si el vertice más baja del triangulo esta por debajo de la capa discretizadora
            if triSuperiorList(i,3) < currZ
                remList(end + 1) = triSuperiorList(i,end);               
            else
                break;
            end
            i=i+1;
      end
  % Elimina los triangulos los cuales sus 3 vertices se encuentran por debajo de la capa discretizadora
     currTri = setdiff(currTri, remList);
%     
    %Identificar las intersecciones entre la capa discretizada y los triangulos
    currIntersect = {};
    for idxTri = 1:numel(currTri) % recorrer l vector que contiene los triangulos interceptados 
        % retorna el valor de los vertices de cada triangulo apto
        triCoo = vertices(mosaico(currTri(idxTri),:) , :);
        currIntersect{end + 1} = triPlanIntersectV3(triCoo,J(c),K(c),L(c),M(c), xLimits, yLimits);
    end
    
    % Mostrar las intersecciones
        TriangulosTemp=[]; vectortemp=[];q=1;
      for idxObj = 1: numel(currIntersect)
         switch size(currIntersect{idxObj}, 1)
             case 1
                 vector=[currIntersect{idxObj}(:,1), currIntersect{idxObj}(:,2),currIntersect{idxObj}(:,3)];
             case 2
                 vector=[currIntersect{idxObj}(:,1), currIntersect{idxObj}(:,2),currIntersect{idxObj}(:,3)];
             case 3
                  vector=[currIntersect{idxObj}(:,1), currIntersect{idxObj}(:,2),currIntersect{idxObj}(:,3)];
         end
         vector=round(double(vector),3);
         % si hay una linea o un triangulo
         if numel(vector)>3
             % Si hay reflejado un triangulo
             if numel(vector)==9
                 vectortemp1   = sortrows([vector(1,:);vector(2,:)]);
                 vectortemp(:,:,q)   = [vectortemp1,   meshgrid([J(c),K(c),L(c),M(c),c,idxObj*10 + q] , [1:size(vectortemp1,1)])];
                 vectortemp2 = sortrows([vector(1,:);vector(3,:)]);
                 vectortemp(:,:,q+1) = [vectortemp2, meshgrid([J(c),K(c),L(c),M(c),c,idxObj*10 + q+1] , [1:size(vectortemp2,1)])];
                 vectortemp3 = sortrows([vector(2,:);vector(3,:)]);
                 vectortemp(:,:,q+2) = [vectortemp3, meshgrid([J(c),K(c),L(c),M(c),c,idxObj*10 + q+2] , [1:size(vectortemp3,1)])];
                 q=q+3;
             else % si hay una linea
                vector2=sortrows([vector,meshgrid([J(c),K(c),L(c),M(c),c,idxObj],[1:size(vector,1)])]);
                contorno=[contorno;vector2];                 
             end            
         end                     
       end
 % pasar las coordenadas de matriz 3D a 2D
%% 
     w=1;
     while w <= size(vectortemp,3)-1
         e=w+1;
         while e<=size(vectortemp,3)
              if isequal(vectortemp(:,1:3,w),vectortemp(:,1:3,e))==1
                 vectortemp(:,:,w)=[];
                 vectortemp(:,:,e-1)=[];                        
              end
              e=e+1;
         end
         w=w+1;
     end
%%
     TriangToLineas=[];
     for r=1:size(vectortemp,3)
         TriangToLineas=[TriangToLineas;vectortemp(:,:,r)];
     end
     contorno=[contorno;TriangToLineas];
%%
      %funcion de ordenar y conectar el contorno
       [C,ia,ic] = unique(contorno(:,1:3),'rows','stable');
       contorno2=[contorno,ic];      
       contorno2=sortrows(contorno2,size(contorno2,2));
       ContornoOrdenado=encadenamiento(contorno2);      
       contornoFinal=[contornoFinal;ContornoOrdenado];
        plot3(contornoFinal(:,1),contornoFinal(:,2),contornoFinal(:,3))
        hold on
       contorno=[]; contorno2=[];
  end
 contornoFinal(:,end-1:end)=[];
end
% % perfiles aplanados [ X, Y, noCapa]
%[PerfilAplanado,traslado,AlturaCapa]=desdoblar(contornoFinal,xLimits,yLimits,numcapas);