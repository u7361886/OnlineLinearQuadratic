function P = findPmax(Q,R,A,B)

epsilon = 10^(-2);
% T = 10^3;
P = 10^6*eye(size(Q));
Prev = zeros(size(Q));
while(norm(P-Prev) > epsilon)
    Prev = P;
    P = Q + A'*P*A-A'*P*B*inv(R+B'*P*B)*B'*P*A;
end
% 
% for t = 1:T
%     P = Q + A'*P*A-A'*P*B*inv(R+B'*P*B)*B'*P*A;
% end

