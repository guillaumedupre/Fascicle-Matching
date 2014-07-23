function [] = plot2D2(fibers,v1,v2,f,val,colormap)

%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


figure(f);
s=size(fibers,1);
i=1;
hold on;
for j=1:s,
    j
   n=size(fibers{j},2);
    for k=1:(n-1),
      x=[fibers{j}(:,k)'*v1',fibers{j}(:,k+1)'*v1'];
      y=[fibers{j}(:,k)'*v2',fibers{j}(:,k+1)'*v2'];
      plot(x,y,'Color',getColor(val(i),colormap));
 
      i=i+1;

    end
    i=i+1;
   
end
hold off;


end

