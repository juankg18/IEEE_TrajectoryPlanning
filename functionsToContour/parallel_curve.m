function [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x, y, d, make_plot, flag1, newflag)
% % parallel_curve: Calculates the inner and outer parallel curves to the given x, y pairs.
% %
% % Syntax:
% %
% % [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x, y, d, make_plot);
% %
% % **********************************************************************
% %
% % Description
% %
% % Calculates the inner and outer parallel curves to the given x, y
% % coordinate pairs.  By default the inner parallel is toward the center 
% % of curvature while the outer parallel is away from the center of 
% % curvature.  Use  flag1=0 to make the parallels stay on opposite sides 
% % of the curve.  Input the x and y coordinate pairs, distance between 
% % the curve and the parallel, and whether to plot the curves.
% %
% % Program is currently limited to rectangular coordinates.
% % Attempts to make sure the parellels are always inner or outer.
% % The inner parallel is toward the center of curvature
% % while the outer parallel is away from the center of curvature.
% % If the radius of curvature become infinite adn the center of curvature 
% % changes sides then the parallels will switch sides.  If the parallels 
% % should stay on teh sae sides then set flag1=0 to keep the parallels
% % on the sides.  
% % 
% % Implements "axis equal" so that the curves appear with equal
% % scaling.  If this is a problem, type "axis normal" and the scaling goes
% % back to the default.  This will have to be done for every plot or feel
% % free to modify the program.
% %
% % **********************************************************************
% %
% % Input Variables
% %
% % x=1:100;        % (meters) position column-vector in the x-direction
% %                 % default is x=1:100;
% %
% % y=x.^3;         % (meters) position column-vector in the y-direction
% %                 % default is y=x.^2;
% %
% % d=10;           % (meters) distance from curve to the parallel curve
% %             	% default is d=1;
% %
% % make_plot=1;    % 1 makes a plot of the curve and parallels
% %                 % otherwise on plots are generated.
% %                 % default is make_plot=1;
% %
% % flag1
% %
% % **********************************************************************
% %
% % Output Variables
% %
% % x_inner     % (meters) x positions of the inner parallel curve
% %
% % y_inner     % (meters) y positions of the inner parallel curve
% %
% % x_outer     % (meters) x positions of the outer parallel curve
% %
% % y_outer     % (meters) y positions of the outer parallel curve
% %
% % R           % (meters) radius of curvature
% %
% % unv         % (meters) unit normal vector at each position
% %
% % concavity   % (-1) concave down
% %             % (+1) concave up
% %
% % overlap     % (boolean) indicates whether the distance between the
% %             %  parallel curves is greater than the radius of curvature.
% %             % if overlap is 1 then there may be cusps and the parallels
% %             % may be overlapping one another.
% %
% % **********************************************************************
%
%
% Example='1';
% 
% x=[0:0.1:0.5];
% y=[0.4 0.375 0.35 0.325 0.275 0.15];
% p=polyfit(x,y,3);
% x=0:.01:.5;
% y=polyval(p,x);
% d=0.07;
% make_plot=1;
% flag1=0;
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x, y, d, make_plot, flag1);
% 
% 
%
% Example='2';
% 
% x=1:100;
% y=x.^2;
% d=1;
% make_plot=1;
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x, y, d, make_plot);
%
%
% Example='3';
%
% x=1:100;
% y=log10(x);
% d=1;
% make_plot=1;
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x, y, d, make_plot);
%
%
% Example='4';
%
% x=1/1000*(0:10000);
% y=sin(2*pi*x);
% d=1;
% make_plot=1;
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x, y, d, make_plot);
%
%
% Example='5';
%
% x=1/1000*(0:10000);
% y=sin(2*pi*x);
% d=1;
% make_plot=1;
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x, y, d, make_plot);
%
%
% Example='6';
%
% x=1/1000*(0:10000);
% y=10*sin(2*pi*x);
% d=10;
% make_plot=1;
% [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x, y, d, make_plot);
%
%
%
% % **********************************************************************
% %
% %
% %
% % List of Dependent Subprograms for
% % parallel_curve
% %
% % FEX ID# is the File ID on the Matlab Central File Exchange
% %
% %
% % Program Name   Author   FEX ID#
% % 1) magn		Paolo de Leva		8782
% %
% %
% %
% % **********************************************************************
% %
% % References
% %
% % http://xahlee.org/SpecialPlaneCurves_dir/Parallel_dir/parallel.html
% %
% % Gray, A. "Parallel Curves." §5.7 in Modern Differential Geometry of
% %           Curves and Surfaces with Mathematica, 2nd ed. Boca Raton,
% %           FL: CRC Press, pp. 115-117, 1997.
% %
% % Lawrence, J. D. A Catalog of Special Plane Curves. New York: Dover,
% %           pp.42-43, 1972.
% %
% % Yates, R. C. "Parallel Curves." A Handbook on Curves and Their
% %               Properties. Ann Arbor, MI: J. W. Edwards, pp. 155-159,
% %               1952.
% %
% % http://en.wikipedia.org/wiki/Parallel_curve
% %
% % **********************************************************************
% %
% %
% % parallel_curve was  Written by Edward L. Zechmann
% %
% %
% %     date     10 June        2010
% %
% % modified      2 July        2010    Updated Comments
% %
% % modified     25 September   2010    Added option to avoid following
% %                                     the change in concavity when
% %                                     radius of curvture is infinite.
% %                                     Fixed bug with indicating the 
% %                                     overlap.   
% %                                     Updated Comments
% %
% % **********************************************************************
% %
% % Please feel free to modify this code.
% %
% % See Also: horn, magn
% %

if nargin < 1 || isempty(x) || ~isnumeric(x)
    x=1:100;
end

if nargin < 2 || isempty(y) || ~isnumeric(y)
    y=x.^2;
end

if nargin < 3 || isempty(d) || ~isnumeric(d)
    d=1;
end

if nargin < 4 || isempty(make_plot) || ~isnumeric(make_plot)
    make_plot=1;
end

if nargin < 5 || isempty(flag1) || ~isnumeric(flag1)
    flag1=1;
end


% % Make sure that x and y are column vectors.
x=x(:);
y=y(:);
x=[x;x(1:2,1)];
y=[y;y(1:2,1)];
% % Calculate the unit gradient in the x-direction.
dx=gradient(x);

% % Calculate the unit gradient in the y-direction.
dy=gradient(y);

% % Calculate the unit second gradient in the x-direction.
dx2=gradient(dx);

% % Calculate the unit second gradient in the y-direction.
dy2=gradient(dy);

% % Calculate the normal vector
nv=[dy, -dx];

% % normalize the normal vector
unv=zeros(size(nv));
norm_nv=sqrt(nv(:, 1).^2+nv(:, 2).^2);
unv(:, 1)=nv(:, 1)./norm_nv;
unv(:, 2)=nv(:, 2)./norm_nv;

% % determine radius of curvature
R=(dx.^2+dy.^2).^(3/2)./abs(dx.*dy2-dy.*dx2);

% % Determine overlap points for inner normal curve
overlap=R < d;

% % Determine concavity
concavity=2*(dy2 > 0)-1;

if isequal(flag1, 1)
    
     % % For inner normal curve
    x_inner=x-unv(:, 1).*concavity.*d;
    y_inner=y-unv(:, 2).*concavity.*d;

    % % For outer normal curve
    x_outer=x+unv(:, 1).*concavity.*d;
    y_outer=y+unv(:, 2).*concavity.*d;
    
else

    % % For inner normal curve
    x_inner=x-unv(:, 1).*d;
    y_inner=y-unv(:, 2).*d;

    % % For outer normal curve
    x_outer=x+unv(:, 1).*d;
    y_outer=y+unv(:, 2).*d;

end
MagIn=sum(sqrt(diff(x_inner).^2+diff(y_inner).^2));
MagOut=sum(sqrt(diff(x_outer).^2+diff(y_outer).^2));
if MagIn > MagOut
    Tac=x_outer;
    x_outer=x_inner;
    x_inner=Tac;
    Tac=y_outer;
    y_outer=y_inner;
    y_inner=Tac;
end
% Retirar Esquinas
marca=[0 abs(diff(atan(unv(:,2)./unv(:,1)))')]>0.001;
marca2=[1 abs(diff(atan(unv(:,2)./unv(:,1)))')]>0.001;
marcafinal=[diff(marca) 0]==1;
marcainicial=[diff(marca) 0]==-1;
% Vectores
x_outer=x_outer(marca2)';
y_outer=y_outer(marca2)';
xin=x_inner(marcainicial);
yin=y_inner(marcainicial);
xfi=x_inner(marcafinal);
yfi=y_inner(marcafinal);
% Toca revisar
xfi=[xfi(2:end);xfi(1:2)];
yfi=[yfi(2:end);yfi(1:2)];
xin=[xin;xin(1)];
yin=[yin;yin(1)];
% Puntos Interseccion
TrayFinX=xin(1);
TrayFinY=yin(1);
for i=1:(length(xin)-1)
    aja = [xin(i) yin(i); xfi(i) yfi(i)];
    bja = [xin(i+1) yin(i+1); xfi(i+1) yfi(i+1)];
    daja = diff(aja);
    dbja = diff(bja);
    maja = daja(2)/daja(1);
    mbja = dbja(2)/dbja(1);
    if abs(maja) == Inf
        xsol = aja(1,1);
        ysol = mbja*(xsol-bja(1,1))+bja(1,2);
    else
        if abs(mbja) == Inf
            xsol = bja(1,1);
            ysol = maja*(xsol-aja(1,1))+aja(1,2);
        else
            xsol = (maja*aja(1,1)-mbja*bja(1,1)+bja(1,2)-aja(1,2))/(maja-mbja);
            ysol = maja*(xsol-aja(1,1))+aja(1,2);
        end
    end
    TrayFinX=[TrayFinX xsol];
    TrayFinY=[TrayFinY ysol];
end
TrayFinX(1)=TrayFinX(end);
TrayFinY(1)=TrayFinY(end);
x_inner=TrayFinX;
y_inner=TrayFinY;
% Giros Indeseados
flagti=0;
x_final=x_inner;
y_final=y_inner;
i=2;
Cortes=1;
Premi=1;
Limi=length(x_inner(1,:));
while(i<=Limi-2)
    for j=i+2:Limi-Premi
        aja = [x_inner(1,i-1) y_inner(1,i-1); x_inner(1,i) y_inner(1,i)];
        bja = [x_inner(1,j-1) y_inner(1,j-1); x_inner(1,j) y_inner(1,j)];
        daja = diff(aja);
        dbja = diff(bja);
        maja = daja(2)/daja(1);
        mbja = dbja(2)/dbja(1);
        if abs(maja) == Inf
            xsol = aja(1,1);
            ysol = mbja*(xsol-bja(1,1))+bja(1,2);
        else
            if abs(mbja) == Inf
                xsol = bja(1,1);
                ysol = maja*(xsol-aja(1,1))+aja(1,2);
            else
                xsol = (maja*aja(1,1)-mbja*bja(1,1)+bja(1,2)-aja(1,2))/(maja-mbja);
                ysol = maja*(xsol-aja(1,1))+aja(1,2);
            end
        end
        if (((xsol<=x_inner(1,i-1)&&xsol>=x_inner(1,i))||(xsol>=x_inner(1,i-1)&&xsol<=x_inner(1,i)))&&((xsol<=x_inner(1,j-1)&&xsol>=x_inner(1,j))||(xsol>=x_inner(1,j-1)&&xsol<=x_inner(1,j))))&&(((ysol<=y_inner(1,i-1)&&ysol>=y_inner(1,i))||(ysol>=y_inner(1,i-1)&&ysol<=y_inner(1,i)))&&((ysol<=y_inner(1,j-1)&&ysol>=y_inner(1,j))||(ysol>=y_inner(1,j-1)&&ysol<=y_inner(1,j))))
            Cortes=Cortes+1;
            x_aa=[x_inner(1,1:i-1) xsol x_inner(1,j:end)];
            y_aa=[y_inner(1,1:i-1) ysol y_inner(1,j:end)];
            x_bb=[xsol x_inner(1,i:j-1) xsol];
            y_bb=[ysol y_inner(1,i:j-1) ysol];
            MagIn=sum(sqrt(diff(x_aa).^2+diff(y_aa).^2));
            MagOut=sum(sqrt(diff(x_bb).^2+diff(y_bb).^2));
            x_inner(1,:)=NaN;
            y_inner(1,:)=NaN;
            x_inner(Cortes,:)=NaN;
            y_inner(Cortes,:)=NaN;
            if MagIn<MagOut
                x_inner(1,1:length(x_bb))=x_bb;
                y_inner(1,1:length(y_bb))=y_bb;
                x_inner(Cortes,1:length(x_aa))=x_aa;
                y_inner(Cortes,1:length(y_aa))=y_aa;
            else
                x_inner(Cortes,1:length(x_bb))=x_bb;
                y_inner(Cortes,1:length(y_bb))=y_bb;
                x_inner(1,1:length(x_aa))=x_aa;
                y_inner(1,1:length(y_aa))=y_aa;
            end
            flagti=1;
        end
        if flagti==1
            break;
        end
    end
    i=i+1;
    Premi=0;
    if flagti==1
        flagti=0;
        i=2;
        Premi=1;
        Limi=length(x_inner(1,~isnan(x_inner(1,:))));
    end
end
%  % Make a simple plot of the curve and the parallels
if isequal(make_plot, 1)
    figure;
    plot(x, y, 'b');
    hold on;
    plot(x_inner', y_inner', 'r');
    plot(x_outer', y_outer', 'g');
    legend({'Curve', 'Inner Parallel', 'Outer Parallel'}, 'location', 'Best');

    % The axis scaling can be modified.
    % axis equal makes the plots more realistic for geometric
    % constructions.  if this is a problem, change to axis normal.
    axis equal
    % axis normal

end