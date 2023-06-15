function [Xtotal,Ytotal]=parallelContour(Xentrada,Yentrada,Espacio,Spe,Vol)
    newflag=1;
    clear Xtotal
    clear Ytotal
    Xtotal=[];
    Ytotal=[];
    for i=1:Vol
        [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
        [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 0, 0,newflag);
        Xentrada=x_inner(1,:);
        Yentrada=y_inner(1,:);
        newflag=0;
        Ta=size(Xtotal);
        Sa=length(Xentrada);
        if Sa(1)>Ta
        Xtotal(Ta+1:Sa,1:i)=NaN;
        Ytotal(Ta+1:Sa,1:i)=NaN;
        else
        Xtotal(:,i)=NaN;
        Ytotal(:,i)=NaN;
        end
        Xtotal(1:length(Xentrada),i)=Xentrada';
        Ytotal(1:length(Yentrada),i)=Yentrada';
    end
end