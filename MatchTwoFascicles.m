% This script compute a functional map between two fascicles

k=30; % Number of clusters

clear fibers;
% Load the fascicles
fibers{1}=fascicles(1).fascicles(2).fibers;
fibers{2}=fascicles(2).fascicles(2).fibers;
% Line up all the fibers in the same direction and return a startPoint and
% endPoint
[fibers{1},startPoint,endPoint]=cleanFibers(fibers{1});
[fibers{2},startPoint,endPoint]=cleanFibers(fibers{2});

disp('Preprocess fascicles');
clear allPoints;clear M;clear P;clear D;
for i=1:2,
        disp(i)
        % Preprocess the fasicle : cluster the fascicle 
        [M{i},P{i},allPoints{i}] = clusterFascicule(fibers{i},k);
        % Compute the distance descriptor
        D{i} = descriptorDistance(fibers{i},M{i});
end

% Compute the Functional Maps between fascicle 1 and fascicle 2

cvx_begin
variable X(30,30)
minimize sum(sum(abs(X*P{1}-P{2}*X)))+sum(sum(abs(X*D{1}-D{2})))
subject to
sum(X)==1
X>=0
cvx_end
F{2}=X;
F{1}=eye(30);

disp('Plot Fascicles');
% Plot segmentation transfert for 3 clusters on all fascicles
 clusterIndices=[1,2,3];
% Compute a basis for 2D project of the fascicle, the basis shows the
% deformation well
 v1=endPoint-startPoint;
 v1=v1/norm(v1);
 v2=basis(2,:)/norm(basis(2,:));

 for j=1:3,
    % Segmentation function on the first fascicle
    v=zeros(30,1);v(clusterIndices(j))=1;

     for i=1:2,
        subplot(C,2,i+(j-1)*2);
        % Compute and plot the function on fascicle i using the Functional Map
         scatter(allPoints{i}*v1',allPoints{i}*v2',10,M{i}*F{i}*v);   
        axis off
    end
end



