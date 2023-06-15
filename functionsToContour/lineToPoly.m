function pgonD=lineToPoly(RectaX,RectaY,Diametro,flag)
pgonA = nsidedpoly(20,'Center',[RectaX(1) RectaY(1)],'Radius',Diametro/2);
pgonB = nsidedpoly(20,'Center',[RectaX(2) RectaY(2)],'Radius',Diametro/2);
Pendiente=diff(RectaY)/diff(RectaX);
if Pendiente == 0
    Xp=[RectaX(1) RectaX(2) RectaX(2) RectaX(1)];
    Yp=[1 1 -1 -1]*Diametro/2+RectaY(1);
else
if abs(Pendiente) == Inf
    Yp=[RectaY(1) RectaY(2) RectaY(2) RectaY(1)];
    Xp=[1 1 -1 -1]*Diametro/2+RectaX(1);
else
    Ang=atan(Pendiente);
    Matriz=[cos(Ang) -sin(Ang);sin(Ang) cos(Ang)]*[0 0;Diametro/2 -Diametro/2];
    Xp=[Matriz(1,1)+RectaX(1) Matriz(1,1)+RectaX(2) Matriz(1,2)+RectaX(2) Matriz(1,2)+RectaX(1)];
    Yp=[Matriz(2,1)+RectaY(1) Matriz(2,1)+RectaY(2) Matriz(2,2)+RectaY(2) Matriz(2,2)+RectaY(1)];
end    
end
pgonC = polyshape(Xp,Yp);
if flag
pgonD = union(union(pgonC,pgonA),pgonB);
else
pgonD = subtract(subtract(pgonC,pgonA),pgonB);
end
end