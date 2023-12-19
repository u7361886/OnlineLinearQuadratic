function [A,B,K0] = LinearRandomSystemGenerator(n,m,poleScale)
    A = zeros(n,n);
    B = zeros(n,m);
    count = 1;
    epsilon = 10^(-1);
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
        catch
            count = 1;
        end
    end

    
end