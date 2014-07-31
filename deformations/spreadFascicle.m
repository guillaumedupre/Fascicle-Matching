  function [fibers,basis] = spreadFascicle(fibers,b,e,shift1,shift2)

s=size(fibers,1);
allPoints=[];

for i=1:s,
   allPoints=[allPoints;fibers{i}'];
end

V=(e-b);
m=(0.9*e+0.1*b);
L=pdist2(e,b);
V=V/norm(V);
V1=[1,0,-V(1)/V(3)];
V2=[0,1,-V(2)/V(3)];

basis=orth([V1;V2]')';
Dir=shift1*basis(1,:)+shift2*basis(2,:);

for i=1:s,
    newPoints=[];
    np=size(fibers{i},2);
    pCentered=fibers{i}'-repmat(m,[np 1]);
    ind=find(pCentered*V'>=0);
    left=pCentered*Dir'>0;
    c=sum(left(ind))/size(ind,1);
    if c>0,
      newPoints=(fibers{i}'+(pCentered*V')*Dir)';
    else
      newPoints=(fibers{i}'-(pCentered*V')*Dir)';
    end
     fibers2{i}=fibers{i};
     fibers2{i}(:,ind)=newPoints(:,ind);
    
end
fibers=fibers2';

 end