function [A,B,K0] = LinearRandomSystemGenerator(n,m,poleScale)
    A = zeros(n,n);
    B = zeros(n,m);
    count = 1;
    while(rank(ctrb(A,B)) < n || count == 1)
        try
            count = 0;
            A = 10*rand(n,n);
            B = 10*rand(n,m);
            K0 = -place(A,B,rand(1,n)*poleScale);
        catch
            count = 1;
        end
    end
end