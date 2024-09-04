function [x,u] = onlineTrivial(A,B,K,x0,T,w,n,m)
    x = zeros(n,T);
    u = zeros(m,T);
    x(:,1) = x0;
    for t = 1:T
        u(:,t) = K*x(:,t);
        x(:,t+1) = A*x(:,t)+B*u(:,t)+w(:,t);
    end
end