function out = onedimRegret(x,u,xOptimal,uOptimal,Q,R,T)

    out = 0;    
    for t = 1:T
       if(t == 1)
            out = (x(:,t)')*Q(:,:,t)*x(:,t)-((xOptimal(:,t)')*Q(:,:,t)*xOptimal(:,t));
       else
            out = out + (x(:,t)')*Q(:,:,t)*x(:,t)+ (u(:,t-1)')*R(:,:,t-1)*u(:,t-1)-((xOptimal(:,t)')*Q(:,:,t)*xOptimal(:,t)+ (uOptimal(:,t-1)')*R(:,:,t-1)*uOptimal(:,t-1));
       end
    end

end