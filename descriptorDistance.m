function [D] = descriptorDistance(fibers,M)
D=[];
s=size(fibers,1);
d=[];
for i=1:s,
    v=linspace(0,1,size(fibers{i},2))';
    d=[d;v];
end
dx=linspace(0,1,11);
for i=1:10,
   d2=(d>=dx(i)).*(d<dx(i+1)); 
   D1=(M'*d2);
D1=D1/sum(D1);
D=[D,D1];
end

end

