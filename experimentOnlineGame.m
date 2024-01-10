function [costAvgMeFix, costAvgNash, relativeAvg] = experimentOnlineGame(T,previewHorizon,numMonte,NPlayers)
%regAvgMeFix = experimentOnlineGame(T,previewHorizon,numMonte,NPlayers)
    %% regret output initialization
    costAvgMeFix = zeros(previewHorizon,T);
    costAvgNash = zeros(previewHorizon,T);
    relativeAvg = zeros(previewHorizon,T);
%     regAvgMeFix = zeros(previewHorizon,T);
    %% Dynamic game players
    n = 2;
    m = 1;
    strInd = 0;
    %% Experiments
   parfor numExp = 1:numMonte
%         tic;
        %% Dynamic Games
        tempRelativeNash = zeros(previewHorizon,T);
        tempRelativeMe = zeros(previewHorizon,T);
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
%         tempNash = zeros(previewHorizon,T);
        %% Online Control Result
        for t = previewHorizon:T
            for W = strInd:previewHorizon-1
                %% DG control
                tempAdd = zeros(previewHorizon,T);
                [x1,u1] = nashOL2(A,B,Q,R,t,x0,n,m,w,W,NPlayers,K0);
                
                tempAdd(W+1,t) = NECost(x1,u1,Q,R,t,NPlayers);
                costAvgMeFix = costAvgMeFix + tempAdd;
                tempRelativeMe = tempRelativeMe + tempAdd;
            end
            [xNash,uNash] = nashDGFB2(Q,R,A,B,w,t,x0,n,m,NPlayers);
            tempNash = zeros(previewHorizon,T);
            tempNash(:,t) = repmat(NECost(xNash,uNash,Q,R,t,NPlayers),previewHorizon,1);
            costAvgNash = costAvgNash + tempNash;
%             figure
% %             imagesc(costAvgNash)
%             plot(costAvgNash(1,previewHorizon:T))
%             disp('ok')
            tempRelativeNash = tempRelativeNash + tempNash;
        end
        tempRelative = abs((tempRelativeMe-tempRelativeNash)./tempRelativeNash);
        relativeAvg = relativeAvg + tempRelative;
%         toc;
    end
end