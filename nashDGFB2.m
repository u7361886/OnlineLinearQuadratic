function [xNash,uNash] = nashDGFB2(Q,R,A,B,w,t,x0,n,m,N)

    xNash = zeros(n,t);
    uNash = zeros(N*m,t);
    xNash(:,1) = x0;
    P = zeros(n,n,N,t);
    K = zeros(N*m,n,t-1);
    bigB = reshape(B,[2,N]);
    Theta = zeros(N*m,N*m);
    tallM = zeros(N*m,n);
    %% initialize P
    for i = 1:N
        P(:,:,i,t) = Q(:,:,i,t);
    end
    %% Riccati calculation
    for tau = t-1:-1:1
        for i = 1:N
            for j = 1:N
                Theta((i-1)*m+1:i*m,(j-1)*m+1:j*m) = R((i-1)*m+1:i*m,(j-1)*m+1:j*m,i,tau) + (B(:,:,i))'*P(:,:,i,tau+1)*B(:,:,j);
            end
        end
        if(hasNegativeValue(eig(Theta))==1)
            eig(Theta)
        end
        
        for i = 1:N
            tallM(m*(i-1)+1:i*m,1:n) = (B(:,:,i))'*P(:,:,i,tau+1);
        end
        K(:,:,tau) = -inv(Theta)*tallM*A;
        for i = 1:N
            P(:,:,i,tau) = Q(:,:,i,tau) + K(:,:,tau)'*R(:,:,i,tau)*K(:,:,tau) + (A+bigB*K(:,:,tau))'*P(:,:,i,tau+1)*(A+bigB*K(:,:,tau));
        end  
    end
    
    for tau = 1:t-1
        uNash(:,tau) = K(:,:,tau)*xNash(:,tau);
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
