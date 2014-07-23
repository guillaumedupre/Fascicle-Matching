function [allPoints,M,A,DF] = preprocess(fibers)


s=size(fibers,1);
allPoints=[];
for i=1:s,
   allPoints=[allPoints;fibers{i}'];
end
N=size(allPoints,1);
opts=statset('MaxIter',500);
k=30;
[IDX,Centroid] = kmeans(allPoints,k,'options',opts);

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

% Compute density functions of fibers
DF=zeros(k,s);
beg=zeros(s,1);
en=beg;
j=1;
for i=1:s,
   beg(i)=j; 
   e=j+size(fibers{i},2)-1;
   en(i)=e;
   DF(:,i)=full(sum(M(j:e,:))/sum(sum(M(j:e,:))))';
   j=e+1;
end
end

