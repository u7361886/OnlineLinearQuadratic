function  [A,B,bigB] = DGSystemsGenerator(a,b,n,m,NPlayers)
    A = [a,0;0,0.9];
    B = zeros(n,m,NPlayers);
    for i = 1:NPlayers
        B(:,:,i) = [-b(i);0];
    end
    bigB = reshape(B,[2,NPlayers]);
end