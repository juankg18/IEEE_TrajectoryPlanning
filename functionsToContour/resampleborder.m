function [Aato2,Aato3]=resampleborder(Xintro,Yintro,Espacio)
Aato2=Xintro(1);
Aato3=Yintro(1);
for i=2:length(Xintro)
    Magni=sqrt((Xintro(i)-Xintro(i-1))^2+(Yintro(i)-Yintro(i-1))^2);
    Troz=ceil(Magni/Espacio);
    Xin=linspace(Xintro(i-1),Xintro(i),Troz+1);
    Yin=linspace(Yintro(i-1),Yintro(i),Troz+1);
    Aato2=[Aato2 Xin(2:end)];
    Aato3=[Aato3 Yin(2:end)];
end
end