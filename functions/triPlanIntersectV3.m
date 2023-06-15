function intersectCoo = triPlanIntersectV3(Trian1,J,K,L,M, xLimits, yLimits)

% Trian1 es una matriz de 3x3  que contiene las coordenadas de cada
% triangulo
% Analisis del vertice i para obtener el vector status
for i=1:3
    x= Trian1(i,1);
    y= Trian1(i,2);
    z= Trian1(i,3);
    % J K L M dependen de la capa discretizadora
    currZ=(-M-(J*x) - (K *y))/L;
    if currZ < 0.01
        currZ=0;
    end
    if z>currZ
        status(i)=1;
    else
        if z<currZ
            status(i)=-1;
        else
            status(i)=0;
        end
    end
end
 
% vertice sobre el plano discretizador
inPlan = find(status == 0);
% vertices fuera del plano discretizador
outPlan = find(status ~= 0);

% contar cuantos vertices estan sobre el plano
 switch numel(inPlan) 
     case 3
         % El triangulo esta esta alineado con el plazo discretizador  y el triangulo proyectado mantiene los mismos valores  
         intersectCoo = Trian1;
    case 2
        % Un lado del triangulo est alineado con la capa
        % retornar esos valores de esos dos vertices
        intersectCoo = Trian1(inPlan, :);
     case 1 % un vertice esta alineeado con el plano discretizador         
         if prod(status(outPlan)) > 0 % Si los otros vertices estan por encima del plano discretizador
            %todo el triangulo se proyecta sobre el plano discretizador
             intersectCoo = Trian1(inPlan, :);
         else
             % Un vertice esta por encima del plano discretizador y el otro por debajo
             % calculo de la intersección del plano con las aristas
             intersectCoo = [Trian1(inPlan, :); vectPlanIntersect(Trian1(outPlan, :),J,K,L,M, xLimits, yLimits)];
         end
    case 0
        % Interpolar las 3 aristas con el plano de discretización
        intersectCoo = [];
        intersectCoo = [intersectCoo; vectPlanIntersect(Trian1([1 2], :), J,K,L,M, xLimits, yLimits)];
        intersectCoo = [intersectCoo; vectPlanIntersect(Trian1([2 3], :), J,K,L,M, xLimits, yLimits)];
        intersectCoo = [intersectCoo; vectPlanIntersect(Trian1([1 3], :), J,K,L,M, xLimits, yLimits)];
%intersectCoo=Inf;
 end
 
 
end

function intersect = vectPlanIntersect(vectCoo,J,K,L,M, xLimits, yLimits)
%plot3(vectCoo(:,1),vectCoo(:,2),vectCoo(:,3))
%hold on
for i=1:2
    x=vectCoo(i,1);
    y=vectCoo(i,2);
    currZ(i)=(-M-(J*x) - (K *y))/L;
end

% si ambos vertices estan por encima del plano de corte
 if sign(vectCoo(1,3) - currZ(1)) == sign(vectCoo(2,3) - currZ(2))
     intersect = [];
     return;
 end

%DibujoCapa(xLimits, yLimits, J, K, L, M);
hold on

syms t
p=vectCoo(1,:);
v=vectCoo(2,:)-vectCoo(1,:);

eq= J*(p(1)+v(1)*t)+ K*(p(2)+v(2)*t)+L*(p(3)+v(3)*t)+M;
[A,B]=coeffs(eq,t);
if numel(A)>1
    t= -A(2)/A(1);
    for i=1:3
        intersect(i)=p(i)+v(i)*t;
    end
else
    x=p(1); y=p(2); z= (-M-(J*x)-(K*y))/L;
    intersect=[x,y,z];
end
intersect = intersect;
end
