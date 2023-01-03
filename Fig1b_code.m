%% Generate Fig. 1b left panel

clear all
clc
load('bl_lSCTrack_031817_DelaySacc_proc.mat')
%----User input----%
% 1 - inTarg
% 0 - outTarg
targCond = 1;

% rename the data that was laoded into the workspace before making any
% changes
dataorig = data;

numTrials = length(data);
inTarg = zeros(numTrials, 1);
data = data([data.inTarg] == targCond);

FRmatrix = zeros(numTrials,length(data(1).spikeTimestamps), 2*length(data(1).targspikemat(1,:)));

for n = 1:length(data(1).spikeTimestamps) %iterate across the 16 columns/neurons of the cell
    for tri = 1:length(data)
        stspk = horzcat(data(tri).targspikemat(n,:),data(tri).saccspikemat(n,:));
        stspkden = filter_FR(stspk,10,1000); %1000 > sampling = convert from ms to sec to increase magnitude
        % 10 is sigma = normal distriubtion, smoothes the connection between points
        FRmatrix(tri, n, :) = stspkden; %specify where you want time, neurons, and trials to go in the 3D matrix
    end
end

targEpochInd = 200:length(data(1).targspikemat(1,:));
targplotvec = -200:601;

saccEpochInd = (1+length(data(1).targspikemat(1,:))):(length(stspk)-200);
saccplotvec = -600:200;


for tri = 1:length(data)
    [data.RT] = deal([]);
    inew = 1;
    for i = 1:length(data)
        if data(i).inTarg == targCond && data(i).success == 1
            origidx = inew;
            % {2,5} is where to find the goCode in stateTransitions
            goCode = data(i).params.goCode;
            srtsvec(inew, :) = data(i).behavrpt.saccTime - data(i).stateTransitions(2,goCode);
            inew = inew+1;
            % put data into a new field
        end
    end
end

psth = squeeze(mean(FRmatrix));

offset = 50;
chanOrder = 1:16; % for all recording sessions 2016 and after?
Ncount = length(data(1).spikeTimestamps);


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

load('bl_lSCTrack_031817_Gap_procnew.mat')
% load('corrected_bl_lSCTrack_031817_Gap_procnew_spksort.mat')
%----User input----%
% 1 - inTarg
% 0 - outTarg
targCond = 1;

numTrials = length(data);
FRmatrix = zeros(numTrials, length(data(1).spikeTimestamps), length(-400:600)); %number of trials x numnber of neurons x number of time points
inTarg = zeros(numTrials, 1);
data = data([data.inTarg] == targCond);

for n = 1:length(data(1).spikeTimestamps) %iterate across the 16 columns/neurons of the cell
    for tri = 1:length(data)
        stspk = data(tri).targspikemat(n,:);
        stspkden = filter_FR(stspk,10,1000); %1000 > sampling = convert from ms to sec to increase magnitude
        % 10 is sigma = normal distriubtion, smoothes the connection between points
        FRmatrix(tri, n, :) = stspkden; %specify where you want time, neurons, and trials to go in the 3D matrix
    end
end

targplotvec = 0:400;
saccplotvec = -200:200;

psth = squeeze(mean(FRmatrix));

offset = 50;
    chanOrder = flip(data(1).chanOrder);
    Ncount = length(data(1).spikeTimestamps);

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

FRmatrixsacc = zeros(numTrials, length(data(1).spikeTimestamps), length(-600:400)); %number of trials x numnber of neurons x number of time points

for n = 1:length(data(1).spikeTimestamps) %iterate across the 16 columns/neurons of the cell
    for tri = 1:length(data)
        stspksacc = data(tri).saccspikemat(n,:);
        stspkdensacc = filter_FR(stspksacc,10,1000); %1000 > sampling = convert from ms to sec to increase magnitude
        % 10 is sigma = normal distriubtion, smoothes the connection between points
        FRmatrixsacc(tri, n, :) = stspkdensacc; %specify where you want time, neurons, and trials to go in the 3D matrix
    end
end
psthsacc = squeeze(mean(FRmatrixsacc));

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

