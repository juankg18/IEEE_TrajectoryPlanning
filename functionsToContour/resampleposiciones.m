function [Timeto,Aato2,Aato3,Aato4]=resampleposiciones(bbb,trayx,velx,trayy,vely,trayz,velz,Espacio)
Timeto=bbb(1):Espacio:bbb(end);
Aato2=zeros(1,length(Timeto));
Aato3=zeros(1,length(Timeto));
Aato4=zeros(1,length(Timeto));
for i=1:length(Timeto)
    xax=bbb<=Timeto(i);
    pos=max(find(xax));
    Aato2(i)=(velx(pos)+velx(pos+1))/2*(Timeto(i)-bbb(pos))+trayx(pos);
    Aato3(i)=(vely(pos)+vely(pos+1))/2*(Timeto(i)-bbb(pos))+trayy(pos);
    Aato4(i)=(velz(pos)+velz(pos+1))/2*(Timeto(i)-bbb(pos))+trayz(pos);
end
end