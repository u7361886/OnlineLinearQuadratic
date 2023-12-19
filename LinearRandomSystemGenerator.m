function [A,B,K0] = LinearRandomSystemGenerator(n,m,poleScale)
    A = zeros(n,n);
    B = zeros(n,m);
    count = 1;
    epsilon = 10^(-1);
    while(rank(ctrb(A,B)) < n || count == 1 || abs(min(svd(rank(ctrb(A,B))))) <= epsilon)
        try
            count = 0;
            A = rand(n,n);
            B = rand(n,m);
            K0 = -place(A,B,[generateComplexNumbers(floor(n/2)),rand(1)*poleScale]);
        catch
            count = 1;
        end
    end
end