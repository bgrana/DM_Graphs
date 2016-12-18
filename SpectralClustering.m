function C = SpectralClustering(E, k)

% Calculate affinity matrix (using adjacency matrix)
col1 = E(:,1);
col2 = E(:,2);
max_ids = max(max(col1,col2));
As= sparse(col1, col2, 1, max_ids, max_ids);
A = full(As);

% Calculate degree matrix
degs = sum(A, 2);
D = sparse(1:size(A, 1), 1:size(A, 2), degs);

% Construct Laplacian matrix
L = D - A;
% D^(-1/2)
D12 = spdiags(1./(degs.^0.5), 0, size(D, 1), size(D, 2));
% calculate normalized Laplacian
L = D12 * L * D12;

% k eigenvectors with smallest eigenvalues
[X, V] = eigs(L, k, 'sm');
% Normalize eigenvectors
Y = X./sqrt(sum(X.^2, 2));
% k-means
C = kmeans(Y, k);
% plot(Y(:,2))

% Plot sparsity pattern of L
% spy(L)


% Plot clusters over eigenvector
[numDataPoints,numDimensions] = size(D);
Colors = hsv(k);
for i = 1 : numDataPoints
    plot(i, X(i,1),'.','Color',Colors(C(i),:))
    hold on
end
hold off

% Link nodes to their clusters
C = sparse(1:size(A, 1), C, 1);

end