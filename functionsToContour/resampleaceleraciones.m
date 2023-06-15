function [Timeto, Aato2,Aato3,Aato4]=resampleaceleraciones(bbb,aaa,aaa2,aaa3,Espacio)
Timeto=bbb(1):Espacio:bbb(end);
Aato2=zeros(1,length(Timeto));
Aato3=zeros(1,length(Timeto));
Aato4=zeros(1,length(Timeto));
for i=1:length(Timeto)
    xax=bbb<=Timeto(i);
    pos=max(find(xax));
    Aato2(i)=aaa(pos);
    Aato3(i)=aaa2(pos);
    Aato4(i)=aaa3(pos);
end
end