function [contornoFinal,xLimits,yLimits,numcapas]=ZContourbyVector(vertices, mosaico, VectorCorte)
    contorno2=[];contornoFinal=[];
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
    %lista del triangulo activo actual
    currTri = [];
    contorno=[];
    vector=[];
    numcapas=length(VectorCorte)-1;

    % vector de valores de discretización de los planos
    % plano= Jx + Ky + Lz + M
      J= zeros(1,length(VectorCorte));
      K= zeros(1,length(VectorCorte));
      L= -1*ones(1,length(VectorCorte));
      M= VectorCorte;
      for c=1:numcapas+1
          %dibujar plano capa 2
          %DibujoCapa(xLimits, yLimits, J(c), K(c), L(c), M(c));
           i=1;
     %%   
          while i<=size(triInferiorList,1)
              % define la ecuación de la capa
               x= triInferiorList(i,1);
               y= triInferiorList(i,2);
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
           contorno=[]; contorno2=[];
      end

     contornoFinal(:,end-1:end)=[];
end