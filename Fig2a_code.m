%% generate Fig 2a - left panel

clear all
dt = 20;
datafile = 'bl_sc_031817_sort_combined_delgap_full_gpfa_bin20_3dim_dc';
load(datafile)

lastdelaytri = max(find({D.condition} == "DelaySacc"));

trivec = 1:lastdelaytri;
wholetargtimevec = -200:600;
wholesacctimevec = -600:200;

for tri = trivec
    targonset(tri) = round(find(wholetargtimevec == 0)/dt);
    sacconset(tri) = length(D(tri).data(1,:))-round((length(wholesacctimevec)-find(wholesacctimevec == 0))/dt);
end


targplotvec = -200:dt:600;
saccplotvec = -600:dt:200;

figure

% 3D matrix - dim, tri, time pts
for d = 1:3 %iterate across the 16 columns/neurons of the cell
    for tri = trivec
        latentTemptarg(d,tri,:) = D(tri).data(d, targonset(tri)-9:targonset(tri)+31); % extract your first three dimensions (rows) and all time points for each trial
        latentTempsacc(d,tri,:) = D(tri).data(d, sacconset(tri)-30:sacconset(tri)+10); % extract your first three dimensions (rows) and all time points for each trial
    end
end

avglatTarg = squeeze(mean(latentTemptarg,2));
avglatSacc = squeeze(mean(latentTempsacc,2));
for i = 1:3
    stdlatTarg(:,i) = squeeze(std(latentTemptarg(i,:,:)));
    stdlatSacc(:,i) = squeeze(std(latentTempsacc(i,:,:)));
end
stdlatTarg = stdlatTarg';
stdlatSacc = stdlatSacc';

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
dt = 20;
datafile = 'corrected_bl_sc_031817_sort_combined_delgap_full_gpfa_bin20_3dim_dc';
load(datafile)
lastdelaytri = max(find({D.condition} == "DelaySacc"));

targCond = 1;
load('corrected_bl_lSCTrack_031817_Gap_procnew_spksort.mat')
data = data([data.inTarg] == targCond);

trivec = lastdelaytri+1:length(D);
wholetargtimevec = -200:600;
wholesacctimevec = -600:200;

targplotvec = -200:dt:400;
saccplotvec = -200:dt:200;


for i = 1:length(data)
    rt(i) = round(data(i).srts/dt);
    targonset(i) = round(find(wholetargtimevec == 0)/dt);
    sacconset(i) =  targonset(i) + rt(i);
end

for d = 1:3 %iterate across the 16 columns/neurons of the cell
    for tri = 1:length(trivec)
        latentTemptarg(d,tri,:) = D(tri).data(d, targonset(tri)-9:targonset(tri)+21); % extract your first three dimensions (rows) and all time points for each trial
        latentTempsacc(d,tri,:) = D(tri).data(d, sacconset(tri)-10:sacconset(tri)+10); % extract your first three dimensions (rows) and all time points for each trial
    end
end

avglatTarg = squeeze(mean(latentTemptarg,2));
avglatSacc = squeeze(mean(latentTempsacc,2));

for i = 1:3
    stdlatTarg(:,i) = squeeze(std(latentTemptarg(i,:,:)));
    stdlatSacc(:,i) = squeeze(std(latentTempsacc(i,:,:)));
end
stdlatTarg = stdlatTarg';
stdlatSacc = stdlatSacc';

% -200 to 400 - aligned to targonset
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



