function [Q,R] = DGCostGenerator(qrangeLower,qrangeHigher,b,n,m,NPlayers,T)
    Q = zeros(n,n,NPlayers,T); 
    R = zeros(NPlayers*m,NPlayers*m,NPlayers,T);
    rtemp = 10;
    for t = 1:T
        r = zeros(NPlayers,1);
        r(1) = rtemp*rand(1);
        for i = 1:NPlayers
            if(i ~= 1)
                r(i) = b(i)^2/b(1)*r(1);
            end
            R(i,i,i,t) = r(i);
        end
        qt1 = qrangeLower + qrangeHigher*rand(1);
        qt2 = qrangeLower + qrangeHigher*rand(1);
        
        for i = 1:NPlayers
            Q(:,:,i,t) = [qt1,-qt2;qt2,0];
        end
    end

end