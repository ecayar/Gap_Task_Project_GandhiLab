%% generate Fig 3b
load('data_3b_4b_5ce.mat')
accmat = accmat_all{1};
figure
violins = violinplot(accmat',{'Vis v Vis','Mot v Mot'},'ViolinColor',[0.9290 0.6940 0.1250]);
ylim([40 100])
yline(50,'--')
title('Within Content - Delay vs Gap classification accuracies')

%% generate Fig 4b
accmat = accmat_all{2};
figure
violins = violinplot(accmat',{'Vis v Motor','Mot v Motor'},'ViolinColor',[0.9290 0.6940 0.1250]);
ylim([40 100])
yline(50,'--')
title('Within Context - Visual vs Motor classification accuracies')

%% generate Fig 5c 
accmat = accmat_all{3};
figure
violins = violinplot(accmat',{'V v M'},'ViolinColor',[0.9290 0.6940 0.1250]);
ylim([40 100])
yline(50,'--')
title('Visual vs Motor classification accuracies')

%% generate Fig 5e 
accmat = accmat_all{4};
figure
violins = violinplot(accmat',{'Delay v Gap'},'ViolinColor',[0.9290 0.6940 0.1250]);
ylim([40 100])
yline(50,'--')
title('Delay vs Gap classification accuracies')



%% generate Fig 3b CHANCE
load('updated_within_task_chance_levels.mat')
figure
violins = violinplot(meanAccMat',{'Vis v Vis','Mot v Mot'},'ViolinColor',[0.9290 0.6940 0.1250]);
ylim([40 100])
% yline(50,'--')
title('Within Content - Delay vs Gap classification accuracies')

%% generate Fig 4b CHANCE
load('within_epoch_chance_levels.mat')
figure
violins = violinplot(meanAccMat',{'Vis v Motor','Mot v Motor'},'ViolinColor',[0.9290 0.6940 0.1250]);
ylim([40 100])
% yline(50,'--')
title('Within Context - Visual vs Motor classification accuracies')

%% generate Fig 5c & e CHANCE
load('vis_v_mot_chance_accs.mat')
meanAccMat_temp = meanAccMat; 
load('del_v_gap_chance_accs.mat')
meanAccMat = [meanAccMat_temp; meanAccMat];
figure
violins = violinplot(meanAccMat',{'V v M','Delay v Gap'},'ViolinColor',[0.9290 0.6940 0.1250]);
ylim([40 100])
% yline(50,'--')
title('Visual vs Motor classification accuracies')