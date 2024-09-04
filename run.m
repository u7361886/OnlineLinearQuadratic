clear all
close all
% clc
%% initialize experiment
T = 40;
previewHorizon = 10;
numThreads = 10;
% numThreads = str2double(getenv('NUMBER_OF_PROCESSORS'));
% maxNumCompThreads(numThreads);
% tempMonte = str2double(getenv('NUMBER_OF_PROCESSORS'));
numMonte = 10*numThreads;
wMag = 0;
n = 5;
m = 2;
%% pendulum system
tic
%[regAvgMeFixTrackingPendulum,regAvgMeFixOnestepPendulum,regAvgLiPendulum,regAvgJingtaoPendulum] = experimentOnlineLinear(T,previewHorizon,numMonte,"pendulum",wMag);
[costTrackingPendulum,costLinaTrackingPendulum,costJingtaoPendulum,costNashTrackingPendulum] = experimentOnlineLinear(T,previewHorizon,numMonte,"pendulum",wMag,n,m);

regTrackingPendulum = costTrackingPendulum-costNashTrackingPendulum;
regLiPendulum = costLinaTrackingPendulum-costNashTrackingPendulum;
regJingtaoPendulum = costJingtaoPendulum-costNashTrackingPendulum;

save('.\regrets\regTrackingPendulum.mat','regTrackingPendulum')
save('.\regrets\regLiPendulum.mat','regLiPendulum')
save('.\regrets\regJingtaoPendulum.mat','regJingtaoPendulum')
toc
figure
plot(costJingtaoPendulum(5,:))
hold on
plot(costLinaTrackingPendulum(5,:))
hold on
plot(costTrackingPendulum(5,:))
% 
% ind = 20;
% 
% figure
% plot(costJingtaoPendulum(:,ind))
% hold on
% plot(costLinaTrackingPendulum(:,ind))
% hold on
% plot(costTrackingPendulum(:,ind))

% save('.\regrets\costAvgMeFixTrackingPendulum.mat','costAvgMeFixTrackingPendulum')
% % save('.\regrets\costAvgMeFixOnestepPendulum.mat','costAvgMeFixOnestepPendulum')
% save('.\regrets\costAvgLiPendulum.mat','costAvgLiPendulum')
% save('.\regrets\costAvgJingPendulum.mat','costAvgJingPendulum')
% save('.\regrets\costAvgNashPendulum.mat','costAvgNashPendulum')

% save('.\regrets\regAvgMeFixTrackingPendulum.mat','regAvgMeFixTrackingPendulum')
% save('.\regrets\regAvgMeFixOnestepPendulum.mat','regAvgMeFixOnestepPendulum')
% save('.\regrets\regAvgLiPendulum.mat','regAvgLiPendulum')

%% random system
wMag = 0;
tic
n = 4;
m = 1;
[costTrackingRandom,costLiRandom,costJingtaoRandom,costNashRandom] = experimentOnlineLinear(T,previewHorizon,numMonte,"random",wMag,n,m);

regTrackingRandom = costTrackingRandom-costNashRandom;
regLiRandom = costLiRandom-costNashRandom;
regJingtaoRandom = costJingtaoRandom-costNashRandom;

save('.\regrets\regTrackingRandom.mat','regTrackingRandom')
save('.\regrets\regLiRandom.mat','regLiRandom')
save('.\regrets\regJingtaoRandom.mat','regJingtaoRandom')
toc

% ind = 2;
% figure
% plot(costJingtaoRandom(ind,:))
% hold on
% plot(costLiRandom(ind,:))
% hold on
% plot(costTrackingRandom(ind,:))
% % 
% ind = 20;
% 
% figure
% plot(costJingtaoRandom(:,ind))
% hold on
% plot(costLiRandom(:,ind))
% hold on
% plot(costTrackingRandom(:,ind))

% ind = 6;
% figure
% plot(costTrackingPendulum(ind,:))
% hold on
% plot(costJingtaoPendulum(ind,:))
% hold on
% plot(costLinaTrackingPendulum(ind,:))
% sum((costLinaTrackingPendulum-costJingtaoPendulum)>=0,"all")/(size(regJingtaoPendulum,1)*size(regJingtaoPendulum,2))
%% disturbance 
wMag = 1;
tic
[costTrackingPendulumDisturbance,costLiPendulumDisturbance,costJingtaoPendulumDisturbance,costNashPendulumDisturbance] = experimentOnlineLinear(T,previewHorizon,numMonte,"pendulum",wMag);

regTrackingPendulumDisturbance = costTrackingPendulumDisturbance-costNashPendulumDisturbance;
regLiPendulumDisturbance = costLiPendulumDisturbance-costNashPendulumDisturbance;
regJingtaoPendulumDisturbance = costJingtaoPendulumDisturbance-costNashPendulumDisturbance;

figure
plot(costJingtaoPendulumDisturbance(5,:))
hold on
plot(costLiPendulumDisturbance(5,:))
hold on
plot(costTrackingPendulumDisturbance(5,:))

save('.\regrets\regTrackingPendulumDisturbance.mat','regTrackingPendulumDisturbance')
save('.\regrets\regLiPendulumDisturbance.mat','regLiPendulumDisturbance')
save('.\regrets\regJingtaoPendulumDisturbance.mat','regJingtaoPendulumDisturbance')
toc
%%
wMag = 1;
tic
n = 5;
m = 2;
[costTrackingRandomDisturbance,costLiRandomDisturbance,costJingtaoRandomDisturbance,costNashRandomDisturbance] = experimentOnlineLinear(T,previewHorizon,numMonte,"random",wMag,n,m);

regTrackingRandomDisturbance = costTrackingRandomDisturbance-costNashRandomDisturbance;
regLiRandomDisturbance = costLiRandomDisturbance-costNashRandomDisturbance;
regJingtaoRandomDisturbance = costJingtaoRandomDisturbance-costNashRandomDisturbance;

save('.\regrets\regTrackingRandomDisturbance.mat','regTrackingRandomDisturbance')
save('.\regrets\regLiRandomDisturbance.mat','regLiRandomDisturbance')
save('.\regrets\regJingtaoRandomDisturbance.mat','regJingtaoRandomDisturbance')
toc
%%
figure
imagesc(10:40,1:10,costJingtaoRandomDisturbance)
colorbar
%% 
ind = 6;
figure
plot(costJingtaoRandomDisturbance(ind,:));
hold on
plot(costTrackingRandomDisturbance(ind,:));
hold on
plot(costLiRandomDisturbance(ind,:))
hold on
plot(costNashRandomDisturbance(ind,:))
tind = 30;
figure
plot(costJingtaoRandomDisturbance(:,tind))
hold on
plot(costTrackingRandomDisturbance(:,tind));
hold on
plot(costLiRandomDisturbance(:,tind))
%%
ind = 8;
figure
plot(costJingtaoPendulumDisturbance(ind,:));
% hold on
% plot(costTrackingPendulumDisturbance(ind,:));
hold on
plot(costLiPendulumDisturbance(ind,:));
% hold on
% plot(costNashRandomDisturbance(ind,:));

tind = 30;
figure
plot(costJingtaoPendulumDisturbance(:,tind))
hold on
plot(costLiPendulumDisturbance(:,tind));


%% dynamic game
tic
Nplayers = 4;
T = 40;
previewHorizon = 6;
[costAvgMeFixPlayers2, costAvgNashPlayers2, relativeAvgPlayers2] = experimentOnlineGame(T,previewHorizon,numMonte,Nplayers);

reg = costAvgMeFixPlayers2-costAvgNashPlayers2;
relReg = relativeAvgPlayers2;

labelFont = 20;
numberFont = 17;

figure
plot(log(abs(relReg(1,previewHorizon:end))),'LineWidth',4)
set(gca, 'FontName', 'Arial', 'FontSize', numberFont);
xlabel('Time Horizon','FontSize',labelFont)
ylabel('log|RelRegret|','FontSize',labelFont)
exportgraphics(gcf,".\plots\relRegretwindow1.pdf",'ContentType','vector','Resolution',600)

figure
plot(log(abs(relReg(2,previewHorizon:end))),'LineWidth',4)
set(gca, 'FontName', 'Arial', 'FontSize', numberFont);
xlabel('Time Horizon','FontSize',labelFont)
ylabel('log|RelRegret|','FontSize',labelFont)
exportgraphics(gcf,".\plots\relRegretwindow2.pdf",'ContentType','vector','Resolution',600)
%'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'),

figure
plot(log(abs(relReg(:,20))),'LineWidth',4)
set(gca, 'FontName', 'Arial', 'FontSize', numberFont);
xlabel('Preview Horizon','FontSize',labelFont)
ylabel('log|RelRegret|','FontSize',labelFont)
exportgraphics(gcf,".\plots\relRegrettime20.pdf",'ContentType','vector','Resolution',600)

figure
plot(log(abs(relReg(:,35))),'LineWidth',4)
set(gca, 'FontName', 'Arial', 'FontSize', numberFont);
xlabel('Preview Horizon','FontSize',labelFont)
ylabel('log|RelRegret|','FontSize',labelFont)
exportgraphics(gcf,".\plots\relRegrettime35.pdf",'ContentType','vector','Resolution',600)


figure
plot(log(abs(reg(1,previewHorizon:end))),'LineWidth',4)
set(gca, 'FontName', 'Arial', 'FontSize', numberFont);
xlabel('Time Horizon','FontSize',labelFont)
ylabel('log|Regret|','FontSize',labelFont)
exportgraphics(gcf,".\plots\Regretwindow1.pdf",'ContentType','vector','Resolution',600)

figure
plot(log(abs(reg(2,previewHorizon:end))),'LineWidth',4)
set(gca, 'FontName', 'Arial', 'FontSize', numberFont);
xlabel('Time Horizon','FontSize',labelFont)
ylabel('log|Regret|','FontSize',labelFont)
exportgraphics(gcf,".\plots\Regretwindow2.pdf",'ContentType','vector','Resolution',600)

figure
plot(log(abs(reg(:,20))),'LineWidth',4)
set(gca, 'FontName', 'Arial', 'FontSize', numberFont);
xlabel('Preview Horizon','FontSize',labelFont)
ylabel('log|Regret|','FontSize',labelFont)
exportgraphics(gcf,".\plots\Regrettime20.pdf",'ContentType','vector','Resolution',600)

figure
plot(log(abs(reg(:,35))),'LineWidth',4)
set(gca, 'FontName', 'Arial', 'FontSize', numberFont);
xlabel('Preview Horizon','FontSize',labelFont)
ylabel('log|Regret|','FontSize',labelFont)
exportgraphics(gcf,".\plots\Regrettime35.pdf",'ContentType','vector','Resolution',600)

% figure
% plot(max(d,previewHorizon):T,log(regAvg(window1,max(d,previewHorizon):T)), 'LineWidth',4)
% set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', ylabelFontSize);
% set(gcf,'Position',[100,100,size1,size2])
% %     curtick = get(gca, 'xTick');
% %     xticks(unique(round(curtick)));
% xlabel('Time Horizon','FontSize',xfontsize)
% ylabel('log|Regret|','FontSize',yfontsize)


figure
surf(log(abs(costAvgMeFixPlayers2-costAvgNashPlayers2)))
hold on
surf(costAvgNashPlayers2)

save('.\regrets\costAvgMeFixPlayers2.mat','costAvgMeFixPlayers2')
save('.\regrets\costAvgNashPlayers2.mat','costAvgNashPlayers2')
save('.\regrets\relativeAvgPlayers2.mat','relativeAvgPlayers2')
% regAvgMeFixGame = experimentOnlineGame(T,previewHorizon,numMonte,Nplayers);
% save('.\regrets\regAvgMeFixGame.mat','regAvgMeFixGame')
toc



% 
load(".\regrets\costAvgMeFixPlayers6.mat")
load(".\regrets\costAvgMeFixPlayers2.mat")
load(".\regrets\costAvgNashPlayers6.mat")
load(".\regrets\costAvgNashPlayers2.mat")
% 
figure
surf(costAvgMeFixPlayers6)
hold on
surf(costAvgNashPlayers6)
% 
% player2=relativeAvgPlayers2/numMonte;
% figure
% imagesc(abs(player2))
% colorbar
% % player6=(costAvgMeFixPlayers6-costAvgNashPlayers6)./costAvgNashPlayers6;
% figure
% plot(abs(player2(:,15)))
% 
% timeSlice = 15;
% figure
% plot(costAvgMeFixPlayers2(:,timeSlice))
% hold on
% plot(costAvgNashPlayers2(:,timeSlice))
% 
qplayer2 = ((costAvgMeFixPlayers2-costAvgNashPlayers2)./costAvgNashPlayers2);
figure
imagesc(qplayer2)
colorbar
sum(qplayer2 < 1,'all')/(size(qplayer2,1)*size(qplayer2,2))

% 
% 
% figure
% imagesc(player6)
% colorbar
% 
% figure
% plot(player6(:,7))
tic
Nplayers = 3;
T = 40;
previewHorizon = 10;
[costAvgMeFixPlayers3, costAvgNashPlayers3, relativeAvgPlayers3] = experimentOnlineGame(T,previewHorizon,numMonte,Nplayers);
save('.\regrets\costAvgMeFixPlayers3.mat','costAvgMeFixPlayers3')
save('.\regrets\costAvgNashPlayers3.mat','costAvgNashPlayers3')
save('.\regrets\relativeAvgPlayers3.mat','relativeAvgPlayers3')
toc


load('.\regrets\relativeAvgPlayers3.mat')

% player3 = costAvgMeFixPlayers3-costAvgNashPlayers3;
% player3Rel = player3./costAvgNashPlayers3;
% figure
% imagesc(player3Rel)
% colorbar
% figure
% plot(player3Rel(5,5:T))
% figure
% plot(player3Rel(:,35))

tic
Nplayers = 4;
T = 40;
previewHorizon = 6;
[costAvgMeFixPlayers4, costAvgNashPlayers4, relativeAvgPlayers4] = experimentOnlineGame(T,previewHorizon,numMonte,Nplayers);
save('.\regrets\costAvgMeFixPlayers4.mat','costAvgMeFixPlayers4')
save('.\regrets\costAvgNashPlayers4.mat','costAvgNashPlayers4')
save('.\regrets\relativeAvgPlayers4.mat','relativeAvgPlayers4')
toc


tic
Nplayers = 6;
T = 40;
previewHorizon = 6;
[costAvgMeFixPlayers6, costAvgNashPlayers6, relativeAvgPlayers6] = experimentOnlineGame(T,previewHorizon,numMonte,Nplayers);
save('.\regrets\costAvgMeFixPlayers6.mat','costAvgMeFixPlayers6')
save('.\regrets\costAvgNashPlayers6.mat','costAvgNashPlayers6')
save('.\regrets\relativeAvgPlayers6.mat','relativeAvgPlayers6')
toc

player2 = costAvgMeFixPlayers2-costAvgNashPlayers2;
player6 = costAvgMeFixPlayers6-costAvgNashPlayers6;

player2Rel = player2./costAvgNashPlayers2;
player6Rel = player6./costAvgNashPlayers6;
% 
% figure
% imagesc(costAvgMeFixPlayers2)
% colorbar
% 
% figure
% imagesc(costAvgMeFixPlayers6)
% colorbar
% 
% figure
% imagesc(costAvgNashPlayers2)
% colorbar
% 
% figure
% imagesc(costAvgNashPlayers6)
% colorbar
% 
% figure
% plot(costAvgMeFixPlayers2(3,5:T))
% 
figure
imagesc(player2Rel)
colorbar
figure
plot(player2Rel(1,5:T))
figure
plot(player2Rel(:,35))

figure
imagesc(relativeAvgPlayers3)
colorbar

figure
plot(relativeAvgPlayers3(9,5:T))
figure
plot(log(relativeAvgPlayers3(:,30)))

% 
figure
imagesc(player6Rel)
colorbar
figure
plot(player6Rel(6,5:T))

figure
plot(player6Rel(:,36))
sum((player6Rel<1),"all")./(T*previewHorizon)

% 
% figure
% imagesc(costAvgMeFixPlayers6)
% 
% figure
% plot(player2(1,5:T))

% figure
% imagesc(relativeAvgPlayers2)
% colorbar
% figure
% imagesc(relativeAvgPlayers6)
% colorbar
% 
% figure
% relative2 = ((costAvgMeFixPlayers2-costAvgNashPlayers2)./costAvgNashPlayers2);
% imagesc(relative2)
% colorbar
% figure
% plot(relative2(:, 15))
% 
% figure
% plot(relative2(5,5:T))
% 
% relative6 = ((costAvgMeFixPlayers6-costAvgNashPlayers6)./costAvgNashPlayers6);
% figure
% imagesc(relative6)
% colorbar
% figure
% plot(relative6(:, 15))
% 
% figure
% plot(relative6(2,5:T))
% %% load files
% load(".\regrets\regAvgLiPendulum.mat")
% load(".\regrets\regAvgMeFixTrackingRandom.mat")
% load(".\regrets\regAvgMeFixOnestepRandom.mat")
% 
% load(".\regrets\regAvgLiRandom.mat")
% load(".\regrets\regAvgMeFixTrackingPendulum.mat")
% load(".\regrets\regAvgMeFixOnestepPendulum.mat")
% 
% load(".\regrets\regAvgMeFixTrackingPendulumDisturbance.mat")
% load(".\regrets\regAvgMeFixOnestepPendulumDisturbance.mat")
% load(".\regrets\regAvgLiPendulumDisturbance.mat")
% 
% load(".\regrets\regAvgMeFixTrackingRandomDisturbance.mat")
% load(".\regrets\regAvgMeFixOnestepRandomDisturbance.mat")
% load(".\regrets\regAvgLiRandomDisturbance.mat")
%% performance comparisons
disp('Pendulum Comparison')
showComparisons(regLiPendulum, regTrackingPendulum,regJingtaoPendulum);
disp('Random Comparison');
showComparisons(regLiRandom, regTrackingRandom,regJingtaoRandom);
disp('Pendulum Comparison Disturbance')
showComparisons(regLiPendulumDisturbance, regTrackingPendulumDisturbance, regJingtaoPendulumDisturbance);
disp('Random Comparison Disturbance')
showComparisons(regLiRandomDisturbance, regTrackingRandomDisturbance,regJingtaoRandomDisturbance);

%% Data Processing

% load(".\regrets\regAvgMeFixTrackingPendulum.mat")
% load(".\regrets\regAvgLiPendulum.mat")
% load(".\regrets\regAvgMeFixOnestepPendulum.mat")
% 
% load(".\regrets\regAvgMeFixTrackingRandom.mat")
% load(".\regrets\regAvgMeFixOnestepRandom.mat")
% load(".\regrets\regAvgLiRandom.mat")

% 
% %linear no disturbance
% DGDataProcessing(regAvgMeFixTrackingPendulum, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepPendulum, T, previewHorizon,numMonte,4)
% DGDataProcessing(regAvgMeFixTrackingRandom, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepRandom, T, previewHorizon,numMonte,ceil(n/m))
% DGDataProcessing(regAvgLiRandom, T, previewHorizon,numMonte)
% % % 
% % % % %comparison with Li no disturbance
% penLiTrackingComp = regAvgLiPendulum-regAvgMeFixTrackingPendulum;
% penLiFixComp = regAvgLiPendulum-regAvgMeFixOnestepPendulum;
% ranLiTrackingComp = regAvgLiRandom-regAvgMeFixTrackingRandom;
% ranLiFixComp = regAvgLiRandom-regAvgMeFixOnestepRandom;
% 
% DGDataProcessing(penLiFixComp, T, previewHorizon,numMonte)
% DGDataProcessing(penLiTrackingComp, T, previewHorizon,numMonte,4)
% DGDataProcessing(ranLiTrackingComp, T, previewHorizon,numMonte)
% DGDataProcessing(ranLiFixComp, T, previewHorizon,numMonte,ceil(n/m))
% % 
% % % 
% % % % %linear with disturbance
% DGDataProcessing(regAvgMeFixTrackingPendulumDisturbance, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepPendulumDisturbance, T, previewHorizon,numMonte,4)
% DGDataProcessing(regAvgMeFixTrackingRandomDisturbance, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepRandomDisturbance, T, previewHorizon,numMonte,ceil(n/m))
% DGDataProcessing(regAvgLiRandom, T, previewHorizon,numMonte,ceil(n/m))
% % % 
% % % %comparison with li disturbance regAvgLiPendulumDisturbance
% DGDataProcessing(regAvgLiPendulumDisturbance-regAvgMeFixTrackingPendulumDisturbance, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgLiPendulumDisturbance-regAvgMeFixOnestepPendulumDisturbance, T, previewHorizon,numMonte,4)
% DGDataProcessing(regAvgLiRandomDisturbance-regAvgMeFixTrackingRandomDisturbance, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgLiRandomDisturbance-regAvgMeFixOnestepRandomDisturbance, T, previewHorizon,numMonte,ceil(n/m))
% % 
% 
% %dynamic potential game
% DGDataProcessing(regAvgMeFixGame, T, previewHorizon, numMonte)

% DGDataProcessing(player2,T, previewHorizon,numMonte, 1, "players2")
% DGDataProcessing(player6,T, previewHorizon,numMonte, 1, "players6")
% 
% DGDataProcessing(player2./costAvgNashPlayers2,T, previewHorizon,numMonte, 1, "players2Relative")
% DGDataProcessing(player6./costAvgNashPlayers6,T, previewHorizon,numMonte, 1, "players6Relative")
DGDataProcessing(player3Rel,T, previewHorizon,numMonte, 1, "players3Relative")

player3 = costAvgMeFixPlayers3-costAvgNashPlayers3;
DGDataProcessing(relativeAvgPlayers3,T, previewHorizon,numMonte, 1, "relRegretplayers3")
% sum((relativeAvgPlayers3<= 1), "all")./(T*previewHorizon)