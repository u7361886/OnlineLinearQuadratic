% close all
clear all
% clc
%% Time horizon, Preview horizon, system dimension, Number of player initialization
T = 80;
previewHorizon = 6;
%% regret output initialization
regAvgMeFix = zeros(previewHorizon,T);
%% Number of montecarlo
% numMonte = 16;
% numThreads = 7;
numThreads = str2double(getenv('NUMBER_OF_PROCESSORS'));
% maxNumCompThreads(numThreads);
% tempMonte = str2double(getenv('NUMBER_OF_PROCESSORS'));
numMonte = 5*numThreads;
strInd = 0;

%% Dynamic game players
NPlayers = 6;
n = 2;
m = 1;
%% Experiments

parfor numExp = 1:numMonte
    tic;
    %% Initialize experiments
    
    regWMeFix = zeros(previewHorizon,T);
    regWContFix = zeros(previewHorizon,1);
    %% Linear System onedim
    poleScale = 10^(-2);
        %% Random Systems
%         n = 5;
%         m = 2;
%         [A,B,K0] = LinearRandomSystemGenerator(n,m,poleScale);
        %% Inverted Pendulum Systems
%         [A,B,K0] = LinearInvertedPendulumGenerator(poleScale);
%         sysDim = size(B);
%         n = sysDim(1);
%         m = sysDim(2);
        %% Linear Control Costs
%     qrangeLower = 1;
%     qrangeHigher = 10;
%     rrangeLower = 1;
%     rrangeHigher = 10;
%     [Q,R] = LinearCostGenerator(qrangeLower,qrangeHigher,rrangeLower,rrangeHigher,n,m,T);
%     d = dfind(A,B);
%     w = 0*randn(n,T);
%     x0 = 10*rand(n,1);
    %% Dynamic Games
    a = 1.6;
    b = 10*rand(NPlayers,1);
    [A,B,bigB] = DGSystemsGenerator(a,b,n,m,NPlayers);
    qrangeLower = 1;
    qrangeHigher = 10;
    lambda = 0.8;
    [Q,R] = DGCostGenerator(qrangeLower,qrangeHigher,b,n,m,NPlayers,T);
    K0 = DGTrackingController(lambda,a,b,NPlayers);
    x0 = 10*rand(n,1);
    w = 0*randn(n,T);
    %% Online Control Result
%     strInd = 0;
    for W = strInd:previewHorizon-1
        for t = previewHorizon:T
            %% DG control
            [xNash,uNash] = nashDGFB2(Q,R,A,B,w,t,x0,n,m,NPlayers);
            [x1,u1] = nashOL2(A,B,Q,R,t,x0,n,m,w,W,NPlayers,K0);
            tempAdd = zeros(previewHorizon,T);
            tempAdd(W+1,t) = NERegret2(x1,u1,xNash,uNash,Q,R,t,NPlayers);
            regAvgMeFix = regAvgMeFix + tempAdd;
%             regWMeFix(W+1,t) = NERegret2(x1,u1,xNash,uNash,Q,R,t,NPlayers);
            %% Onedim Linear
%             [xNash,uNash] = onedimNash(Q,R,A,B,w,t,x0,n,m);
%             [x1,u1] = onedimTrackingOL(A,B,Q,R,T,x0,n,m,w,W,K0);
% %             [x1,u1] = onedimOL(A,B,Q,R,T,x0,n,m,w,W,d);
%             tempAdd = zeros(previewHorizon,T);
%             tempAdd(W+1,t) = onedimRegret(x1,u1,xNash,uNash,Q,R,t);
%             regAvgMeFix = regAvgMeFix + tempAdd;
        end
    end
    toc;
end




%% Plot output
% regAvgMeFix = regAvgMeFix/numMonte;
% figure
% imagesc(previewHorizon:T,strInd:previewHorizon-1,(10*log(abs(regAvgMeFix(:,previewHorizon:T)))))
% colorbar
% xlabel('time horizon')
% ylabel('preview length')
% set(gca,'YDir','normal')
% exportgraphics(gcf,'myfigure.pdf','ContentType','vector')
% % saveas(gcf,'myfigure.pdf')
% qq = regAvgMeFix(:,previewHorizon:T);
% sum((qq<0),'all')

% figure
% plot(abs(regAvgMeFix(5,previewHorizon:T)))
% xlabel('time horizon')
% ylabel('regret')
% title('Regret in Window Length 5')
% exportgraphics(gcf,'preview5alltime.pdf','ContentType','vector')
% 
% figure
% plot(abs(regAvgMeFix(2:end,11)))
% xlabel('preview horizon')
% ylabel('regret')
% title('Regret in time 11')
% exportgraphics(gcf,'time11allpreview.pdf','ContentType','vector')
