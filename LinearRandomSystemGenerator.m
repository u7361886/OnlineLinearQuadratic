function [A,B,K0] = LinearRandomSystemGenerator(n,m,poleScale)
    A = zeros(n,n);
    B = zeros(n,m);
    count = 1;
    epsilon = 10^(-3);
    while(rank(ctrb(A,B)) < n || count == 1 || min(svd(ctrb(A,B))) <= epsilon)
        try
            count = 0;
            A = 10*rand(n,n);
            B = 10*rand(n,m);
%             K0 = -place(A,B,rand(1,n)*poleScale);
            if(mod(n, 2) ~= 0)
                K0 = -place(A,B,[generateComplexNumbers(2*floor(n/2)),0.95].*poleScale);
            else
                K0 = -place(A,B,generateComplexNumbers(n).*poleScale);
            end
        catch
            count = 1;
        end
    end
end