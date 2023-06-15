function vertexF = geodesicFlatten(vertex,faces,icenter,irotate)
    % Geodesic Embedding (Isomap)
    n = size(vertex,2);
    D = zeros(n);
    for i=1:n
        D(:,i) = perform_fast_marching_mesh(vertex,faces,i);
    end
    D = (D+D')/2;
    J = eye(n) - ones(n)/n;
    W = -J*(D.^2)*J;
    [U,S] = eig(W);
    S = diag(S);
    [S,I] = sort(S,'descend'); U = U(:,I);
    vertexF = U(:,1:2)' .* repmat(sqrt(S(1:2)), [1 n]);
    vertexF = vertexF - repmat(vertexF(:,icenter), [1 n]);
    theta = -pi/2+atan2(vertexF(2,irotate),vertexF(1,irotate));
    vertexF = [vertexF(1,:)*cos(theta)+vertexF(2,:)*sin(theta); ...
               -vertexF(1,:)*sin(theta)+vertexF(2,:)*cos(theta)];
end