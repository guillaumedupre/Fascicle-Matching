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
% I : Normalized interval along the main axis where the growth happen in
% [0,1]


midPoint=(I(1)+I(2))/2;

% Vector of the main axis
mainAxis=endPoint-startPoint;mainAxis=mainAxis/norm(mainAxis);

% Length of the fascicle
L=pdist2(startPoint,endPoint);

% Vector of the direction of the growth (linear combination of the vectors
% of the cross-section basis)
growthDirection=shift1*basis(1,:)+shift2*basis(2,:);

% Number of fibers
s=size(fibers,1);
clear fibers2;
for i=1:s,
   
   % Number of vertices of fibers{i}
   numberPoints=size(fibers{i},2);
   
   % Vectors from startPoint to every vertices
   pointVectors=fibers{i}'-repmat(startPoint,[numberPoints 1]);
   
   % Projection of the points on the main axis 
   mainAxisProjection=pointVectors*mainAxis'/L;
   
   % Displacement value
   displacement=-(mainAxisProjection-I(1)).*(mainAxisProjection-I(2));
   displacement=displacement/max(displacement);
   
   % Projection of the points on the vector of the direction of the growth
   growthDirectionProjection=(pointVectors*growthDirection');
   growthDirectionProjection=growthDirectionProjection/max(growthDirectionProjection);
   
   % Indices of the vertices to be moved 
   ind=find((displacement>=0).*(growthDirectionProjection>=0));
   
   % Move the points
   %displacement(ind).*growthDirectionProjection(ind)
   fibers2{i}=fibers{i};
   fibers2{i}(:,ind)=(fibers{i}(:,ind)'+(displacement(ind).*growthDirectionProjection(ind)*growthDirection))';

end
fibers2=fibers2';
end