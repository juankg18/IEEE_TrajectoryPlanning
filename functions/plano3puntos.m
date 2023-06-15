function  coefs= plano3puntos(p1, p2, p3, xLimits, yLimits)
% This function plots a line from three points. 
% I/P arguments: 
%   p1, p2, p3 eg, p1 = [x y z]
% O/P is: 
% normal: it contains a,b,c coeff , normal = [a b c]
% d : coeff

normal = cross(p1 - p2, p1 - p3);
d = -(p1(1)*normal(1) + p1(2)*normal(2) + p1(3)*normal(3));
coefs=[normal,d];
x = xLimits(1):xLimits(2);
y = yLimits(1):yLimits(2);
[X,Y] = meshgrid(x,y);
Z = (-d - (normal(1)*X) - (normal(2)*Y))/normal(3);
%mesh(X,Y,Z);
%hold on
%P=[p1;p2;p3;p1];
%plot3(P(:,1),P(:,2),P(:,3),'-o')
%hold on
end

