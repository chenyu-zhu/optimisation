x0 = -3/4;
y0 = 1;

m_iteration=10000;
x=zeros(2,m_iteration+1);
gradient=zeros(2,1);
gamma=[];
v=[];
record_lost = [];
record_1 = [];
record_2 = [];
alpha = 0.3;
beta = 0.5;
for i =1:m_iteration
     if(i==1)
        x(1,i)=x0;
        x(2,i)=y0;
    end
    gradient(1) = -400*x(1,i)*(x(2,i)-x(1,i)^2) - 2*(1-x(1,i));
    gradient(2) = 200*(x(2,i)-x(1,i)^2);
   
    if i==1
        H=eye(2,2);
    else
        gamma_1=-400*x(1,i)*(x(2,i)-x(1,i)^2)-2*(1-x(1,i))-(-400*x(1,i-1)*(x(2,i-1)-x(1,i-1)^2) - 2*(1-x(1,i-1)));
        gamma_2=200*(x(2,i)-x(1,i)^2)-(200*(x(2,i-1)-x(1,i-1)^2));
        gamma=[gamma_1;gamma_2];
        delta=x(:,i)-x(:,i-1);
        v=(gamma'*H*gamma)^(1/2)*(delta/(delta'*gamma)-H*gamma/(gamma'*H*gamma));
        H=H+delta*delta'/(delta'*gamma)-H*gamma*gamma'*H/(gamma'*H*gamma)+v*v';
    end
        direction=-H*gradient;
    
    
  if(sqrt(gradient'*gradient)<10^-8)
        break;
    end
    
    step = 1;
    
    while(true)
        x_possible = x(:,i) + step*direction;
        p1 = 100*(x_possible(2)-x_possible(1)^2)^2+(1-x_possible(1))^2;
        p2 = 100*(x(2,i)-x(1,i)^2)^2+(1-x(1,i))^2;
        p2 = p2 + step*alpha*gradient'*direction;
        
        if p1 <= p2
            break
        else
            step = step*beta;
        end
    end
    record_1 = [record_1 x(1,i)];
    record_2 = [record_2 x(2,i)];
    lost = log((x(1,i)-1)^2 + (x(2,i)-1)^2);
    record_lost = [record_lost lost];
    x(:,i+1)=x(:,i)+step*direction;
end

%
x = linspace(-1.2,1.2);
y = linspace(-1,1.5);
[X,Y] = meshgrid(x,y);
v = 100*(Y-X.^2).^2+(1-X).^2;
% contour(X,Y,v,[0,1,2,3,10,20,50,100,200,300]);
% hold;
Xplot=0:length(record_1)-1;
% xlabel('x');
% ylabel('y');
% plot(record_1,record_2,'-*');
plot(Xplot,record_lost);
xlabel('k');
ylabel('cost');
