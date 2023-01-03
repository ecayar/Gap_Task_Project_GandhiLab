clear all
clc
%--------------------User Input--------------------%
% comment 1 for FA, 20 for GPFA
dt = 20;

load('corrected_bl_sc_031817_sort_combined_delgap_full_gpfa_bin20_3dim_dc.mat')
load('bl_lSCTrack_031817_DelaySacc_proc_spksort_final.mat')

lastdelaytri = max(find({D.condition} == "DelaySacc"));

[D.SACC] = deal([]);
inew = 1;
for i = 1:length(data)
    if data(i).inTarg == 1 && data(i).success == 1
        origid = inew;
        saccTemp = 201 + data(i).srts;
        D(inew).SACC = saccTemp;
        inew = inew+1;
    end
end

[D.RT] = deal([]);
inew = 1;
for i = 1:length(data)
    if data(i).inTarg == 1 && data(i).success == 1
        origidx = inew;
        rtTemp = data(i).srts - data(i).delays;
        D(inew).RT = rtTemp;
        inew = inew+1;
    end
end

rng('default');
seed = rng(13);
trivec = 1:lastdelaytri;

wholetargtimevec = -200:600;
wholesacctimevec = -600:200;

for tri = trivec % specify you want to run through all trials
    % made visburst 140 instead of 160 (appears to spike earlier)
    visburst = round(find(wholetargtimevec == 140)/dt);
    sacconset = length(D(tri).data(1,:))-round((length(wholesacctimevec)-find(wholesacctimevec == 0))/dt);
    visburstpts(:,tri) = D(tri).data(1:3, visburst);
    sacconsetpts(:,tri) = D(tri).data(1:3, sacconset);

    clear latentTemp
    xlabel('Factor 1')
    ylabel('Factor 2')
    zlabel('Factor 3')
end

nottrivec = 1:lastdelaytri;
nottrivec(trivec) = [];
visburstpts(:,nottrivec) = NaN;
sacconsetpts(:,nottrivec) = NaN;

delvisburstpts = visburstpts;
delsacconsetpts = sacconsetpts;

clear visburstpts sacconsetpts
load('bl_lSCTrack_031817_Gap_procnew_spksort_final.mat')

rng('default');
seed = rng(13);
trivec = (lastdelaytri+1:length(D))';

[D(lastdelaytri+1:length(D)).RT] = deal([]);
inew = 1;
for i = 1:length(data)
    if data(i).inTarg == 1 && data(i).success == 1
        origidx = inew;
        goCode = data(i).params.goCode;
        rtTemp = data(i).behavrpt.saccTime - data(i).stateTransitions(2,goCode);
        D(inew+lastdelaytri).RT = rtTemp;
        inew = inew+1;
    end
end

wholetargtimevec = -200:600;

for tri = trivec(1):trivec(end)
    visburst = round(find(wholetargtimevec == 140)/dt);
    visburstpts(:,tri) = D(tri).data(1:3, visburst);
    sacconset = round((201+D(tri).RT)/dt);
    sacconsetpts(:,tri) = D(tri).data(1:3, sacconset);
    clear latentTemp
    xlabel('Factor 1')
    ylabel('Factor 2')
    zlabel('Factor 3')
end


nottrivec = lastdelaytri+1:length(D);
% automatically removes the elements that we do not want
nottrivec(trivec-lastdelaytri) = [];
visburstpts(:,nottrivec) = NaN;
sacconsetpts(:,nottrivec) = NaN;

gaptrivec = lastdelaytri+1:length(D);

gapvisburstpts = visburstpts;
gapsacconsetpts = sacconsetpts;

%% Generate Fig. 3a

%------------for VIS vs VIS------------%
BothDist=vertcat(delvisburstpts',gapvisburstpts(:,gaptrivec)');
labels=cell(length(BothDist),1);
labels(1:length(delvisburstpts))={'DelayVisual'};
labels(length(delvisburstpts)+1:end)={'GapVisual'};

cvp=cvpartition(length(BothDist),'Holdout',0.3);
idxTrain=training(cvp);
idxTest=test(cvp);

% MdLinear=fitcdiscr(BothDist,labels);
MdLinear=fitcdiscr(BothDist(idxTrain,:),labels(idxTrain,:));
K=MdLinear.Coeffs(1,2).Const;
L=MdLinear.Coeffs(1,2).Linear;

% %%Predict using test datsets
predicted=predict(MdLinear,BothDist(idxTest,:));

% how many predictions were correct out of the total predictions
correctlabel = labels(idxTest,:);

accuracy = (sum(strcmp(correctlabel, predicted))/length(correctlabel))*100;
roundedaccuracyvis = round(accuracy,2);
fprintf('%g\n', roundedaccuracyvis)

figure
hold on
h1 = scatter3(delvisburstpts(1,:),delvisburstpts(2,:),delvisburstpts(3,:),70,'MarkerFaceColor','b','MarkerEdgeColor','none');
h2 = scatter3(visburstpts(1,gaptrivec),visburstpts(2,gaptrivec), visburstpts(3,gaptrivec), 70, '*', 'MarkerEdgeColor',[0 1 1] , 'MarkerFaceColor', [0 1 1]);
f=@(x1,x2,x3) K+L(1)*x1+L(2)*x2+L(3)*x3;
fs=fimplicit3(f);
fs.FaceColor=[0.4,0.4,0.4];
fs.EdgeColor='none';
fs.FaceAlpha=0.4;
xlabel('Factor 1')
ylabel('Factor 2')
zlabel('Factor 3')

clear BothDist labels cvp idxTrain idxTest MdLinear K L predicted correctlabel accuracy roundedaccuracy xLimits yLimits zLimits f fs

%------------for Mot vs Mot------------%
BothDist=vertcat(delsacconsetpts',sacconsetpts(:,gaptrivec)');
labels=cell(length(BothDist),1);
labels(1:length(delsacconsetpts))={'DelayMotor'};
labels(length(delsacconsetpts)+1:end)={'GapMotor'};


cvp=cvpartition(length(BothDist),'Holdout',0.3);
idxTrain=training(cvp);
idxTest=test(cvp);

% MdLinear=fitcdiscr(BothDist,labels);
MdLinear=fitcdiscr(BothDist(idxTrain,:),labels(idxTrain,:));
K=MdLinear.Coeffs(1,2).Const;
L=MdLinear.Coeffs(1,2).Linear;


% %%Predict using test datsets
predicted=predict(MdLinear,BothDist(idxTest,:));

% how many predictions were correct out of the total predictions
correctlabel = labels(idxTest,:);
accuracy = (sum(strcmp(correctlabel, predicted))/length(correctlabel))*100;
roundedaccuracymot = round(accuracy,2);
fprintf('%g\n', roundedaccuracymot)

figure
hold on
h3 = scatter3(delsacconsetpts(1,:),delsacconsetpts(2,:),delsacconsetpts(3,:),70,'MarkerFaceColor','r','MarkerEdgeColor','none');
h4 = scatter3(sacconsetpts(1,gaptrivec),sacconsetpts(2,gaptrivec), sacconsetpts(3,gaptrivec), 70, '*', 'MarkerEdgeColor',[1 0.4 0.6], 'MarkerFaceColor', [1 0.4 0.6]);
f=@(x1,x2,x3) K+L(1)*x1+L(2)*x2+L(3)*x3;
fs=fimplicit3(f);
fs.FaceColor=[0.4,0.4,0.4];
fs.EdgeColor='none';
fs.FaceAlpha=0.4;
xlabel('Factor 1')
ylabel('Factor 2')
zlabel('Factor 3')




%% Generate Fig. 4a

% DO DELAY: vis vs mot
BothDist=vertcat(delvisburstpts',delsacconsetpts');
labels=cell(length(BothDist),1);
labels(1:length(delvisburstpts))={'visual'};
labels(length(delvisburstpts)+1:end)={'motor'};

cvp=cvpartition(length(BothDist),'Holdout',0.3);
idxTrain=training(cvp);
idxTest=test(cvp);

% MdLinear=fitcdiscr(BothDist,labels);
MdLinear=fitcdiscr(BothDist(idxTrain,:),labels(idxTrain,:));
K=MdLinear.Coeffs(1,2).Const;
L=MdLinear.Coeffs(1,2).Linear;

% %%Predict using test datsets
predicted=predict(MdLinear,BothDist(idxTest,:));

% how many predictions were correct out of the total predictions
correctlabel = labels(idxTest,:);

accuracy = (sum(strcmp(correctlabel, predicted))/length(correctlabel))*100;
roundedaccuracydel = round(accuracy,2);
fprintf('%g\n', roundedaccuracydel)

figure
hold on
h1 = scatter3(delvisburstpts(1,:),delvisburstpts(2,:),delvisburstpts(3,:),70,'MarkerFaceColor','b','MarkerEdgeColor','none');
h2 = scatter3(delsacconsetpts(1,:),delsacconsetpts(2,:),delsacconsetpts(3,:), 70, 'MarkerFaceColor','r','MarkerEdgeColor','none');
f=@(x1,x2,x3) K+L(1)*x1+L(2)*x2+L(3)*x3;
fs=fimplicit3(f);
fs.FaceColor=[0.4,0.4,0.4];
fs.EdgeColor='none';
fs.FaceAlpha=0.4;
xlim([-16 2])
ylim([-4 3])
zlim([-0.8 0.6])
xlabel('Factor 1')
ylabel('Factor 2')
zlabel('Factor 3')
xLimits = get(gca,'XLim');  %# Get the range of the x axis
yLimits = get(gca,'YLim');  %# Get the range of the y axis
zLimits = get(gca,'ZLim');  %# Get the range of the z axis


clear BothDist labels cvp idxTrain idxTest MdLinear K L predicted correctlabel accuracy roundedaccuracy xLimits yLimits zLimits f fs

%------------for Gap: vis vs mot------------%
BothDist=vertcat(gapvisburstpts(:,gaptrivec)',gapsacconsetpts(:,gaptrivec)');
labels=cell(length(BothDist),1);
labels(1:length(gapvisburstpts(:,gaptrivec)))={'visual'};
labels(length(gapvisburstpts(:,gaptrivec))+1:end)={'motor'};


cvp=cvpartition(length(BothDist),'Holdout',0.3);
idxTrain=training(cvp);
idxTest=test(cvp);


% MdLinear=fitcdiscr(BothDist,labels);
MdLinear=fitcdiscr(BothDist(idxTrain,:),labels(idxTrain,:));
K=MdLinear.Coeffs(1,2).Const;
L=MdLinear.Coeffs(1,2).Linear;


% %%Predict using test datsets
predicted=predict(MdLinear,BothDist(idxTest,:));

% how many predictions were correct out of the total predictions
correctlabel = labels(idxTest,:);
accuracy = (sum(strcmp(correctlabel, predicted))/length(correctlabel))*100;
roundedaccuracygap = round(accuracy,2);
fprintf('%g\n', roundedaccuracygap)

figure
hold on
h3 = scatter3(gapvisburstpts(1,gaptrivec),gapvisburstpts(2,gaptrivec), gapvisburstpts(3,gaptrivec),70,'diamond', 'MarkerEdgeColor','none', 'MarkerFaceColor', [0 1 1]);
h4 = scatter3(gapsacconsetpts(1,gaptrivec),gapsacconsetpts(2,gaptrivec), gapsacconsetpts(3,gaptrivec), 70, 'diamond', 'MarkerEdgeColor','none' , 'MarkerFaceColor', [1 0.4 0.6]);
f=@(x1,x2,x3) K+L(1)*x1+L(2)*x2+L(3)*x3;
fs=fimplicit3(f);
fs.FaceColor=[0.4,0.4,0.4];
fs.EdgeColor='none';
fs.FaceAlpha=0.4;
xlabel('Factor 1')
ylabel('Factor 2')
zlabel('Factor 3')
%% Generate Fig. 5a

BothDist=vertcat(delvisburstpts',gapvisburstpts(:,gaptrivec)',delsacconsetpts',gapsacconsetpts(:,gaptrivec)');
labels=cell(length(BothDist),1);
labels(1:length(delvisburstpts)+length(gapvisburstpts(:,gaptrivec)))={'Visual'}; % delay visual
labels(length(delvisburstpts)+length(gapvisburstpts(:,gaptrivec))+1:end)={'Motor'};


cvp=cvpartition(length(BothDist),'Holdout',0.3);
idxTrain=training(cvp);
idxTest=test(cvp);

% MdLinear=fitcdiscr(BothDist,labels);
MdLinear=fitcdiscr(BothDist(idxTrain,:),labels(idxTrain,:));
K=MdLinear.Coeffs(1,2).Const;
L=MdLinear.Coeffs(1,2).Linear;

% %%Predict using test datsets
predicted=predict(MdLinear,BothDist(idxTest,:));

% how many predictions were correct out of the total predictions
correctlabel = labels(idxTest,:);

accuracy = (sum(strcmp(correctlabel, predicted))/length(correctlabel))*100;
roundedaccuracy = round(accuracy,1);
fprintf('%g\n', roundedaccuracy)

figure;
hold on
h1 = scatter3(delvisburstpts(1,:),delvisburstpts(2,:),delvisburstpts(3,:),70,'MarkerFaceColor','b','MarkerEdgeColor','none');
h2 = scatter3(gapvisburstpts(1,gaptrivec),gapvisburstpts(2,gaptrivec), gapvisburstpts(3,gaptrivec), 70, 'diamond', 'MarkerEdgeColor','none', 'MarkerFaceColor', [0 1 1]);
h3 = scatter3(delsacconsetpts(1,:),delsacconsetpts(2,:),delsacconsetpts(3,:),70,'MarkerFaceColor','r','MarkerEdgeColor','none');
h4 = scatter3(gapsacconsetpts(1,gaptrivec),gapsacconsetpts(2,gaptrivec), gapsacconsetpts(3,gaptrivec), 70, 'diamond', 'MarkerEdgeColor','none' , 'MarkerFaceColor', [1 0.4 0.6]);
f=@(x1,x2,x3) K+L(1)*x1+L(2)*x2+L(3)*x3;
fs=fimplicit3(f);
fs.FaceColor=[0.4,0.4,0.4];
fs.EdgeColor='none';
fs.FaceAlpha=0.4;
xlabel('Factor 1')
ylabel('Factor 2')
zlabel('Factor 3')

%% Generate Fig. 5b

% LDA %
BothDist=vertcat(delvisburstpts',delsacconsetpts',gapvisburstpts(:,gaptrivec)',gapsacconsetpts(:,gaptrivec)');
labels=cell(length(BothDist),1);
labels(1:length(delvisburstpts)+length(delsacconsetpts))={'Delay'}; % delay visual
labels(length(delvisburstpts)+length(delsacconsetpts)+1:end)={'Gap'}; % gap motor

cvp=cvpartition(length(BothDist),'Holdout',0.3);
idxTrain=training(cvp);
idxTest=test(cvp);

% MdLinear=fitcdiscr(BothDist,labels);
MdLinear=fitcdiscr(BothDist(idxTrain,:),labels(idxTrain,:));
K=MdLinear.Coeffs(1,2).Const;
L=MdLinear.Coeffs(1,2).Linear;

% %%Predict using test datsets
predicted=predict(MdLinear,BothDist(idxTest,:));

% how many predictions were correct out of the total predictions
correctlabel = labels(idxTest,:);

accuracy = (sum(strcmp(correctlabel, predicted))/length(correctlabel))*100;
roundedaccuracy = round(accuracy,2);
fprintf('%g\n', roundedaccuracy)

figure
hold on
h1 = scatter3(delvisburstpts(1,:),delvisburstpts(2,:),delvisburstpts(3,:),70,'MarkerFaceColor','b','MarkerEdgeColor','none');
h2 = scatter3(gapvisburstpts(1,gaptrivec),gapvisburstpts(2,gaptrivec), gapvisburstpts(3,gaptrivec), 70, 'diamond', 'MarkerEdgeColor','none', 'MarkerFaceColor', [0 1 1]);
h3 = scatter3(delsacconsetpts(1,:),delsacconsetpts(2,:),delsacconsetpts(3,:),70,'MarkerFaceColor','r','MarkerEdgeColor','none');
h4 = scatter3(gapsacconsetpts(1,gaptrivec),gapsacconsetpts(2,gaptrivec), gapsacconsetpts(3,gaptrivec), 70, 'diamon', 'MarkerEdgeColor','none', 'MarkerFaceColor', [1 0.4 0.6]);
f=@(x1,x2,x3) K+L(1)*x1+L(2)*x2+L(3)*x3;
fs=fimplicit3(f);
fs.FaceColor=[0.4,0.4,0.4];
fs.EdgeColor='none';
fs.FaceAlpha=0.4;
xlim([-16 2])
ylim([-4 3])
zlim([-0.8 0.6])
xlabel('Factor 1')
ylabel('Factor 2')
zlabel('Factor 3')
