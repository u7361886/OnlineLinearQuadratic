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
numMonte = 100*numThreads;
wMag = 0;
%% pendulum system
tic
%[regAvgMeFixTrackingPendulum,regAvgMeFixOnestepPendulum,regAvgLiPendulum,regAvgJingtaoPendulum] = experimentOnlineLinear(T,previewHorizon,numMonte,"pendulum",wMag);
[costTracking,costOnestep,costLina,costJingtao,costNash] = experimentOnlineLinear(T,previewHorizon,numMonte,typeSystem,wMag,n,m);

save('.\regrets\costAvgMeFixTrackingPendulum.mat','costAvgMeFixTrackingPendulum')
save('.\regrets\costAvgMeFixOnestepPendulum.mat','costAvgMeFixOnestepPendulum')
save('.\regrets\costAvgLiPendulum.mat','costAvgLiPendulum')
save('.\regrets\costAvgJingPendulum.mat','costAvgJingPendulum')
save('.\regrets\costAvgNashPendulum.mat','costAvgNashPendulum')

% save('.\regrets\regAvgMeFixTrackingPendulum.mat','regAvgMeFixTrackingPendulum')
% save('.\regrets\regAvgMeFixOnestepPendulum.mat','regAvgMeFixOnestepPendulum')
% save('.\regrets\regAvgLiPendulum.mat','regAvgLiPendulum')
toc
%% random system
tic
n = 4;
m = 1;
[regAvgMeFixTrackingRandom,regAvgMeFixOnestepRandom,regAvgLiRandom,regAvgJingtaoRandom] = experimentOnlineLinear(T,previewHorizon,numMonte,"random",wMag,n,m);
% save('.\regrets\regAvgMeFixTrackingRandom.mat','regAvgMeFixTrackingRandom')
% save('.\regrets\regAvgMeFixOnestepRandom.mat','regAvgMeFixOnestepRandom')
% save('.\regrets\regAvgLiRandom.mat','regAvgLiRandom')
toc
%% disturbance 
wMag = 1;
tic
[regAvgMeFixTrackingPendulumDisturbance,regAvgMeFixOnestepPendulumDisturbance,regAvgLiPendulumDisturbance,regAvgJingtaoPendulumDisturbance] = experimentOnlineLinear(T,previewHorizon,numMonte,"pendulum",wMag);
% save('.\regrets\regAvgMeFixTrackingPendulumDisturbance.mat','regAvgMeFixTrackingPendulumDisturbance')
% save('.\regrets\regAvgMeFixOnestepPendulumDisturbance.mat','regAvgMeFixOnestepPendulumDisturbance')
% save('.\regrets\regAvgLiPendulumDisturbance.mat','regAvgLiPendulumDisturbance')
toc
%%
tic
n = 4;
m = 1;
[regAvgMeFixTrackingRandomDisturbance,regAvgMeFixOnestepRandomDisturbance,regAvgLiRandomDisturbance,regAvgJingtaoRandomDisturbance] = experimentOnlineLinear(T,previewHorizon,numMonte,"random",wMag,n,m);
% save('.\regrets\regAvgMeFixTrackingRandomDisturbance.mat','regAvgMeFixTrackingRandomDisturbance')
% save('.\regrets\regAvgMeFixOnestepRandomDisturbance.mat','regAvgMeFixOnestepRandomDisturbance')
% save('.\regrets\regAvgLiRandomDisturbance.mat','regAvgLiRandomDisturbance')
toc
%% dynamic game
tic
Nplayers = 2;
T = 40;
previewHorizon = 6;
[costAvgMeFixPlayers2, costAvgNashPlayers2, relativeAvgPlayers2] = experimentOnlineGame(T,previewHorizon,numMonte,Nplayers);
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
% relative2 = ((costAvgMeFixPlayers2-costAvgNashPlayers2)./costAvgNashPlayers2);
% figure
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
showComparisons(regAvgLiPendulum, regAvgMeFixTrackingPendulum, regAvgMeFixOnestepPendulum,regAvgJingtaoPendulum);
disp('Random Comparison');
showComparisons(regAvgLiRandom, regAvgMeFixTrackingRandom, regAvgMeFixOnestepRandom,regAvgJingtaoRandom);
disp('Pendulum Comparison Disturbance')
showComparisons(regAvgLiPendulumDisturbance, regAvgMeFixTrackingPendulumDisturbance, regAvgMeFixOnestepPendulumDisturbance, regAvgJingtaoPendulumDisturbance);
disp('Random Comparison Disturbance')
showComparisons(regAvgLiRandomDisturbance, regAvgMeFixTrackingRandomDisturbance, regAvgMeFixOnestepRandomDisturbance,regAvgJingtaoRandomDisturbance);

%% Data Processing
% 
% load("C:\Users\ychen\OneDrive\Documents\GitHub\OnlineLinearQuadratic\regrets\regAvgMeFixTrackingPendulum.mat")
% load("C:\Users\ychen\OneDrive\Documents\GitHub\OnlineLinearQuadratic\regrets\regAvgLiPendulum.mat")
% load("C:\Users\ychen\OneDrive\Documents\GitHub\OnlineLinearQuadratic\regrets\regAvgMeFixOnestepPendulum.mat")
% 
% load("C:\Users\ychen\OneDrive\Documents\GitHub\OnlineLinearQuadratic\regrets\regAvgMeFixTrackingRandom.mat")
% load("C:\Users\ychen\OneDrive\Documents\GitHub\OnlineLinearQuadratic\regrets\regAvgMeFixOnestepRandom.mat")
% load("C:\Users\ychen\OneDrive\Documents\GitHub\OnlineLinearQuadratic\regrets\regAvgLiRandom.mat")

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
DGDataProcessing(player3,T, previewHorizon,numMonte, 1, "players3")
% sum((relativeAvgPlayers3<= 1), "all")./(T*previewHorizon)