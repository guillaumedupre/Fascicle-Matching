 function [fibers,basis] = shearFascicle(fibers,b,e,shift1,shift2)
s=size(fibers,1);
allPoints=[];

for i=1:s,
   allPoints=[allPoints;fibers{i}'];
end

V=e-b;
L=pdist2(e,b);
V=V/norm(V);
V1=[1,0,-V(1)/V(3)];
V2=[0,1,-V(2)/V(3)];

basis=orth([V1;V2]')';
Dir=shift1*basis(1,:)+shift2*basis(2,:);

na=size(allPoints,1);
allPoints2=[];
for i=1:na,
    p=allPoints(i,:);
    p=p-b;
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