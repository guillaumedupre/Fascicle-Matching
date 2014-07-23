 function [fibers,b,e] = cleanFibers(fibers)

% This function put all the fibers in the same direction

s=size(fibers,1);
b=[];
for i=1:s,
    b=[b;fibers{i}(:,1)'];
end
[IDX,Centroid] = kmeans(b,2);
if norm(Centroid(1,:))<norm(Centroid(2,:)),
   toflip=2;
   b=Centroid(1,:);
   e=Centroid(2,:);
else
    toflip=1;
    b=Centroid(2,:);
    e=Centroid(1,:);
end
for i=1:s,
    if IDX(i)==toflip,
        fibers{i}=fliplr(fibers{i});
    end
end

end

