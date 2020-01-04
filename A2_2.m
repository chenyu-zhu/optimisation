x = -1.5:0.01:1.5;
y = -2:0.01:2;

[X,Y]=meshgrid(x,y);
f = 100*(Y-X.^2).^2 + (1-X).^2;
mesh(X,Y,f);
