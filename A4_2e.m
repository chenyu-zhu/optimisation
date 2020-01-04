x0 = -3/4;
y0 = 1;

m_iteration=10000;
x=zeros(2,m_iteration+1);
gradient=zeros(2,1);
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
    hessian = zeros(2,2);
    hessian1_1 = -400*(x(2,i)-3*x(1,i)^2)+2;
    hessian1_2 = -400*x(1,i);
    hessian2_1 = -400*x(1,i);
    hessian2_2 = 200;
    hessian(1,1) = hessian1_1; hessian(1,2) = hessian1_2;
    hessian(2,1) = hessian2_1; hessian(2,2) = hessian2_2;
    direction=-inv(hessian)*gradient;
    
    if(sqrt(gradient'*gradient)<10^-8)
        break;
    end
    
    step = 1;
    t = (sqrt(5)-1)/2;
    
    s=0.01;
    last_s=0.01;
    possible_a=0.01;
    while(true)
       s=s*1.1; 
       new_point=x(:,i)+s*direction;
       last_point=x(:,i)+last_s*direction;
       new_value=100*(new_point(2)-new_point(1)^2)^2 + (1-new_point(1))^2;
       old_value=100*(last_point(2)-last_point(1)^2)^2 + (1-last_point(1))^2;
       if(new_value>old_value)
            b=s;
            a=possible_a;
            break; 
       end
       last_s=s;
       possible_a=last_s;
    end
    
    p = a + (1-t)*(b-a); q = a + t*(b-a);
    x1_new1 = x(1,i) + direction(1) * p;
    x2_new1 = x(2,i) + direction(2) * p;
    x1_new2 = x(1,i) + direction(1) * q;
    x2_new2 = x(2,i) + direction(2) * q;
    phip = 100*(x2_new1 - x1_new1^2)^2 + (1-x1_new1)^2;
    phiq = 100*(x2_new2 - x1_new2^2)^2 + (1-x1_new2)^2;
    while(1)
        if phip<= phiq
            if (abs(b-a)>0.01) || (abs(phib-phia)>0.01)
                b = q; phib = phiq; phiq = phip;
                q = p;
                p = a + (1-t)*(b-a);
                x1_new1 = x(1,i) + direction(1) * p;
                x2_new1 = x(2,i) + direction(2) * p;
                phip = 100*(x2_new1 - x1_new1^2)^2 + (1-x1_new1)^2;
            else 
                break;
            end
        else
            if (abs(b-a)>0.01) || (abs(phib-phia)>0.01)
                a = p; phia = phip; phip = phiq;
                p = q;
                q = a + t*(b-a);
                x1_new2 = x(1,i) + direction(1) * q;
                x2_new2 = x(2,i) + direction(2) * q;
                phiq = 100*(x2_new2 - x1_new2^2)^2 + (1-x1_new2)^2;
            else
                break;
            end
        end
    end
    step = b;
    
    record_1 = [record_1 x(1,i)];
    record_2 = [record_2 x(2,i)];
    lost = log((x(1,i)-1)^2 + (x(2,i)-1)^2);
    record_lost = [record_lost lost];
    x(:,i+1)=x(:,i)+step*direction;
end

%
x = linspace(-1,1.5);
y = linspace(-1,1.5);
[X,Y] = meshgrid(x,y);
v = 100*(Y-X.^2).^2+(1-X).^2;
contour(X,Y,v,100);
hold;
Xplot=1:i-1;
plot(record_1,record_2,'-*');

