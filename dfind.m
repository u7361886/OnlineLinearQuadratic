function out = dfind(A,B)
    contrlMatrix = [];
    k = 0;
    sysDim = size(B);
    n = sysDim(1);
    while(rank(contrlMatrix) < n)
        contrlMatrix = [contrlMatrix,(A^k)*B];
        k = k+1;
    end
    out = k;
end