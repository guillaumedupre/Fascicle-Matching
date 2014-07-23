% x = linspace(0,10);
% y1 = sin(x);
% y2 = sin(5*x);
% 
% figure
% subplot(2,2,1);
% plot(x,y1)
% axis off
% 
% subplot(2,2,2);
% plot(x,y2)
% axis off
% 
% subplot(2,2,3);
% plot(x,y1)
% axis off


 v1=e-b;
 v1=v1/norm(v1);
 v2=basis(2,:)/norm(basis(2,:));
 C=3;
 cv=[19,20,21];
 for c=1:C,
v=zeros(30,1);v(cv(c))=1;
 subplot(C,N+1,1+(c-1)*(N+1));
 
 a=plot2D(allPoints{1},v1,v2,1,[],M{1}*v);
 axis off
 for i=2:(N+1),
   subplot(C,N+1,i+(c-1)*(N+1));
   plot2D(allPoints{i},v1,v2,1,a,M{i}*F{i}*v);  
    axis off
 end
 end