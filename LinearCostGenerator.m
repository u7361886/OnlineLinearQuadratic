function [Q,R] = LinearCostGenerator(qrangeLower,qrangeHigher,rrangeLower,rrangeHigher,n,m,T)
    Q = zeros(n,n,T);
    R = zeros(m,m,T);
    for t = 1:T
        Q(:,:,t) = qrangeLower+qrangeHigher*diag(rand(1,n));
        R(:,:,t) = rrangeLower+rrangeHigher*diag(rand(1,m));
    end
end