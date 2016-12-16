% Read data
E = csvread('data/example1.dat');

% Convert edge list to adjacency matrix
col1 = E(:,1);
col2 = E(:,2);
max_ids = max(max(col1,col2));
As= sparse(col1, col2, 1, max_ids, max_ids);
A = full(As);

% Find and sort eigenvalues
[v,D] = eig(A);
sort(diag(D));