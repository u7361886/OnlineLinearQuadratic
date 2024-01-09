function out = onedimCost(x,u,Q,R,T)

    out = 0;
    for t = 1:T
       if(t == 1)
            out = (x(:,t)')*Q(:,:,t)*x(:,t);
       else
            out = out + (x(:,t)')*Q(:,:,t)*x(:,t)+ (u(:,t-1)')*R(:,:,t-1)*u(:,t-1);
       end
    end