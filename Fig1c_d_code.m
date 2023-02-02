%% Generate Fig. 1C
clear all
clc

load('data_1c.mat')
num_datasets = 20; 

% TYPE = 0 plots visual peak firing rates
% TYPE = 1 plots motor peak firing rates

for TYPE = 0:1
    if TYPE == 0
        all_del = data_1c(1,:);
        all_gap = data_1c(2,:);
    else
        all_del = data_1c(3,:);
        all_gap = data_1c(4,:);
    end

    figure
    for k = 1:num_datasets
        scatter(all_del{1,k},all_gap{1,k},'filled','k')
        hold on
    end

    if TYPE == 0
        xlim([0 400])
        ylim([0 400])
        axis square
        line([0,400],[0,400],'Color','k','LineStyle','--')
        xlabel('Delay Vis FR')
        ylabel('Gap Vis FR')
    else
        xlim([0 450])
        ylim([0 450])
        axis square
        line([0,450],[0,450],'Color','k','LineStyle','--')
        xlabel('Delay Mot FR')
        ylabel('Gap Mot FR')

    end

end