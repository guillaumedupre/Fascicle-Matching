function [c] = getColor(v,colormap)
i=floor(v*63)+1;
c=colormap(i,:);

end

