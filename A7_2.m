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
    F=[f1,f2,f3];
    faverage=(f1+f2+f3)/3;
    if ((f1-faverage)^2+(f2-faverage)^2+(f3-faverage)^2)/3<0.0000000001
        break;
    end
    [Fs,index]=sort(F);
    sx=[xt(:,index(1)),xt(:,index(2)),xt(:,index(3))];
    xr=sx(:,1)+sx(:,2)-sx(:,3);
    if 100*(xr(2,1)-xr(1,1)^2)^2+(1-xr(1,1))^2<Fs(1)
        xe=-0.5*0.5*(xt(:,1)+xt(:,2))+1.5*xr;
        if 100*(xr(2,1)-xr(1,1)^2)^2+(1-xr(1,1))^2>100*(xe(2,1)-xe(1,1)^2)^2+(1-xe(1,1))^2
            xt(:,3)=xe;
            xt(:,1:2)=sx(:,1:2);
            x=[x,xe];
        else
            xt(:,3)=xr;
            xt(:,1:2)=sx(:,1:2);
            x=[x,xr];
        end
    elseif 100*(xr(2,1)-xr(1,1)^2)^2+(1-xr(1,1))^2>Fs(3) 
        xr=(0.5*(sx(:,1)+sx(:,2))+sx(:,3))/2;
        if 100*(xr(2,1)-xr(1,1)^2)^2+(1-xr(1,1))^2<Fs(3)
            xt(:,3)=xr;
            xt(:,1:2)=sx(:,1:2);
            x=[x,xr];
        else
            xt(:,2)=0.5*(sx(:,1)+sx(:,2));
            xt(:,3)=0.5*(sx(:,1)+sx(:,3));
            xt(:,1)=sx(:,1);
            x=[x,xt(:,2:3)];
        end
    else
        xt(:,3)=xr;
        xt(:,1:2)=sx(:,1:2);
        x=[x,xr];
    end
    %x(:,3*i+1:3*i+3)=xt(:,1:3);
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
Xplot=0:length(record_1)-1;
% plot(record_1,record_2,'-*');
plot(Xplot,record_lost);
xlabel('k');
ylabel('cost');
