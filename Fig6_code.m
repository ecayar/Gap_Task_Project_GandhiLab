load('data_6.mat')

figure
for k = 1:20
    if h_m(k) == 1
        scatter(delavg_m(k),gapavg_m(k),'filled','k')
    else
        scatter(delavg_m(k),gapavg_m(k),'k')
    end
    hold on
end
ylim([0 0.6])
xlim([0 0.6])
axis square
line([0,0.6],[0,0.6],'Color','k','LineStyle','--')
xlabel('Delay task (correlation)')
ylabel('Gap task (correlation)')
title('Motor Burst')


figure
for k = 1:20
    if h_v(k) == 1
        scatter(delavg_v(k),gapavg_v(k),'filled','k')
    else
        scatter(delavg_v(k),gapavg_v(k),'k')
    end
    hold on
end
ylim([0 0.7])
xlim([0 0.7])
axis square
line([0,0.7],[0,0.7],'Color','k','LineStyle','--')
xlabel('Delay task (correlation)')
ylabel('Gap task (correlation)')
title('Visual Burst')