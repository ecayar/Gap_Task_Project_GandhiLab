clear all

load('data_2b_d.mat')
testdata = data(1,:);

figure
col=hsv(20);
for d = 1:3
    f = subplot(3,1,d);
    for k = 1:length(testdata)
        clearvars -except testdata d k f col
        test = cell2mat(testdata(k));
        
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

load('data_2b_d.mat')
data = data(2,:);


count=0;
figure
for m = 1:length(data)
    clearvars -except data m colorscheme count
    vaf = cell2mat(data(m));
    
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
