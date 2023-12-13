function out = NERegret2(x1,u1,xNash,uNash,Q,R,T,N)
%     J = zeros(N,N);
    J = zeros(N,1);
    JNash = zeros(N,1);
    for i = 1:N
        for tau = 1:T-1
            J(i) = J(i) + (x1(:,tau+1)'*Q(:,:,i,tau+1)*x1(:,tau+1))+u1(:,tau)'*R(:,:,i,tau)*u1(:,tau);
            JNash(i) = JNash(i) + (xNash(:,tau+1)'*Q(:,:,i,tau+1)*xNash(:,tau+1))+uNash(:,tau)'*R(:,:,i,tau)*uNash(:,tau);
        end
%         J(i) = J(i) + (x1(:,T)'*Q(:,:,i,T)*x1(:,T));
%         JNash(i) = JNash(i) + (xNash(:,T)'*Q(:,:,i,T)*xNash(:,T));
    end
%     out1 = JNash(1);
%     out2 = J(1);
    out = (J(1)-JNash(1))+(J(2)-JNash(2));
    out = out/2;
%     out = J(1)-JNash(1)
%     xx = zeros(length(barx1),N);
%     for i = 1:N
%         xx(:,i) = barx1;
%     end
%     for tau = 1:T-1
%         u2N = [uNash(1,tau);u1(2,tau)];
%         u1N = [u1(1,tau);uNash(2,tau)];
%         xx(:,1) = A*xx(:,1) + bigB*u1N;
%         xx(:,2) = A*xx(:,2) + bigB*u2N;
%         for i = 1:N
%             JNash(i) = JNash(i) + (xNash(:,tau+1)'*Q(:,:,i,tau+1)*xNash(:,tau+1))+uNash(:,tau)'*R(:,:,i,tau)*uNash(:,tau);
%         end
%         J(1) = J(1) + (xx(:,1)'*Q(:,:,1,tau+1)*xx(:,1))+(u1N)'*R(:,:,1,tau)*u1N;
%         J(2) = J(2) + (xx(:,2)'*Q(:,:,2,tau+1)*xx(:,2))+(u2N)'*R(:,:,2,tau)*u2N;
%     end
% 
% 
%     out = (J(1)-JNash(1))+(J(2)-JNash(2));
%     out = out/2;
%     out2 = J(1);
end