% This script computes a functional map between two fascicles

k=30; % Number of clusters

clear fibers;
% Load the fascicles
fibers{1}=fascicles(1).fascicles(2).fibers;
fibers{2}=fascicles(2).fascicles(2).fibers;
% Line up all the fibers in the same direction and return a startPoint and
% endPoint
[fibers{1},startPoint,endPoint]=cleanFibers(fibers{1});
[fibers{2},startPoint,endPoint]=cleanFibers(fibers{2});

% Compute a cross-section basis used to apply deformations
V=endPoint-startPoint;
V=V/norm(V);
V1=[1,0,-V(1)/V(3)];
V2=[0,1,-V(2)/V(3)];
basis=orth([V1;V2]')';

disp('Preprocess fascicles');
clear allPoints;clear M;clear P;clear D;
for i=1:2,
        disp(i)
        % Preprocess the fasicle : cluster the fascicle 
        % allPoints : Array of all the vertices of all the fibers
        % M : cluster mask (M(p,c)=1 if point p is in cluster c)
        % P : probability transition Markov matrix (normalized adjancy
        % matrix of the clusters)
        % Given a point in cluster i, P(i,j) is the probability that the
        % next point (on its fiber) is in cluster j
        [M{i},P{i},allPoints{i}] = clusterFascicule(fibers{i},k);
        
        
        % The descriptor functions can be any probability density function
        % (position function on the clusters that sums up to 1)
        %
        %
        % Compute the distance descriptor
        % For different values of l in [0,1], clusters at distance <=l from the
        % startPoint==1 otherwise 0
        D{i} = descriptorDistance(fibers{i},M{i});
        %
        % /!\ TO BE IMPROVED /!\ : Distance functions are not guaranted to
        % be corresponding, need better descriptors
        %
end

% Compute the Functional Maps between fascicle 1 and fascicle 2 X
% Continuity constraint
%A = sum(sum(abs(X*P{1}-P{2}*X)));
% Descriptor consistency constraint
%B  = sum(sum(abs(X*D{1}-D{2}))); 
cvx_begin
variable X(k,k)
minimize sum(sum(abs(X*P{1}-P{2}*X)))+sum(sum(abs(X*D{1}-D{2})))
subject to
sum(X)==1
X>=0
cvx_end
% Functional map between fasicle 1 and 2 :
F{2}=X;
% Functional map between fasicle 1 and 1 :
F{1}=eye(30);

disp('Plot Fascicles');
% Plot segmentation transfert for 3 clusters on all fascicles
 clusterIndices=[1,2,3];
% Compute a basis for 2D project of the fascicle, the basis shows the
% deformation well
 v1=endPoint-startPoint;
 v1=v1/norm(v1);
 v2=basis(2,:)/norm(basis(2,:));

 for j=1:length(clusterIndices),
    % Segmentation function on the first fascicle
    v=zeros(30,1);v(clusterIndices(j))=1;

     for i=1:2,
         f=M{i}*F{i}*v;
         
        subplot(length(clusterIndices),2,i+(j-1)*2);
        % Compute and plot the function on fascicle i using the Functional Map
         scatter(allPoints{i}*v1',allPoints{i}*v2',10,f);   
        axis off
    end
end



