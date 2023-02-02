%% Generate Fig. 6

load('data_6.mat')

pval_matched_VFR = data(1,:);
accs_matched_VFR = data(4,:);

B = polyfit(log(pval_matched_VFR), accs_matched_VFR, 1);
fitFOE = polyval(B,log(pval_matched_VFR));
figure
subplot(3,1,3)
xi = linspace(10^-5,10^0) ;  % give your values for xmin, xmax
yi =  polyval(B,log(xi));
semilogx(pval_matched_VFR, accs_matched_VFR, '*',    xi, yi,'-')
ylim([40 100])
yline(50,'--')
xline(10^-1,'--')
xlim([10^-5 10^0])
[rVmatch,pVmatch] = corrcoef(log(pval_matched_VFR),accs_matched_VFR);

clearvars -except data
pval_V = data(2,:);
accs_V = data(5,:);
B = polyfit(log(pval_V), accs_V, 1);
fitFOE = polyval(B,log(pval_V));
subplot(3,1,2)
xi = linspace(10^-5,10^0) ;  % give your values for xmin, xmax
yi =  polyval(B,log(xi));
semilogx(pval_V, accs_V, '*',    xi, yi,'-')
ylim([40 100])
yline(50,'--')
xline(10^-1,'--')
xlim([10^-5 10^0])

pval_M = data(3,:);
accs_M = data(6,:);
B = polyfit(log(pval_M), accs_M, 1);
fitFOE = polyval(B,log(pval_M));
subplot(3,1,1)
xi = linspace(10^-5,10^0) ;  % give your values for xmin, xmax
yi =  polyval(B,log(xi));
semilogx(pval_M, accs_M, '*',    xi, yi,'-')
ylim([40 100])
yline(50,'--')
xline(10^-1,'--')
xlim([10^-5 10^0])

% do pearson's correlation to find significance/correlation
[r,p] = corrcoef(log(pval_V),accs_V);
[rM,pM] = corrcoef(log(pval_M),accs_M);


