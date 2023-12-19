function [A,B,K0] = LinearRandomSystemGenerator(n,m,poleScale)
    A = zeros(n,n);
    B = zeros(n,m);
    count = 1;
    epsilon = 10^(-1);
<<<<<<< Updated upstream
    while(rank(ctrb(A,B)) < n || count == 1 || min(svd(ctrb(A,B))) < epsilon)
        try
            count = 0;
            A = rand(n,n);
            B = rand(n,m);
            if(mod(n, 2) ~= 0)
                K0 = -place(A,B,[generateComplexNumbers(2*floor(n/2)),rand(1)].*poleScale);
            else
                K0 = -place(A,B,generateComplexNumbers(2*floor(n/2)).*poleScale);
            end
%             disp(exception.message);
=======
    while(rank(ctrb(A,B)) < n || count == 1 || min(svd(ctrb(A,B))) > epsilon)
        try
            count = 0;
            A = 10*rand(n,n);
            B = 10*rand(n,m);
            if(mod(n, 2) ~= 0)
                K0 = -place(A,B,[generateComplexNumbers(floor(n/2)),rand(1)].*poleScale);
            else
                K0 = -place(A,B,generateComplexNumbers(floor(n/2)).*poleScale);
            end
>>>>>>> Stashed changes
        catch
            count = 1;
        end
    end

    
end