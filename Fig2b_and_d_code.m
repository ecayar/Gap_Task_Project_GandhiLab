clear all

testdata = {'bl_lSCTrack_020817_sort_delgap_test.mat','bl_lSCTrack_031817_sort_delgap_test.mat','bl_lSCTrack_032117_sort_delgap_test.mat','bl_lSCTrack_121216_sort_delgap_test.mat',...
    'bl_lSCTrack_121316_sort_delgap_test.mat','bl_lSCTrack_121616_sort_delgap_test.mat','bl_lSCTrack_121816_sort_delgap_test.mat','su_track_03302021_1_sort_delgap_test.mat','su_track_03312021_1_sort_delgap_test.mat','su_track_04072021_1_sort_delgap_test.mat',...
    'su_track_04272021_1_sort_delgap_test.mat', 'su_track_05062021_1_sort_delgap_test.mat', 'su_track_05072021_1_sort_delgap_test.mat', 'su_track_05212021_1_sort_delgap_test.mat',...
    'su_track_05252021_1_sort_delgap_test.mat','su_track_05282021_1_sort_delgap_test.mat','su_track_06012021_1_sort_delgap_test.mat','su_track_06082021_1_sort_delgap_test.mat',...
    'su_track_06162021_1_sort_delgap_test.mat','su_track_07092021_1_sort_delgap_test.mat'};

figure
col=hsv(20);
for d = 1:3
    f = subplot(3,1,d);
    for k = 1:length(testdata)
        clearvars -except testdata d k f col
        load(string(testdata(k)))
        
        for n = 1:length(test)
            weight(n,1) = abs(test(n,d));
        end
        [sorted_weights,sorted_ind] = sort(weight,'descend');
        plot([1:length(test)],sorted_weights,'color','k','LineWidth',0.5);
        hold on
    end
    ylim([0 1])
    xlabel('Neuron number (sorted by projection weight magnitude)')
    ylabel('Absolute value of projection weight (au)')
    title(strcat('dim',{' '}, int2str(d)))
end


%% variance accounted for plots
clear all

data = {'bl_lSCTrack_020817_sort_delgap_vaf.mat',...
    'bl_lSCTrack_031817_sort_delgap_vaf.mat',...
    'bl_lSCTrack_032117_sort_delgap_vaf.mat',...
    'bl_lSCTrack_121216_sort_delgap_vaf.mat',...
    'bl_lSCTrack_121316_sort_delgap_vaf.mat',...
    'bl_lSCTrack_121616_sort_delgap_vaf.mat',...
    'bl_rSCTrack_121816_sort_delgap_vaf.mat',...
    'su_track_03302021__sort_delgap_vaf.mat',...
    'su_track_03312021__sort_delgap_vaf.mat',...
    'su_track_04072021__sort_delgap_vaf.mat',...
    'su_track_04272021__sort_delgap_vaf.mat', ...
    'su_track_05062021__sort_delgap_vaf.mat', ...
    'su_track_05072021__sort_delgap_vaf.mat', ...
    'su_track_05212021__sort_delgap_vaf.mat',...
    'su_track_05252021__sort_delgap_vaf.mat',...
    'su_track_05282021__sort_delgap_vaf.mat',...
    'su_track_06012021__sort_delgap_vaf.mat',...
    'su_track_06082021__sort_delgap_vaf.mat',...
    'su_track_06162021__sort_delgap_vaf.mat',...
    'su_track_07092021__sort_delgap_vaf.mat'};

count=0;
figure
for m = 1:length(data)
    clearvars -except data m colorscheme count
    load(string(data(m)))
    
    hold on
    plot(vaf,'Color','k','LineWidth',1.2)
    if vaf(3)>=0.95
        count=count+1;
    end
    
end
xlim([0.6 27.1])
ylim([0.6 1])
xticks(1:2:27)
xlabel('Number of latent factors')
ylabel('Cummulative shared variance explained (%)')
title('VAF plot - 13/20 95% explained by 3 dims')
disp(count)