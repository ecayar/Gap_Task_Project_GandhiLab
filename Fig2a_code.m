%% generate Fig 2a - left panel

clear all

load('data_2a.mat')

dt = 20;
targplotvec = -200:dt:600;
saccplotvec = -600:dt:200;

figure

offset = 10;
dim = 1:3;
for d = dim
    offdim = flip(dim);
    totaloffset = offset*offdim(d);

    subplot(1,2,1);
    plot(targplotvec, avglatTarg(d,:)+totaloffset, 'k');
    hold on
    plot(targplotvec, (avglatTarg(d,:)-stdlatTarg(d,:))+totaloffset, 'Color',[0.85 0.85 0.85]);
    hold on
    plot(targplotvec, (avglatTarg(d,:)+stdlatTarg(d,:))+totaloffset, 'Color',[0.85 0.85 0.85]);
    line([140,140],[0,35],'Color','b','LineWidth',2)
    xlabel('time aligned to target onset (ms)')
    ylabel('mean latent activity (au)')
    xlim([targplotvec(1) 400])

    subplot(1,2,2);
    plot(saccplotvec, avglatSacc(d,:)+totaloffset, 'k');
    hold on
    plot(saccplotvec, (avglatSacc(d,:)-stdlatSacc(d,:))+totaloffset, 'Color',[0.85 0.85 0.85]);
    hold on
    plot(saccplotvec, (avglatSacc(d,:)+stdlatSacc(d,:))+totaloffset, 'Color',[0.85 0.85 0.85]);
    line([0,0],[0,35],'Color','r','LineWidth',2)
    xlabel('time aligned to saccade onset (ms)')
    ylabel('mean latent activity (au)')
    xlim([-400 saccplotvec(end)])
end


%% generate Fig 2a - right panel

clear all

load('data_2a_pt2.mat')

dt = 20;
wholetargtimevec = -200:600;
wholesacctimevec = -600:200;
targplotvec = -200:dt:400;
saccplotvec = -200:dt:200;


offset = 10;
figure
dim = 1:3;

for d = dim
    offdim = flip(dim);
    totaloffset = offset*offdim(d);

    subplot(1,2,1);
    plot(targplotvec, avglatTarg(d,:)+totaloffset, 'k');
    hold on
    plot(targplotvec, (avglatTarg(d,:)-stdlatTarg(d,:))+totaloffset, 'Color',[0.85 0.85 0.85]);
    hold on
    plot(targplotvec, (avglatTarg(d,:)+stdlatTarg(d,:))+totaloffset, 'Color',[0.85 0.85 0.85]);
    line([140,140],[0,35],'Color',[0 1 1],'LineWidth',2)
    xlabel('time aligned to target onset (ms)')
    ylabel('mean latent activity (au)')
    xlim([targplotvec(1)+200 targplotvec(end)])
    stdU = 179.087524231197;
    stdD = 227.987947466917;
    line([stdU,stdU],[0,35],'Color','k','LineStyle','--','LineWidth',1)
    hold on
    line([stdD,stdD],[0,35],'Color','k','LineStyle','--','LineWidth',1)

    subplot(1,2,2);
    plot(saccplotvec, avglatSacc(d,:)+totaloffset, 'k');
    hold on
    plot(saccplotvec, (avglatSacc(d,:)-stdlatSacc(d,:))+totaloffset, 'Color',[0.85 0.85 0.85]);
    hold on
    plot(saccplotvec, (avglatSacc(d,:)+stdlatSacc(d,:))+totaloffset, 'Color',[0.85 0.85 0.85]);
    line([0,0],[0,35],'Color',[1 0.4 0.6],'LineWidth',2)
    xlabel('time aligned to saccade onset (ms)')
    ylabel('mean latent activity (au)')
    xlim([saccplotvec(1) saccplotvec(end)])
    stdU = -39.0875242311967;
    stdD = -87.987947466916500;
    line([stdU,stdU],[0,35],'Color','k','LineStyle','--','LineWidth',1)
    hold on
    line([stdD,stdD],[0,35],'Color','k','LineStyle','--','LineWidth',1)

end