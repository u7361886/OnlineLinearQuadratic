function [x1,u1] = onedimJingtao(A,B,Q,R,T,x0,n,m,w,W,d)

    x1 = zeros(n,T);
    u1 = zeros(m,T);
    x1(:,1) = x0;
    K = zeros(m,n,T-1);
    wNumber = d*floor(W/d);
    for t = 1:d:T
        % terminal cost X
        if(t+wNumber < T)
            X = Q(:,:,t+wNumber) + A'*inv(B*B')*B*R(:,:,t+wNumber)*B'*inv(B*B')*A;
        else
            X = Q(:,:,T);
        end
        for tau = min(t+wNumber-1,T-1):-1:t
            K(:,:,tau) = -inv(R(:,:,tau)+(B')*X*B)*(B')*X*A;
            X = (A')*X*A+Q(:,:,tau)+(A')*X*B*K(:,:,tau);
        end
        for n = 0:min(d-1,T-t-1)
            u1(:,t+n) = K(:,:,t+n)*x1(:,t+n);
            x1(:,t+n+1) = A*x1(:,t+n) + B*u1(:,t+n) + w(:,t+n);
        end
    end
end
