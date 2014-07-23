k=30;
N=10;
clear fibers;
fibers{1}=fascicles(1).fascicles(2).fibers;
[fibers{1},b,e]=cleanFibers(fibers{1});


disp('Compute modified fascicles');
dgrowth=linspace(0,15,N+1);
dgrowth(1)=[];
for i=1:N,
    disp(i);
[fibers{i+1},basis]=growRegionFascicule(fibers{1},b,e,0,dgrowth(i));
fibers{i+1}=resampleFibers(fibers{i+1});
end

disp('Preprocess fascicles');
clear allPoints;clear M;clear A;clear DF;clear P;clear D;clear H;
for i=1:(N+1),
        disp(i)
[allPoints{i},M{i},A{i},DF{i}] = preprocess(fibers{i});

P{i}=A{i}./repmat(sum(A{i}),[k 1]);

D{i} = descriptorDistance(fibers{i},M{i});

% W{i}=diag(full(sum(M{i})));
% W{i}=W{i}/sum(sum(W{i}));
disp('Compute average distance');
W{i}=averageDistance(allPoints{i},M{i});
 end

disp('Compute FM and Diff');
clear F;clear Diff;
for i=2:(N+1),
cvx_begin
variable X(30,30)
minimize sum(sum(abs(X*P{1}-P{i}*X)))+sum(sum(abs(X*D{1}-D{i})))
 subject to
 sum(X)==1
 X>=0
cvx_end
F{i}=X;
Diff{i}=F{i}'*W{i}*F{i};

end
Diff{1}=W{1};


