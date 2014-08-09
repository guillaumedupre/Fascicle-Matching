function [allPoints] = fascicleVertices(fibers)

% This function returns all the vertices of a fascicle in an array

s=size(fibers,1);
allPoints=[];
for i=1:s,
   allPoints=[allPoints;fibers{i}'];
end

end

