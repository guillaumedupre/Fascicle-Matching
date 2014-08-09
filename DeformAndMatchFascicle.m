% This script applies several times a deformation to a given fascicle and
% compute functional maps between the modified fascicles and the original
% one
addpath('deformations/');

k=30; % Number of clusters
N=5; % Number of modified fascicles
maxTransformationParameter=[0 25]; % Maximum value of the parameters of the transformation applied

clear fibers;
% Load the first (original) fascicle
fibers{1}=fascicles(1).fascicles(2).fibers;
% Line up all the fibers in the same direction and return a startPoint and
% endPoint
[fibers{1},startPoint,endPoint]=cleanFibers(fibers{1});

% Apply a transformation to the first fascicles to compute N other
% fascicles
disp('Compute modified fascicles');

% Array of linearly space parameter values
transformationParameters1=linspace(0,maxTransformationParameter(1),N+1);transformationParameters1(1)=[];
transformationParameters2=linspace(0,maxTransformationParameter(2),N+1);transformationParameters2(1)=[];

% Compute a cross-section basis used to apply deformations
V=endPoint-startPoint;
L=pdist2(endPoint,startPoint);
V=V/norm(V);
V1=[1,0,-V(1)/V(3)];
V2=[0,1,-V(2)/V(3)];
basis=orth([V1;V2]')';


for i=1:N,
    disp(i);
    % Compute the fascicle i+1 by applying a deformation to the first
    % fascicle
    deformedFascicle=growRegionFascicule(fibers{1},startPoint,endPoint,basis,transformationParameters1(i),transformationParameters2(i),[0.2,0.5]);
    %fibers{i+1}=shearFascicle(fibers{1},startPoint,endPoint,basis,transformationParameters1(i),transformationParameters2(i));
    
    % Store the fascicle before resampling (in order to compute the error
    % later)
    fibersNotResampled{i+1}=deformedFascicle;
    
    % Resample the fiber
    fibers{i+1}=resampleFibers(deformedFascicle);
end

disp('Preprocess fascicles');
clear allPoints;clear M;clear P;clear D;clear clusterGroundtruth;
for i=1:(N+1),
        disp(i)
        % Preprocess the fasicle : cluster the fascicle 
        [M{i},P{i},allPoints{i},centroid{i}] = clusterFascicule(fibers{i},k);
        % Compute the distance descriptor
        D{i} = descriptorDistance(fibers{i},M{i});
        
        % Compute cluster groundtruth
        if i>1,
             % Array of vertices of fascicle i before resampling 
              verticesNotResample=fascicleVertices(fibersNotResampled{i});
             % Corresponding cluster to each point 
              matchedCluster=dsearchn(centroid{i},verticesNotResample);
           for c=1:k, % for each cluster
              % Cluster index corresponding to each point in cluster c on fascicle 1 
              clusterIndices=matchedCluster(find(M{1}(:,c)));
              % Bin count of cluster indices
              clusterBinCount=histc(clusterIndices,1:k);
              groundtruth{i}(:,c)=clusterBinCount/size(clusterIndices,1);
            
           end
        end
end

 
% Compute the Functional Maps between fascicle 1 and fascicle i
disp('Compute Functional Maps');
clear F;

for i=2:(N+1),
    cvx_begin
    variable X(30,30)
    minimize sum(sum(abs(X*P{1}-P{i}*X)))+sum(sum(abs(X*D{1}-D{i})))
    subject to
    sum(X)==1
    X>=0
    cvx_end
    F{i}=X;

end
F{1}=eye(k); % We set the functional map from fascicule 1 to itself to be the identity

% Compute error using groundtruth
error=[];
for i=2:(N+1);
   error=[error,norm(groundtruth{i}-F{i},'fro')]; 
end


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

     for i=1:(N+1),
        subplot(3,N+1,i+(j-1)*(N+1));
        % Compute and plot the function on fascicle i using the Functional Map
         scatter(allPoints{i}*v1',allPoints{i}*v2',10,M{i}*F{i}*v);   
        axis off
    end
end



