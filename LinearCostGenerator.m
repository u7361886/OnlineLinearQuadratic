function [Q,R] = LinearCostGenerator(qrangeLower,qrangeHigher,rrangeLower,rrangeHigher,n,m,T)
    Q = zeros(n,n,T);
    R = zeros(m,m,T);
    for t = 1:T
        Q(:,:,t) = qrangeLower*eye(n)+qrangeHigher*diag(rand(1,n));
        R(:,:,t) = rrangeLower*eye(m)+rrangeHigher*diag(rand(1,m));
    end
end