clear all
close all
warning('off')
clc
%% initialize experiment
T = 40;
previewHorizon = 6;
numThreads = 10;
% numThreads = str2double(getenv('NUMBER_OF_PROCESSORS'));
% maxNumCompThreads(numThreads);
% tempMonte = str2double(getenv('NUMBER_OF_PROCESSORS'));
numMonte = 2*numThreads;
wMag = 0;
%% pendulum system
tic
[regAvgMeFixTrackingPendulum,regAvgMeFixOnestepPendulum,regAvgLiPendulum] = experimentOnlineLinear(T,previewHorizon,numMonte,"pendulum",wMag);
save('.\regrets\regAvgMeFixTrackingPendulum.mat','regAvgMeFixTrackingPendulum')
save('.\regrets\regAvgMeFixOnestepPendulum.mat','regAvgMeFixOnestepPendulum')
save('.\regrets\regAvgLiPendulum.mat','regAvgLiPendulum')
toc
%% random system
tic
n = 4;
m = 1;
[regAvgMeFixTrackingRandom,regAvgMeFixOnestepRandom,regAvgLiRandom] = experimentOnlineLinear(T,previewHorizon,numMonte,"random",wMag,n,m);
save('.\regrets\regAvgMeFixTrackingRandom.mat','regAvgMeFixTrackingRandom')
save('.\regrets\regAvgMeFixOnestepRandom.mat','regAvgMeFixOnestepRandom')
save('.\regrets\regAvgLiRandom.mat','regAvgLiRandom')
toc
%% disturbance 
wMag = 1;
tic
[regAvgMeFixTrackingPendulumDisturbance,regAvgMeFixOnestepPendulumDisturbance,regAvgLiPendulumDisturbance] = experimentOnlineLinear(T,previewHorizon,numMonte,"pendulum",wMag);
save('.\regrets\regAvgMeFixTrackingPendulumDisturbance.mat','regAvgMeFixTrackingPendulumDisturbance')
save('.\regrets\regAvgMeFixOnestepPendulumDisturbance.mat','regAvgMeFixOnestepPendulumDisturbance')
save('.\regrets\regAvgLiPendulumDisturbance.mat','regAvgLiPendulumDisturbance')
toc
%%
tic
n = 4;
m = 1;
[regAvgMeFixTrackingRandomDisturbance,regAvgMeFixOnestepRandomDisturbance,regAvgLiRandomDisturbance] = experimentOnlineLinear(T,previewHorizon,numMonte,"random",wMag,n,m);
save('.\regrets\regAvgMeFixTrackingRandomDisturbance.mat','regAvgMeFixTrackingRandomDisturbance')
save('.\regrets\regAvgMeFixOnestepRandomDisturbance.mat','regAvgMeFixOnestepRandomDisturbance')
save('.\regrets\regAvgLiRandomDisturbance.mat','regAvgLiRandomDisturbance')
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
DGDataProcessing(regAvgMeFixTrackingPendulum, T, previewHorizon,numMonte)
DGDataProcessing(regAvgMeFixOnestepPendulum, T, previewHorizon,numMonte,4)
DGDataProcessing(regAvgMeFixTrackingRandom, T, previewHorizon,numMonte)
DGDataProcessing(regAvgMeFixOnestepRandom, T, previewHorizon,numMonte,ceil(n/m))
DGDataProcessing(regAvgLiRandom, T, previewHorizon,numMonte)
% 
% % %comparison with Li no disturbance
DGDataProcessing(regAvgLiPendulum-regAvgMeFixTrackingPendulum, T, previewHorizon,numMonte)
DGDataProcessing(regAvgLiPendulum-regAvgMeFixOnestepPendulum, T, previewHorizon,numMonte,4)
DGDataProcessing(regAvgLiRandom-regAvgMeFixTrackingRandom, T, previewHorizon,numMonte)
DGDataProcessing(regAvgLiRandom-regAvgMeFixOnestepRandom, T, previewHorizon,numMonte,ceil(n/m))

sum((regAvgLiPendulum-regAvgMeFixTrackingPendulum)>=0,"all")/(T*previewHorizon)
sum((regAvgLiRandom-regAvgMeFixTrackingRandom)>=0,"all")/(T*previewHorizon)

sum((regAvgLiPendulum-regAvgMeFixOnestepPendulum)>=0,"all")/(T*previewHorizon)
sum((regAvgLiRandom-regAvgMeFixOnestepRandom)>=0,"all")/(T*previewHorizon)

% 
% % %linear with disturbance
% DGDataProcessing(regAvgMeFixTrackingPendulumDisturbance, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepPendulumDisturbance, T, previewHorizon,numMonte,4)
% DGDataProcessing(regAvgMeFixTrackingRandomDisturbance, T, previewHorizon,numMonte)
% DGDataProcessing(regAvgMeFixOnestepRandomDisturbance, T, previewHorizon,numMonte,ceil(n/m))
% 
% %comparison with li disturbance regAvgLiPendulumDisturbance
DGDataProcessing(regAvgLiPendulumDisturbance-regAvgMeFixTrackingPendulumDisturbance, T, previewHorizon,numMonte)
DGDataProcessing(regAvgLiPendulumDisturbance-regAvgMeFixOnestepPendulumDisturbance, T, previewHorizon,numMonte,4)
DGDataProcessing(regAvgLiRandomDisturbance-regAvgMeFixTrackingRandomDisturbance, T, previewHorizon,numMonte)
DGDataProcessing(regAvgLiRandomDisturbance-regAvgMeFixOnestepRandomDisturbance, T, previewHorizon,numMonte,ceil(n/m))

sum((regAvgLiPendulumDisturbance-regAvgMeFixTrackingPendulumDisturbance)>=0,"all")/(T*previewHorizon)
sum((regAvgLiPendulumDisturbance-regAvgMeFixOnestepPendulumDisturbance)>=0,"all")/(T*previewHorizon)
sum((regAvgLiRandomDisturbance-regAvgMeFixTrackingRandomDisturbance)>=0,"all")/(T*previewHorizon)
sum((regAvgLiRandomDisturbance-regAvgMeFixOnestepRandomDisturbance)>=0,"all")/(T*previewHorizon)
%dynamic potential game
% DGDataProcessing(regAvgMeFixGame,T, previewHorizon,numMonte)