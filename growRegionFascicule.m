 function [fibers2,basis] = shearFascicle(fibers,b,e,shift1,shift2)
% fibers=fascicles(1).fascicles(2).fibers;
% [fibers,b,e]=cleanFibers(fibers);

p1=0.2;
p2=0.5;
mid=(p1+p2)/2;
V=e-b;
V2=V;
L=pdist2(e,b);
V=V/norm(V);
V1=[1,0,-V(1)/V(3)];
V2=[0,1,-V(2)/V(3)];

basis=orth([V1;V2]')';
Dir=shift1*basis(1,:)+shift2*basis(2,:);

clear fibers2;
s=size(fibers,1);
for i=1:s,
   np=size(fibers{i},2);
   points=fibers{i}'-repmat(b,[np 1]);
   projValue=points*V'/L;
   projValue2=-(projValue-p1).*(projValue-p2);
   projValue2=projValue2./max(projValue2);
   pointDistance=(points*Dir');
   pointDistance=pointDistance/max(pointDistance);
   ind=find((projValue2>=0).*(pointDistance>=0));
   fibers2{i}=fibers{i};
   fibers2{i}(:,ind)=(fibers{i}(:,ind)'+(projValue2(ind).*pointDistance(ind))*Dir)';

end
fibers2=fibers2';
 end