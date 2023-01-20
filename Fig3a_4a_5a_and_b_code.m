%%
load('data_3a_4a_5ab.mat')

delvisburstpts = data_2a{1};
delsacconsetpts = data_2a{2};
gapvisburstpts = data_2a{3};
gapsacconsetpts = data_2a{4};
gaptrivec = data_2a{5};


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
h2 = scatter3(gapvisburstpts(1,gaptrivec),gapvisburstpts(2,gaptrivec), gapvisburstpts(3,gaptrivec), 70, 'diamond', 'MarkerEdgeColor',[0 1 1] , 'MarkerFaceColor', [0 1 1]);
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
BothDist=vertcat(delsacconsetpts',gapsacconsetpts(:,gaptrivec)');
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
h4 = scatter3(gapsacconsetpts(1,gaptrivec),gapsacconsetpts(2,gaptrivec), gapsacconsetpts(3,gaptrivec), 70, 'diamond', 'MarkerEdgeColor',[1 0.4 0.6], 'MarkerFaceColor', [1 0.4 0.6]);
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
