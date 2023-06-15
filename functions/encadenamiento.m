function ContornoOrdenado=encadenamiento(contorno2)
% La funcion .mat es generada de la funcion: Cortador3DV3
%clear all
%close all
%clc
%load 'PruebaEncadenamiento.mat'
i=1;
NoaBuscar=NaN;
finbusqueda=0;
k=min(contorno2(:,10));
 
 while finbusqueda==0
     % leer columna 10 de contorno
     ind = contorno2(:,end) == k;
     muestra = contorno2(ind,:);
     %guarde la información de las coordenadas de muestra
     if isnan(NoaBuscar)==0
         ind=muestra(:,9)==NoaBuscar;
         if isempty(muestra(ind,:))
             ContornoOrdenado(i,:)=muestra(1,:) ;
             NoaBuscar=muestra(1,9);
         else
             ContornoOrdenado(i,:)=muestra(ind,:) ;
             temp=setdiff(muestra,ContornoOrdenado(i,:),'rows');
             NoaBuscar=temp(1,9);
         end
     else
         j=1;
         ContornoOrdenado(i,:)=muestra(1,:);
         % ahora debe buscar el numero compañero del arreglo
         NoaBuscar=muestra(j,9);
     end
     i=i+1;
     % buscar cual es la siguiente linea a conectar:
     % retirar de la busqueda los puntos de muestra
     contorno2=sortrows(setdiff(contorno2,muestra,'rows'),10);
     if isempty(contorno2)==0
         %buscar el valor de muestra(2,9)
         ind = contorno2(:,9) == NoaBuscar;
         % buscar hasta que haya una coordenada que pueda sr leida
         while isempty(contorno2(ind,:))==1 && j<size(muestra,1)
            j=j+1;
            NoaBuscar=muestra(j,9);
            ind = contorno2(:,9) == NoaBuscar;
         end
         muestraSig = contorno2(ind,:);
         % en caso que no haya ninguna intersección saltar a el otro bloque
         % de búsqueda
         if isempty(muestraSig)==1
             k = muestra(end,10)+1
         else
            k=muestraSig(1,10);
         end
         
     else
         ContornoOrdenado=[ContornoOrdenado;ContornoOrdenado(1,:)];
         k=1;
     end
%     % cuando cierre el ciclo acabe
%     % el ciclo se acaba cuando k=1 o si i=1000
     if k==1 || i==1000
         finbusqueda=1;
     end
end
%plot3(ContornoOrdenado(:,1),ContornoOrdenado(:,2),ContornoOrdenado(:,3),'-o')
end