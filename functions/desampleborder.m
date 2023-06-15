function [Aato2,Aato3]=desampleborder(Xsamp,Ysamp)
    % % Calculate the unit gradient in the x-direction.
    dx=gradient(Xsamp');
    % % Calculate the unit gradient in the y-direction.
    dy=gradient(Ysamp');
    % % Calculate the normal vector
    nv=[dy, -dx];
    % % normalize the normal vector
    unv=zeros(size(nv));
    norm_nv=sqrt(nv(:, 1).^2+nv(:, 2).^2);
    unv(:, 1)=nv(:, 1)./norm_nv;
    unv(:, 2)=nv(:, 2)./norm_nv;
    Pos=logical([1;(diff(unv(:, 1))~=0) | (diff(unv(:, 2))~=0)]);
    Pos(end)=true;
    Aato2=Xsamp(Pos);
    Aato3=Ysamp(Pos);
end