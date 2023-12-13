function [xNash,uNash] = nashDGFB2(Q,R,A,B,w,t,x0,n,m,N)

    xNash = zeros(n,t);
    uNash = zeros(N*m,t);
    xNash(:,1) = x0;
    P = zeros(n,n,N,t);
    K = zeros(N*m,n,t-1);
    bigB = reshape(B,[2,N]);
    Theta = zeros(N*m,N*m);
    tallM = zeros(N*m,n);
%     Rbar = zeros(N*m,N*m,t);
    %% initialize P
    for i = 1:N
        P(:,:,i,t) = Q(:,:,i,t);
    end
    %% Riccati calculation
    for tau = t-1:-1:1
        for i = 1:N
            for j = 1:N
%                 (B(:,:,i))'*P(:,:,i,tau+1)*B(:,:,j)
%                 R((i-1)*m+1:i*m,(j-1)*m+1:j*m,i,tau)
                Theta((i-1)*m+1:i*m,(j-1)*m+1:j*m) = R((i-1)*m+1:i*m,(j-1)*m+1:j*m,i,tau) + (B(:,:,i))'*P(:,:,i,tau+1)*B(:,:,j);
            end
        end
%         Theta = [R(1:m,1:m,1,tau) + (B(:,:,1))'*P(:,:,1,tau+1)*B(:,:,1), ...
%             R(1:m,m+1:2*m,1,tau) + (B(:,:,1))'*P(:,:,1,tau+1)*B(:,:,2);...
%             R(m+1:2*m,1:m,2,tau) + (B(:,:,2))'*P(:,:,2,tau+1)*B(:,:,1),...
%             R(m+1:2*m,m+1:2*m,2,tau) + (B(:,:,2))'*P(:,:,2,tau+1)*B(:,:,2)];
%         size(Theta)
        if(hasNegativeValue(eig(Theta))==1)
            eig(Theta)
%             'stop'
%             print('stop');
%             return
        end
        
        for i = 1:N
            tallM(m*(i-1)+1:i*m,1:n) = (B(:,:,i))'*P(:,:,i,tau+1);
        end
%         eig(inv(Theta))
        K(:,:,tau) = -inv(Theta)*tallM*A;
%         K(:,:,tau) = -inv(Theta)*[(B(:,:,1))'*P(:,:,1,tau+1);(B(:,:,2))'*P(:,:,2,tau+1)]*A;
        for i = 1:N
            P(:,:,i,tau) = Q(:,:,i,tau) + K(:,:,tau)'*R(:,:,i,tau)*K(:,:,tau) + (A+bigB*K(:,:,tau))'*P(:,:,i,tau+1)*(A+bigB*K(:,:,tau));
%                 if(i == 1)
%                     Rbar(i,:,tau) = R(i,:,i,tau);
%                 else
%                     Rbar(i,:,tau) = -R(i,:,i,tau);
%                 end
        end  
%         choose = 2;
%         Rbar(1,1,tau) = R(1,1,1,tau);
%         Rbar(choose,choose,tau) = -R(choose,choose,choose,tau);
%         bigB'*(P(:,:,1,tau)-P(:,:,2,tau))*A
%         K(:,:,tau)'*(Rbar(:,:,tau))*K(:,:,tau)
%         K(:,:,tau)'*(R(:,:,1,tau)-R(:,:,2,tau))*K(:,:,tau)
%         tallM'*inv(Theta)*(Rbar(:,:,tau))*inv(Theta)*tallM
%         inv(Theta)*(Rbar(:,:,tau))*inv(Theta)
%         99
%         bigB*inv(Theta)*(Rbar(:,:,tau))*inv(Theta)*bigB'
%         99
% %         inv(Theta)*(R(:,:,1,tau)-R(:,:,2,tau))*inv(Theta)
%         99
%         eig(P(:,:,1,tau))
%         eig(P(:,:,2,tau))
%         eig(bigB'*(P(:,:,1,tau)-P(:,:,2,tau))*A)
%         disp('ok');
    end
    
    for tau = 1:t-1
        uNash(:,tau) = K(:,:,tau)*xNash(:,tau);
%         eig(A+bigB*K(:,:,tau))
        xNash(:,tau+1) = A*xNash(:,tau)+ bigB*uNash(:,tau) + w(:,tau);
    end
end

function result = hasNegativeValue(input_vector)
    % Check if any element is negative
    if any(input_vector <= 0)
        result = 1;
    else
        result = 0;
    end
end


function is_positive_definite = isPositiveDefinite(P)
    % Check if the matrix is square
    [m, n] = size(P);
    if m ~= n
        error('Input matrix must be square.');
    end
    
    % Check if the matrix is symmetric
    if ~isequal(P, P')
        is_positive_definite = false;
        return;
    end
    
    % Perform Cholesky decomposition
    try
        L = chol(P);
        is_positive_definite = true;
    catch
        is_positive_definite = false;
    end
end
