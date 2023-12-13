function K0 = DGTrackingController(lambda,a,b,Nplayers)
%         lambda = 0.8;
        tempK = rand(Nplayers-1,1);
        k1 = (a-lambda-sum(b(2:end).*tempK))/b(1);
        K0 = [[k1;tempK],zeros(Nplayers,1)];
end