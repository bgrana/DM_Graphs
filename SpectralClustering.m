function [C, L, Y] = SpectralClustering(W, k)

% Calculate affinity matrix (using adjacency matrix)
col1 = W(:,1);
col2 = W(:,2);
max_ids = max(max(col1,col2));
As= sparse(col1, col2, 1, max_ids, max_ids);
A = full(As);

% Calculate degree matrix
degs = sum(A, 2);
D = sparse(1:size(A, 1), 1:size(A, 2), degs);

% Construct Laplacian matrix
% D^(-1/2)
D12 = spdiags(1./(degs.^0.5), 0, size(D, 1), size(D, 2));
% calculate normalized Laplacian
L = D12 * A * D12;

% k largest eigenvectors
[X, ~] = eigs(L, k, 'lm');
% Normalize eigenvectors
Y = X./sqrt(sum(X.^2, 2));

% k-means
C = kmeans(Y, k, 'start', 'cluster', 'EmptyAction', 'singleton');
% Link nodes to their clusters
C = sparse(1:size(A, 1), C, 1);

end