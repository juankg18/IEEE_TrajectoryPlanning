% Abrir la expresión lagrangiana del manipulador -> dinamicaBrazo.m
clc
clear all
close all
Agujero=[];
figure1 = figure('WindowState','maximized');
axes1 = axes('Parent',figure1);
hold(axes1,'on');
Coordxyz=[];
fileID2 = fopen('prueba3.svg','r');
formatSpec = '%c';
Cont1=fscanf(fileID2,formatSpec);
B = convertCharsToStrings(Cont1);
expresion='</g>';
corte=regexp(B,expresion,'split');
%testpoint=372;
for i=1:length(corte)-1
    expresion='type="contour" points="';
    corte1 = regexp(corte(i),expresion,'split');
    Coord2=corte1(2);
    expresion='\"';
    corte2=regexp(Coord2,expresion,'split');
    Coord2=corte2(1);
    Coord2=str2num(Coord2);
    tempxyz=(reshape(Coord2,2,[]))';
    Coordz=str2num(extractBetween(corte1(1),' slic3r:z="','">'));
    Coordz=Coordz*10^6; 
    tempxyz(:,3)=Coordz;
    Coordxyz=[Coordxyz;tempxyz];
    % Reconocimiento de agujeros
    expresion='<polygon slic3r:type="hole" points=';
    Holes=regexp(corte1(2),expresion,'split');
    for j=2:length(Holes)
        clear tempAgujero
        tempAgujero=extractBetween(Holes(j),'"','" style="fill: black"');
        tempAgujero=str2num(tempAgujero);
        tempAgujero=reshape(tempAgujero,2,[])';
        tempAgujero(:,3)=Coordz;
        Agujero=[Agujero;tempAgujero];
        plot3(tempAgujero(:,1), tempAgujero(:,2), tempAgujero(:,3),'Parent',axes1,'Marker','*');
        hold on
        if i==1 && j==2
            InternoA=tempAgujero;
        end
        if i==1 && j==3
            InternoB=tempAgujero;
        end
    end
    plot3(tempxyz(:,1), tempxyz(:,2), tempxyz(:,3),'Parent',axes1,'Marker','*');
    hold on  
    if i==1
        Externo=tempxyz(:,:);
    end
    zlabel('Z','HorizontalAlignment','center');
    ylabel('Y','HorizontalAlignment','right');
    xlabel('X','HorizontalAlignment','left');
    set(axes1,'FontSize',20);
    hold on
%    
end