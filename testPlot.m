val=[];
clear Var;
for i=1:7,
   cent=[];
   for c=1:30,
   ind=find(M{i}(:,c)==1);
   cent=[cent;mean(allPoints{i}(ind,:))];
   end
   Var{i}=squareform(pdist(cent));
    
end
for i=2:7,
 % val=[val,size(allPoints{i},1)]
  vb=(F{i}*v)>0.03;
% 

  vb=vb/sum(vb);
  vb=F{i}*v;
%    plot2D(allPoints{i},v1,v2,1,axis,M{i}*vb);  
%    getframe
%    pause
% 
  val=[val,vb'*Var{i}*vb]
end