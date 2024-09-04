n = 3;
m = 2;
x0 = rand(n,1)*100;
A = rand(n,n)*10;
B = rand(n,m)*10;
d = 2;
u = rand(d*m,1);
contB = [A*B,B];
% contB = [A^2*B,A*B,B];
% xexpect = 100*rand(n,1);
xexpect = 0;
u = inv(contB'*contB)*contB'*(xexpect-A^d*x0);
% xtry = x0;
u2 = linsolve(contB,xexpect-A^d*x0);
xtry = A^d*x0+contB*u
xtry2 = A^d*x0+contB*u2
% for t = 1:d
%     xtry = A*xtry+B*u(1+(t-1)*m:t*m);
% end
% norm(A^3*x0+contB*u-xexpect,2)