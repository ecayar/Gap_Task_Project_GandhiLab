%% generate Fig 5d

load('orthoangles_LDA.mat')
for i = 1:length(orthoangle)
    if orthoangle(i) > 90
        new_orthoangle(i) = 180 - orthoangle(i);
    else
        new_orthoangle(i) = orthoangle(i);
    end
end

figure
histogram(new_orthoangle,'BinEdges',0:10:90)
hold on
xline(median(new_orthoangle),'--')
xlim([0 90])
xlabel('angle between planes (degrees)')
ylabel('count')