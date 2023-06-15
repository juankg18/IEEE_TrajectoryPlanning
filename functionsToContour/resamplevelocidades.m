function [Timeto, Aato2,Aato3,Aato4]=resamplevelocidades(bbb,aaa,aaa2,aaa3,Espacio)
Timeto=bbb(1):Espacio:bbb(end);
Aato2=zeros(1,length(Timeto));
Aato3=zeros(1,length(Timeto));
Aato4=zeros(1,length(Timeto));
for i=1:length(Timeto)
    xax=bbb<=Timeto(i);
    pos=max(find(xax));
    Aato2(i)=(Timeto(i)-bbb(pos))*(aaa(pos)-aaa(pos+1))/(bbb(pos)-bbb(pos+1))+aaa(pos);
    Aato3(i)=(Timeto(i)-bbb(pos))*(aaa2(pos)-aaa2(pos+1))/(bbb(pos)-bbb(pos+1))+aaa2(pos);
    Aato4(i)=(Timeto(i)-bbb(pos))*(aaa3(pos)-aaa3(pos+1))/(bbb(pos)-bbb(pos+1))+aaa3(pos);
end
end