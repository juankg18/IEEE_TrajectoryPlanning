
%Pruebas Parallel
% [Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 1, 0);

[Xsamp,Ysamp]=resampleborder(Xentrada,Yentrada,Espacio);
[x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 1, 0);

% [Xsamp,Ysamp]=resampleborder(XentradaA,YentradaA,Espacio);
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 1, 0);
% 
% [Xsamp,Ysamp]=resampleborder(XentradaB,YentradaB,Espacio);
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curvepamejor(Xsamp, Ysamp, Spe/(newflag+1), 1, 0);

% [Xsamp,Ysamp]=resampleborder(XentradaA,YentradaA,Espacio);
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(Xsamp, Ysamp, Spe/(newflag+1), 1, 0);
