% This script compute the error per cluster and plot it

i=4;
clusterError=sqrt(sum((groundtruth{i}-F{i}).^2))';
figure(2);
scatter(allPoints{1}*v1',allPoints{1}*v2',10,M{1}*clusterError);