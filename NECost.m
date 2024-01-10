function out = NECost(x1,u1,Q,R,T,N)
%     J = zeros(N,1);
    out = 0;
    for tau = 1:T-1
        out = out + (x1(:,tau+1)'*Q(:,:,1,tau+1)*x1(:,tau+1));
        if((x1(:,tau+1)'*Q(:,:,1,tau+1)*x1(:,tau+1)) < 0)
            disp('not ok')
        end
        for i = 1:N
            out = out + u1(:,tau)'*R(:,:,i,tau)*u1(:,tau);
            if((u1(:,tau)'*R(:,:,i,tau)*u1(:,tau)) < 0)
                disp('not ok 2')
            end
        end
    end
end