function [fibers] = resampleFibers(fibers)
s=size(fibers,1);
R=1;
for f=1:s,
P=fibers{f}';
n=1;
current=P(1,:);
i=n;

newLine=[current];

stop=0;
while stop==0,
    i=n;
    distToCurrent=pdist2(current,P(n,:));
while distToCurrent<R && i<size(P,1),
    i=i+1;
    distToCurrent=pdist2(current,P(i,:));
end
n=i;
p1=P(i-1,:);
p2=P(i,:);
vect=p2-p1;

c=norm(p1-current)^2-R^2;
b=2*vect*(p1-current)';
a=norm(vect)^2;
d=b^2-4*a*c;
alpha=[(-b-sqrt(d))/(2*a),(-b+sqrt(d))/(2*a)];
if alpha<=1,
current=p1+max(alpha)*vect;
newLine=[newLine;current];
else 
    stop=1;
end
end
    
   fibers{f}=newLine';
    
end
end

