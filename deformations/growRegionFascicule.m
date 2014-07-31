 function fibers2 = growRegionFascicule(fibers,startPoint,endPoint,basis,shift1,shift2,I)
 % This function transforms a fascicle. It grows a chosen area of a
 % fascicle.

% Parameters :
%
% fibers : original fascicle
% startPoint : average start point of the original fascicle
% endPoint : average end point of the original fascicle
% basis : cross-section basis
% shift1 : transformation applied in the direction of the first vector of the cross-section basis
% shift2 : transformation applied in the direction of the second vector of the cross-section basis
% I : Normalized interval along the main axis where the growth happen

mid=(I(1)+I(2))/2;
V=endPoint-startPoint;
V=V/norm(V);
L=pdist2(startPoint,endPoint);

Dir=shift1*basis(1,:)+shift2*basis(2,:);

clear fibers2;
s=size(fibers,1);
for i=1:s,
   np=size(fibers{i},2);
   points=fibers{i}'-repmat(startPoint,[np 1]);
   projValue=points*V'/L;
   projValue2=-(projValue-I(1)).*(projValue-I(2));
   projValue2=projValue2./max(projValue2);
   pointDistance=(points*Dir');
   pointDistance=pointDistance/max(pointDistance);
   ind=find((projValue2>=0).*(pointDistance>=0));
   fibers2{i}=fibers{i};
   fibers2{i}(:,ind)=(fibers{i}(:,ind)'+(projValue2(ind).*pointDistance(ind))*Dir)';

end
fibers2=fibers2';
 end