clear all
close all
% clc
%% initialize experiment
T = 50;
previewHorizon = 6;
numThreads = 10;
% numThreads = str2double(getenv('NUMBER_OF_PROCESSORS'));
% maxNumCompThreads(numThreads);
% tempMonte = str2double(getenv('NUMBER_OF_PROCESSORS'));
numMonte = 100*numThreads;
wMag = 0;
%% pendulum system
tic
[regAvgMeFixTrackingPendulum,regAvgMeFixOnestepPendulum,regAvgLiPendulum] = experimentOnlineLinear(T,previewHorizon,numMonte,"pendulum",wMag);
save('.\regrets\' + 'regAvgMeFixTrackingPendulum' + '.mat','regAvgMeFixTrackingPendulum')
save('.\regrets\' + 'regAvgMeFixOnestepPendulum' + '.mat','regAvgMeFixOnestepPendulum')
save('.\regrets\' + 'regAvgLiPendulum' + '.mat','regAvgLiPendulum')
toc
%% random system
tic
n = 5;
m = 2;
[regAvgMeFixTrackingRandom,regAvgMeFixOnestepRandom,regAvgLiRandom] = experimentOnlineLinear(T,previewHorizon,numMonte,"random",wMag,n,m);
save('.\regrets\' + 'regAvgMeFixTrackingRandom' + '.mat','regAvgMeFixTrackingRandom')
save('.\regrets\' + 'regAvgMeFixOnestepRandom' + '.mat','regAvgMeFixOnestepRandom')
save('.\regrets\' + 'regAvgLiRandom' + '.mat','regAvgLiRandom')
toc
%% disturbance 
wMag = 1;
tic
[regAvgMeFixTrackingPendulumDisturbance,regAvgMeFixOnestepPendulumDisturbance,regAvgLiPendulumDisturbance] = experimentOnlineLinear(T,previewHorizon,numMonte,"pendulum",wMag);
save('.\regrets\' + 'regAvgMeFixTrackingPendulumDisturbance' + '.mat','regAvgMeFixTrackingPendulumDisturbance')
save('.\regrets\' + 'regAvgMeFixOnestepPendulumDisturbance' + '.mat','regAvgMeFixOnestepPendulumDisturbance')
save('.\regrets\' + 'regAvgLiPendulumDisturbance' + '.mat','regAvgLiPendulumDisturbance')
n = 5;
m = 2;
[regAvgMeFixTrackingRandomDisturbance,regAvgMeFixOnestepRandomDisturbance,regAvgLiRandomDisturbance] = experimentOnlineLinear(T,previewHorizon,numMonte,"random",wMag,n,m);
save('.\regrets\' + 'regAvgMeFixTrackingRandomDisturbance' + '.mat','regAvgMeFixTrackingRandomDisturbance')
save('.\regrets\' + 'regAvgMeFixOnestepRandomDisturbance' + '.mat','regAvgMeFixOnestepRandomDisturbance')
save('.\regrets\' + 'regAvgLiRandomDisturbance' + '.mat','regAvgLiRandomDisturbance')
toc
%% dynamic game
% tic
% Nplayers = 6;
% regAvgMeFixGame = experimentOnlineGame(T,previewHorizon,numMonte,Nplayers);
% save('.\regrets\regAvgMeFixGame.mat','regAvgMeFixGame')
% toc
%% Data Processing
% 
% %linear no disturbance
% DGDataProcessing(regAvgMeFixTrackingPendulum, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepPendulum, T, previewHorizon,numMonte,4)
% DGDataProcessing(regAvgMeFixTrackingRandom, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepRandom, T, previewHorizon,numMonte,ceil(n/m))
% %comparison with Li no disturbance
% DGDataProcessing(regAvgMeFixTrackingPendulum-regAvgLiPendulum, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepPendulum-regAvgLiPendulum, T, previewHorizon,numMonte,4)
% DGDataProcessing(regAvgMeFixTrackingRandom-regAvgLiRandom, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepRandom-regAvgLiRandom, T, previewHorizon,numMonte,ceil(n/m))
% 
% %linear with disturbance
% DGDataProcessing(regAvgMeFixTrackingPendulumDisturbance, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepPendulumDisturbance, T, previewHorizon,numMonte,4)
% DGDataProcessing(regAvgMeFixTrackingRandomDisturbance, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepRandomDisturbance, T, previewHorizon,numMonte,ceil(n/m))
% 
% %comparison with li disturbance regAvgLiPendulumDisturbance
% DGDataProcessing(regAvgMeFixTrackingPendulumDisturbance-regAvgLiPendulumDisturbance, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepPendulumDisturbance-regAvgLiPendulumDisturbance, T, previewHorizon,numMonte,4)
% DGDataProcessing(regAvgMeFixTrackingRandomDisturbance-regAvgLiRandomDisturbance, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepRandomDisturbance-regAvgLiRandomDisturbance, T, previewHorizon,numMonte,ceil(n/m))

%dynamic potential game
% DGDataProcessing(regAvgMeFixGame,T, previewHorizon,numMonte)