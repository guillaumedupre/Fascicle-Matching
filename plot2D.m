function [a] = plot2D(allPoints,v1,v2,f,a,val)

%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
figure(f);
if length(val)==0
scatter(allPoints*v1',allPoints*v2');
else
 scatter(allPoints*v1',allPoints*v2',10,val)   
end
if length(a)==0,
a=[xlim ylim];
else
   % axis(a)
end
end

