function [x,u] = onedimLina(A,B,Q,R,T,x0,n,m,w,W,Qmax,Rmax)
    x = zeros(n,T);
    u = zeros(m,T);
    x(:,1) = x0;
    Pmax = idare(A,B,Qmax,Rmax,zeros(size(B)),eye(size(A,1)));
    
    if(W == 0)
        K0 = -inv(B'*Pmax*B)*B'*Pmax*A;
        for t = 1:T-1
            u(:,t) = K0*x(:,t);
            x(:,t+1) = A*x(:,t) + B*u(:,t) + w(:,t);
        end
    else
        P = zeros(n,n,W+1);
        K = zeros(m,n,W);
        for t = 1:T-W
            if(t+W >= T)
                P(:,:,W+1) = Q(:,:,T);
            else
                P(:,:,W+1) = Pmax;
            end
            for i = W:-1:1
                  K(:,:,i) = -inv(R(:,:,i+t-1)+(B')*P(:,:,i+1)*B)*(B')*P(:,:,i+1)*A;
                  P(:,:,i) = (A')*P(:,:,i+1)*A+Q(:,:,i+t-1)+(A')*P(:,:,i+1)*B*K(:,:,i);
            end
            u(:,t) = K(:,:,1)*x(:,t);
            x(:,t+1) = A*x(:,t) + B*u(:,t) + w(:,t);
        end
        for t = T-W+1:T-1
            u(:,t) = K(:,:,t-(T-W-1))*x(:,t);
            x(:,t+1) = A*x(:,t) + B*u(:,t) + w(:,t);
        end
    end
end
