%% Generate Fig. 1b left panel

clear all
clc
load('data_1b.mat')

targplotvec = -200:601;
saccplotvec = -600:200;
offset = 50;
chanOrder = 1:16;

figure
hold on

for n = 1:Ncount
    chanIndex = chanOrder(n);
    totaloffset = offset*(n-1);
    % plot targ epoch
    subplot(1,2,1);
    hold on
    plot(targplotvec, psth(chanIndex, targEpochInd)+totaloffset, 'LineWidth', 1.2, 'Color', 'k');  %plot the values of a different neuron than n (new index), still need the values from spkdensity
    ylabel('Neuron')
    xlim([targplotvec(1), targplotvec(end)-200])
    ylim([0 totaloffset+(offset*1.5)])
    % plot sacc epoch
    xlabel('Time aligned to target onset (ms)') %400 to 600 ms
    hold on
    line([160,160],[0,totaloffset+(offset*1.5)],'Color','b','LineWidth',2)


    subplot(1,2,2);
    hold on
    plot(saccplotvec, psth(chanIndex, saccEpochInd)+totaloffset, 'LineWidth', 1.2, 'Color', 'k'); %plot the values of a different neuron than n (new index), still need the values from spkdensity
    xlabel('Time aligned to saccade onset (ms)') %400 to 600 ms
    ylabel('Neuron')
    xlim([saccplotvec(1)+200, saccplotvec(end)])
    ylim([0 totaloffset+(offset*1.5)])
    hold on
    xline(0,'r')
    line([0,0],[0,totaloffset+(offset*1.5)],'Color','r','LineWidth',2)
end

sgtitle(strcat('bl_sc_03817 PSTH: Delay Task'), 'Interpreter', 'none');

%% Generate Fig. 1b right panel
clear all

load('data_1b_pt2.mat')
targplotvec = 0:400;
saccplotvec = -200:200;
offset = 50;

figure
hold on
subplot(1,2,1)
for n = 1:Ncount
    hold on
    chanIndex = chanOrder(n);
    totaloffset = offset*(n-1);
    plot(targplotvec, psth(chanIndex, 401:801)+totaloffset, 'LineWidth', 1.2, 'Color', 'k');
    line([140,140],[0,totaloffset+(offset*1.5)],'Color',[0 1 1],'LineWidth',2)
end
xlim([0 400])
ylim([0 825])
stdU = 179.087524231197; % found previously
stdD = 227.987947466917; % found previously
line([stdU,stdU],[0,825],'Color','k','LineWidth',2)
hold on
line([stdD,stdD],[0,825],'Color','k','LineWidth',2)


subplot(1,2,2)
for n = 1:Ncount
    hold on
    chanIndex = chanOrder(n);
    totaloffset = offset*(n-1);
    plot(saccplotvec, psthsacc(chanIndex, 401:801)+totaloffset, 'LineWidth', 1.2, 'Color', 'k');
    line([0,0],[0,totaloffset+(offset*1.5)],'Color',[1 0.4 0.6],'LineWidth',2)
end
xlim([-200 200])
ylim([0 825])
stdU = -39.0875242311967;
stdD = -87.987947466916500;
line([stdU,stdU],[0,825],'Color','k','LineWidth',2)
hold on
line([stdD,stdD],[0,825],'Color','k','LineWidth',2)

sgtitle(strcat('bl_sc_03817 PSTH: Gap Task'), 'Interpreter', 'none');

