function fibers = shearFascicle(fibers,startPoint,endPoint,basis,shift1,shift2)

 % This function shears a fascicle
% Parameters :
%
% fibers : original fascicle
% startPoint : average start point of the original fascicle
% endPoint : average end point of the original fascicle
% basis : cross-section basis
% shift1 : transformation applied in the direction of the first vector of the cross-section basis
% shift2 : transformation applied in the direction of the second vector of the cross-section basis

s=size(fibers,1);
allPoints=[];

for i=1:s,
   allPoints=[allPoints;fibers{i}'];
end

V=endPoint-startPoint;
L=pdist2(endPoint,startPoint);
V=V/norm(V);

Dir=shift1*basis(1,:)+shift2*basis(2,:);

na=size(allPoints,1);
allPoints2=[];
for i=1:na,
    p=allPoints(i,:);
    p=p-startPoint;
    if (V*p')/L>0,
       co=(V*p')/L;
    else 
        co=0;
    end
    p=allPoints(i,:)+co*Dir;
    allPoints2=[allPoints2;p];
end
for i=1:s,
    n=size(fibers{i},2);
    fibers{i}=allPoints2(1:n,:)';
    allPoints2(1:n,:)=[];

end
 end