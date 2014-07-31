 for j=1:30,
    % Segmentation function on the first fascicle
    v=zeros(30,1);v(j)=1;

     for i=1:(N+1),
        subplot(1,N+1,i);
        % Compute and plot the function on fascicle i using the Functional Map
         scatter(allPoints{i}*v1',allPoints{i}*v2',10,M{i}*F{i}*v);   
        axis off
     end
    getframe
    pause
end
