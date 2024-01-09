function out = NECost(x1,u1,Q,R,T,N)
    J = zeros(N,1);
    for i = 1:N
        for tau = 1:T-1
            J(i) = J(i) + (x1(:,tau+1)'*Q(:,:,i,tau+1)*x1(:,tau+1))+u1(:,tau)'*R(:,:,i,tau)*u1(:,tau);
        end
        J(i) = J(i) + (x1(:,T)'*Q(:,:,i,T)*x1(:,T));
    end
    out = sum(J,"all")/N;
end