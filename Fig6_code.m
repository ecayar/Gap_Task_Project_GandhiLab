%% generate Fig 6a
clear all 
clc
load('data_6a.mat')

figure
violins = violinplot([100*ps;100*pp;100*mpc;100*ga]',{'ps','pp','mpc','ga'},'ViolinColor',[0.9290 0.6940 0.1250]);
ylabel('DP %change')
title('Within Visual, Across Tasks')
filename=strcat('violin_vis_v_vis');
savefig(filename);
saveas(gcf,filename,'jpeg')
close(gcf)


%% generate Fig 6b
clear all 
clc
load('data_6b.mat')

figure
violins = violinplot([100*ps;100*pp;100*mpc;100*ga]',{'ps','pp','mpc','ga'},'ViolinColor',[0.9290 0.6940 0.1250]);
ylabel('DP %change')
title('Within Motor, Across Tasks')
filename=strcat('violin_mot_v_mot');
savefig(filename);
saveas(gcf,filename,'jpeg')
close(gcf)