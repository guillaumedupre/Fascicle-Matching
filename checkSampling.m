function [error] = checkSampling(fibers)
% This function check where the fibers have a 1mm sampling

s=size(fibers,1);
R=1;
error=0;
for f=1:s,
    n=size(fibers{f},2);
    P=fibers{f}';
    for i=1:(n-1);
        error=error+(pdist2(P(i,:),P(i+1,:))-1)^2;
    end
end

end

