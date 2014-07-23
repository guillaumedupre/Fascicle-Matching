for i=1:30,
    i
   v=zeros(30,1);v(i)=1;

    plot2D(allPoints{1},v1,v2,1,axis,M{1}*v)
%    for i=3:2:7,
% 
%    plot2D(allPoints{i},v1,v2,i,axis,M{i}*F{i}*v);
%    end
  
getframe;
pause
end