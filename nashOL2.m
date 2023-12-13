function [x1,u1] = nashOL2(A,B,Q,R,T,x0,n,m,w,W,N,K0)
    x1 = zeros(n,T);
    u1 = zeros(m*N,T);
    x1(:,1) = x0;
    bigB = reshape(B,[2,N]);
    for t = 1:T-1
        Qt = zeros(n,n,N,T);
        Rt = zeros(N*m,N*m,N,T);
        for tau = 1:T
            index = (t+W)*(t+W <= T) + T*(t+W>T);
%             if(tau <= t+W)
%                 index = tau;
%             else
%                 index = t;
%             end
            for i = 1:N
                if(tau <= t+W)
                    Qt(:,:,i,tau) = Q(:,:,i,tau);
                    Rt(:,:,i,tau) = R(:,:,i,tau);
                else
                    Qt(:,:,i,tau) = Q(:,:,i,index);
                    Rt(:,:,i,tau) = R(:,:,i,index);
                end
%                 if(index == t+W)
%                     Rt(:,:,i,tau) = R(:,:,i,index);
%                 else
%                     Rt(:,:,i,tau) = R(:,:,i,index);
%                 end
            end
        end
        [x,u] = nashDGFB2(Qt,Rt,A,B,w,T,x0,n,m,N);
        u1(:,t) = u(:,t) + K0*(x1(:,t)-x(:,t));
        x1(:,t+1) = A*x1(:,t)+bigB*u1(:,t)+w(:,t);
    end
end

