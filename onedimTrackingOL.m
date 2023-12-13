function [x1,u1] = onedimTrackingOL(A,B,Q,R,T,x0,n,m,w,W,K0)
    x1 = zeros(n,T);
    u1 = zeros(m,T);
    x1(:,1) = x0;

    P = zeros(n,n,T);
    K = zeros(m,n,T-1);
    
    for t = 1:T-1
        ind = (t+W)*(t+W <= T) + T*(t+W>T);
        if(ind == T)
            P(:,:,T) = Q(:,:,T);
        else
            P(:,:,T) = Q(:,:,ind);
        end
    
        for i = T-1:-1:1
            if(i > ind)
                tempR = R(:,:,ind);   %R in index i with given information at t
                tempQ = Q(:,:,ind);
            end
            if(i <= ind)
                tempR = R(:,:,i);
                tempQ = Q(:,:,i);
            end
              K(:,:,i) = -inv(tempR+(B')*P(:,:,i+1)*B)*(B')*P(:,:,i+1)*A;
              P(:,:,i) = (A')*P(:,:,i+1)*A+tempQ+(A')*P(:,:,i+1)*B*K(:,:,i);
        end
        
        x_tcond = x0;
        for j = 1:t-1
            x_tcond = (A+B*K(:,:,j))*x_tcond + w(:,j);
        end
        u1(:,t) = K0*(x1(:,t)-x_tcond) + K(:,:,t)*x_tcond;
        x1(:,t+1) = A*x1(:,t)+B*u1(:,t)+w(:,t);
    end
end