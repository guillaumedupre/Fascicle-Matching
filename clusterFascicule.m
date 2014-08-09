function [M,P,allPoints,centroid] = clusterFascicle(fibers,k)
% This function cluster the fascicles using the k-means algorithm

s=size(fibers,1);

allPoints=fascicleVertices(fibers);

N=size(allPoints,1);
opts=statset('MaxIter',500);
[IDX,centroid] = kmeans(allPoints,k,'options',opts);

% Compute mask
M=sparse(N,k);
for i=1:k,
   M(:,i)=sparse(IDX==i);
end
% Compute adjacency
A=zeros(k,k);
c=1;
for i=1:s,
    np=size(fibers{i},2);
    for j=1:(np-1),
    A(IDX(c),IDX(c+1))=A(IDX(c),IDX(c+1))+1;
    A(IDX(c+1),IDX(c))=A(IDX(c),IDX(c+1));
     c=c+1;
    end
    c=c+1;
end

% Compute the randonm walk probability transition matrix by
% normalizing the adjacency matrix
P=A./repmat(sum(A),[k 1]);
end

