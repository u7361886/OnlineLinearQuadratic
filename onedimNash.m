function [xOptimal,uOptimal] = onedimNash(Q,R,A,B,w,T,x0,n,m)

    xOptimal = zeros(n,T);
    uOptimal = zeros(m,T);
    POptimal = zeros(n,n,T);
    POptimal(:,:,T) = Q(:,:,T);
    KOptimal = zeros(m,n,T-1);
    xOptimal(:,1) = x0;
    
    for t = T-1:-1:1
        KOptimal(:,:,t) = -inv(R(:,:,t)+(B')*POptimal(:,:,t+1)*B)*(B')*POptimal(:,:,t+1)*A;
        POptimal(:,:,t) = (A')*POptimal(:,:,t+1)*A+Q(:,:,t)+(A')*POptimal(:,:,t+1)*B*KOptimal(:,:,t);
    end
    for t = 1:T-1
%        uOptimal(:,t) = KOptimal(:,:,t)*xOptimal(:,t) - inv(R(:,:,t)+(B')*POptimal(:,:,t+1)*B)*(B')*POptimal(:,:,t+1)*w(:,t);
        uOptimal(:,t) = KOptimal(:,:,t)*xOptimal(:,t);
        xOptimal(:,t+1) = A*xOptimal(:,t)+B*uOptimal(:,t)+w(:,t);
    end
end