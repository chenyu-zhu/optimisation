x0 = -3/4;
y0 = 1;

m_iteration=10000;
x=zeros(2,3);

record_lost = [];
record_1 = [];
record_2 = [];
xt=zeros(2,3);
x(1,1)=x0;
x(2,1)=y0;
x(1,2)=1;
x(2,2)=0;
x(1,3)=0;
x(2,3)=1;
for i =1:m_iteration
    if i==1
        xt=x(:,1:3);
    end
    xc=(xt(:,1)+xt(:,2)+xt(:,3))/3;
    f1=100*(xt(2,1)-xt(1,1)^2)^2+(1-xt(1,1))^2;
    f2=100*(xt(2,2)-xt(1,2)^2)^2+(1-xt(1,2))^2;
    f3=100*(xt(2,3)-xt(1,3)^2)^2+(1-xt(1,3))^2;
    faverage=(f1+f2+f3)/3;
    if ((f1-faverage)^2+(f2-faverage)^2+(f3-faverage)^2)/3<0.0000000001
        break;
    end
    if f1>=f2 && f1>=f3
      %  for a=1.8:0.1:3
       %     xtem=xc+a*(xc-xt(:,1));
          %  if f1>100*(xtem(2,1)-xtem(1,1)^2)^2+(1-xtem(1,1))^2
                  xt(:,1)=xc+1*(xc-xt(:,1));
            %      break;
        %    end
       % end
        x=[x,xt(:,1)];
    elseif f2>=f1 && f2>=f3
       % for a=1.8:0.1:3
         %   xtem=xc+a*(xc-xt(:,2));
          %  if f2>100*(xtem(2,1)-xtem(1,1)^2)^2+(1-xtem(1,1))^2
                  xt(:,2)=xc+1*(xc-xt(:,2));
           %       break;
          %  end
       % end
        x=[x,xt(:,2)];
    elseif f3>=f2 && f3>=f1
       % for a=1.8:0.1:3
           %  xtem=xc+a*(xc-xt(:,3));
          %  if f3>100*(xtem(2,1)-xtem(1,1)^2)^2+(1-xtem(1,1))^2
                  xt(:,3)=xc+1*(xc-xt(:,3));
              %    break;
          %  end
      %  end
        x=[x,xt(:,3)];
    end
    
end

for j=1:length(x)
    record_1 = [record_1 x(1,j)];
    record_2 = [record_2 x(2,j)];
    lost = log((x(1,j)-1)^2 + (x(2,j)-1)^2);
    record_lost = [record_lost lost];
end

%
xx = linspace(-1.2,1.2);
yy = linspace(-1,1.5);
[X,Y] = meshgrid(xx,yy);
v = 100*(Y-X.^2).^2+(1-X).^2;
% contour(X,Y,v,[0,1,2,3,10,20,50,100,200,300]);
% hold;
Xplot=0:15;
% xlabel('x');
% ylabel('y');
% plot(record_1,record_2,'-*');
plot(Xplot,record_lost(1:16));
xlabel('k');
ylabel('cost');
