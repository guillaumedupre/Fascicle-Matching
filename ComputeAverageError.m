% This script runs DeformAndMatchFascicle several times
% in order to compute an average error 

% Number of runs
nbRuns=4;
% Number of modified fascicle 
N=3;
% Array that store the sum of the errors across several runs
averageError=zeros(1,N);

for r=1:nbRuns,
    disp('Run number :');
    disp(r);
    DeformAndMatchFascicle
    averageError=averageError+error;
    
end