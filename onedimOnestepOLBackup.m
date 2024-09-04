function [x1,u1] = onedimOnestepOLBackup(A,B,Q,R,T,x0,n,m,w,W,d)
    x1 = zeros(n,T);
    u1 = zeros(m,T);
    x1(:,1) = x0;
    P = zeros(n,n,T);
    K = zeros(m,n,T-1);

    %deadbeat matrix
    DB = zeros(n,d*m);
    DA = zeros(n,d*n);
    DBi = B;
    for i = m*(d-1)+1:-m:1
        DB(1:n,i:(i+m-1)) = DBi;
        DBi = A*DBi;
    end
    tempDB = DB'*DB;

    DAi = eye(n);
    for i = n*(d-1)+1:-n:1
        DA(1:n,i:(i+n-1)) = DAi;
        DAi = A*DAi;
    end
%     DBG = inv()*DB';
%     size(DBG)
%     DB
    for t = 1:d:T-1
%         ind = (t+W+1)*((t+W+1) <= T) + T*(t+W+1>T);
%         if(ind == T)
%             P(:,:,T) = Q(:,:,T);
%         elseif(ind <= 0)
%             P(:,:,T) = Q(:,:,1);
%         else
%             P(:,:,T) = Q(:,:,ind);
%         end
        ind = (t+W)*(t+W <= T) + T*(t+W>T);
        if(ind == T)
            P(:,:,T) = Q(:,:,T);
        else
            P(:,:,T) = Q(:,:,ind);
        end
    
        for i = T-1:-1:1
%             if(i > ind-1)
%                 tempR = R(:,:,ind-1);   %R in index i with given information at t
%                 tempQ = Q(:,:,ind);
%             elseif(i <= ind-1)
%                 tempR = R(:,:,i);
%                 tempQ = Q(:,:,i+1);
%             end
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
        %find expected trajectory
%         Kcat = zeros(n,d*n);
%         Kcati = eye(n,n);
%         j = min(t+d-1,T-1);
%         mul = eye(n,n);
%         for i = n*(d-1)+1:-n:1
%             Kcat(1:n,i:(i+n-1)) = Kcati;
%             if(min(t+d-1,T-1) == T-1)
%                 if((i-1)/n <= T-t-1)
%                     mul = A+B*K(:,:,j);
%                     j = j-1;
%                 end
%             else
%                 mul = A+B*K(:,:,j);
%                 j = j-1;
%             end
%             Kcati = Kcati*mul;
%         end
% %         xexpect = x0;
% %         for tau = 1:t
% %             if(tau == t)
% %                 xexpect = (A+B*K(:,:,tau))*xexpect;
% %             else
% %                 xexpect = (A+B*K(:,:,tau))*xexpect + w(:,tau);
% %             end
% %         end
%         for p = 0:min(d-1,T-t-1)
%             xexpect = x0;
%             for tau = 1:min(t+d,T-t)
%                 if(tau < t)
%                     xexpect = A*xexpect + B*K(:,:,tau)*xexpect + w(:,tau);
%                 else
%                     xexpect = A*xexpect + B*K(:,:,tau)*xexpect;
%                 end
%             end
%             %track computation
%             wcat = reshape([w(:,t:t+p-1),zeros(n,d-p)],[n*d,1]);
% %             traj = Kcati*xexpect + Kcat*wcat;
% %             if(T-t-1 == min(d-1,T-t-1))
% %                 traj = 0;
% %             else
% %                 traj = Kcati*xexpect + Kcat*wcat;
% %             end
%             uDB = DB(:,1+p*m:end);
%             tempDB = uDB'*uDB;
% %             track = tempDB\(DB'*(traj - A^(d)*x1(:,t) - DA*wcat));
%             track = tempDB\(uDB'*(xexpect-A^(min(d,T-t)-p)*x1(:,t+p)-A^(min(d,T-t)-p-1)*w(:,t+p)));
%             u1(:,t+p) = track(1:m);
%             x1(:,t+p+1) = A*x1(:,t+p) + B*u1(:,t+p) + w(:,t+p);
%         end

% 
        xexpect = x0;
        for tau = 1:min(t+d-1,T-1)
            if(tau >= t)
                xexpect = (A + B*K(:,:,tau))*xexpect;
            else
                xexpect = (A + B*K(:,:,tau))*xexpect+ w(:,tau);
            end
        end
        
%         if(t+d < T)
%             cont = tempDB\(DB'*(xexpect-A^(d)*x1(:,t)));
%         else
%             cont = tempDB\(DB'*(-A^(d)*x1(:,t)));
%         end
%         u1(:,t) = cont(1:m);
%         x1(:,t+1) = A*x1(:,t) + B*u1(:,t) + w(:,t);
        dBGain = inv(DB'*DB)*(DB')*(xexpect-A^(d)*x1(:,t));
        for n = 0:min(d-1,T-t-1)
%             xexpect = x0;
%             for tau = 1:min(t+d-1,T-1)
%                 if(tau <= t+n)
%                     xexpect = (A + B*K(:,:,tau))*xexpect + w(:,tau);
%                 else
%                     xexpect = (A + B*K(:,:,tau))*xexpect;
%                 end
%             end
        
%             u1(:,t+n) = K(:,:,t+n)*x1(:,t+n);
            u1(:,t+n) = dBGain(1+n:n+m);
            x1(:,t+n+1) = A*x1(:,t+n) + B*u1(:,t+n) + w(:,t+n);
        end
    end
end
