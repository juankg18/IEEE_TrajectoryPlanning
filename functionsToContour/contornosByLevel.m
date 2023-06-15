function [Xtotal,Ytotal]=contornosByLevel(IntA,Espacio,Spe,Dime)
Xentrada=(IntA(:,1));
Yentrada=(IntA(:,2));
newflag=1;
Xtotal=[];
Ytotal=[];
for i=1:floor(Dime/0.8)
    [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
    [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
    Xentrada=x_inner(1,:);
    Yentrada=y_inner(1,:);
    Xtotal(:,i)=NaN;
    Ytotal(:,i)=NaN;
    Xtotal(1:length(Xentrada),i)=Xentrada';
    Ytotal(1:length(Yentrada),i)=Yentrada';
    if i==1
        Tab=length(Xentrada);
    end
    newflag=0;
end
Xtotal=Xtotal(1:Tab,:);
Ytotal=Ytotal(1:Tab,:);
end