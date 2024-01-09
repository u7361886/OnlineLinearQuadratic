function [costAvgMeFix, costAvgNash] = experimentOnlineGame(T,previewHorizon,numMonte,NPlayers)
%regAvgMeFix = experimentOnlineGame(T,previewHorizon,numMonte,NPlayers)
    %% regret output initialization
    costAvgMeFix = zeros(previewHorizon,T);
    costAvgNash = zeros(previewHorizon,T);
%     regAvgMeFix = zeros(previewHorizon,T);
    %% Dynamic game players
    n = 2;
    m = 1;
    strInd = 0;
    %% Experiments
    parfor numExp = 1:numMonte
%         tic;
        %% Dynamic Games
        a = 1.6;
        b = 10*rand(NPlayers,1);
        [A,B,~] = DGSystemsGenerator(a,b,n,m,NPlayers);
        qrangeLower = 1;
        qrangeHigher = 10;
        lambda = 0.8;
        [Q,R] = DGCostGenerator(qrangeLower,qrangeHigher,b,n,m,NPlayers,T);
        K0 = DGTrackingController(lambda,a,b,NPlayers);
        x0 = 10*rand(n,1);
        w = 0*randn(n,T);
        %% Online Control Result
        for W = strInd:previewHorizon-1
            for t = previewHorizon:T
                %% DG control
                tempAdd = zeros(previewHorizon,T);
                [xNash,uNash] = nashDGFB2(Q,R,A,B,w,t,x0,n,m,NPlayers);
                [x1,u1] = nashOL2(A,B,Q,R,t,x0,n,m,w,W,NPlayers,K0);
                
                tempAdd(W+1,t) = NECost(x1,u1,Q,R,t,NPlayers);
                costAvgMeFix = costAvgMeFix + tempAdd;

                tempAdd(W+1,t) = NECost(xNash,uNash,Q,R,t,NPlayers);
                costAvgNash = costAvgNash + tempAdd;
            end
        end
%         toc;
    end
end