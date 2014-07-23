function [] = plotFibers(fibers,f,color)
figure(f);
hold on;
s=size(fibers,1);
s
x=[];y=[];z=[];
for i=1:s,


  plot3(fibers{i}(1,:),fibers{i}(2,:),fibers{i}(3,:),'Color',color);


end
hold off;

end

