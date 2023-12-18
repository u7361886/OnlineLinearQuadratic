function [x1,u1] = onedimOnestepOL(A,B,Q,R,T,x0,n,m,w,W,d)
    x1 = zeros(n,T);
    u1 = zeros(m,T);
    x1(:,1) = x0;
    P = zeros(n,n,T);
    K = zeros(m,n,T-1);
    
    for t = 1:d:T
        ind = (t+W)*(t+W <= T) + T*(t+W>T);
        if(ind == T)
            P(:,:,T) = Q(:,:,T);
        elseif(ind <= 0)
            P(:,:,T) = Q(:,:,1);
        else
            P(:,:,T) = Q(:,:,ind);
        end
    
        for i = T-1:-1:1
            if(i > ind)
                tempR = R(:,:,ind);   %R in index i with given information at t
                tempQ = Q(:,:,ind);
            elseif(i <= ind)
                tempR = R(:,:,i);
                tempQ = Q(:,:,i);
            end
              K(:,:,i) = -inv(tempR+(B')*P(:,:,i+1)*B)*(B')*P(:,:,i+1)*A;
              P(:,:,i) = (A')*P(:,:,i+1)*A+tempQ+(A')*P(:,:,i+1)*B*K(:,:,i);
        end
        for n = 0:min(d-1,T-t-1)
            u1(:,t+n) = K(:,:,t+n)*x1(:,t+n);
            x1(:,t+n+1) = A*x1(:,t+n) + B*u1(:,t+n) + w(:,t+n);
        end
    end
end
