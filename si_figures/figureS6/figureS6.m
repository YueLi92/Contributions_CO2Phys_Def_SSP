%% Code to compare the cross-model relationship between precipitation sensitivty to def, bgc, rad

% ---------------gen legend ----
clear,clc;

% -----------------------------  subplot1, bgc vs deforestation
data = nan(8,3); % sens, se, pval
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
for mi = 1 : 8
    load(['D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\co2bgc\each_model_regression\regs_Amazon_',modelname{mi},'.ensmean.mat']);
    data(mi,1) = regs.beta(2)*100;
    data(mi,2) = regs.tstat.se(2)*100;
    data(mi,3) = regs.tstat.pval(2);
end

data2 = nan(8,3); % sens, se, pval
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
for mi = 1 : 8
    if(mi == 1 || mi == 6)
        continue;
    end
    load(['D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\lumip\each_model_regression\regs_Amazon_',modelname{mi},'.ensmean.mat']);
    data2(mi,1) = regs.beta(2)*10;
    data2(mi,2) = regs.tstat.se(2)*10;
    data2(mi,3) = regs.tstat.pval(2);
end

figure,
p1 = plot(data(:,1), data2(:,1),'.');

figure,
subplot(1,2,1),
clr = parula(22);
% clr(9,:) = [0.7 0.7 0];
for i = 1 : 3: 22      
    ps(i) = scatter(data((i-1)/3+1,1),data2((i-1)/3+1,1),160,clr(i,:),'Filled');
%     yneg = data2((i-1)/3+1,2);
%     ypos = data2((i-1)/3+1,2);
%     xneg = data((i-1)/3+1,2);
%     xpos = data((i-1)/3+1,2);
%     pe(i) = errorbar(data((i-1)/3+1,1),data2((i-1)/3+1,1),yneg,ypos,xneg,xpos, ...
%         'o',"MarkerSize",20,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',clr(i,:));
    hold on,
end
ylabel({'\Delta Precipitation (%)', '/10% deforestation'});
xlabel({'\Delta Precipitation (%)', '/100 ppm CO_2 increment (BGC)'});
legend(modelname{:})
box on
% get(gca,'position')
set(gca,'YLim',[-2.5 0],'XLim',[-2 0],'LineWidth',1.5,'FontSize',16);
set(gca,'position',[0.100    0.2000    0.3347    0.7650])
set(gcf,'position',[1000 400 1200 500])
%%
clear,clc;
figure,

% -----------------------------  subplot 1, bgc vs deforestation
data = nan(8,3); % sens, se, pval
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
for mi = 1 : 8
    load(['D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\co2bgc\each_model_regression\regs_Amazon_',modelname{mi},'.ensmean.mat']);
    data(mi,1) = regs.beta(2)*100;
    data(mi,2) = regs.tstat.se(2)*100;
    data(mi,3) = regs.tstat.pval(2);
end

data2 = nan(8,3); % sens, se, pval
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
for mi = 1 : 8
    if(mi == 1 || mi == 6)
        continue;
    end
    load(['D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\lumip\each_model_regression\regs_Amazon_',modelname{mi},'.ensmean.mat']);
    data2(mi,1) = regs.beta(2)*10;
    data2(mi,2) = regs.tstat.se(2)*10;
    data2(mi,3) = regs.tstat.pval(2);
end

% figure,
% p1 = plot(data(:,1), data2(:,1),'.');


subplot(1,3,1),
clr = parula(22);
% clr(9,:) = [0.7 0.7 0];
for i = 1 : 3: 22      
%     ps(i) = scatter(data((i-1)/3+1,1),data2((i-1)/3+1,1),120,clr(i,:),'Filled','MarkerEdgeColor',[0 0 0],'LineWidth',2);
    yneg = data2((i-1)/3+1,2);
    ypos = data2((i-1)/3+1,2);
    xneg = data((i-1)/3+1,2);
    xpos = data((i-1)/3+1,2);
    pe(i) = errorbar(data((i-1)/3+1,1),data2((i-1)/3+1,1),yneg,ypos,xneg,xpos, ...
        'o',"MarkerSize",10,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',clr(i,:),'Color','k');
    hold on,
end
data(isnan(data2)) = nan;
data2(isnan(data)) = nan;
data00 = data(:,1);
data02 = data2(:,1);
data00 = data00(~isnan(data00));
data02 = data02(~isnan(data02));
[r,p] = corrcoef(data00(:,1),data02(:,1))
ylabel({'\Delta Precipitation (%)', '/10% deforestation (DEF)'});
xlabel({'\Delta Precipitation (%)', '/100 ppm CO_2 increment (BGC)'});
% legend(modelname{:})
box on
% get(gca,'position')
set(gca,'YLim',[-3 1],'XLim',[-2 0.5],'LineWidth',1.5,'FontSize',13);
line([0 0], [-3 1],'LineStyle',':','Color','k')
line([-2 0.5], [0 0],'LineStyle',':','Color','k')
set(gca,'position',[0.1200    0.2000    0.2    0.450])

% -----------------------------  subplot 2, rad vs deforestation
data = nan(8,3); % sens, se, pval
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
for mi = 1 : 8
    load(['D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\co2rad\each_model_regression\regs_Amazon_',modelname{mi},'.ensmean.mat']);
    data(mi,1) = regs.beta(2)*100;
    data(mi,2) = regs.tstat.se(2)*100;
    data(mi,3) = regs.tstat.pval(2);
end

data2 = nan(8,3); % sens, se, pval
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
for mi = 1 : 8
    if(mi == 1 || mi == 6)
        continue;
    end
    load(['D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\lumip\each_model_regression\regs_Amazon_',modelname{mi},'.ensmean.mat']);
    data2(mi,1) = regs.beta(2)*10;
    data2(mi,2) = regs.tstat.se(2)*10;
    data2(mi,3) = regs.tstat.pval(2);
end

% figure,
% p1 = plot(data(:,1), data2(:,1),'.');


subplot(1,3,2),
clr = parula(22);
% clr(9,:) = [0.7 0.7 0];
for i = 1 : 3: 22      
%     ps(i) = scatter(data((i-1)/3+1,1),data2((i-1)/3+1,1),120,clr(i,:),'Filled','MarkerEdgeColor',[0 0 0],'LineWidth',2);
    yneg = data2((i-1)/3+1,2);
    ypos = data2((i-1)/3+1,2);
    xneg = data((i-1)/3+1,2);
    xpos = data((i-1)/3+1,2);
    pe2(i) = errorbar(data((i-1)/3+1,1),data2((i-1)/3+1,1),yneg,ypos,xneg,xpos, ...
        'o',"MarkerSize",10,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',clr(i,:),'Color','k');
    hold on,
end
data(isnan(data2)) = nan;
data2(isnan(data)) = nan;
data00 = data(:,1);
data02 = data2(:,1);
data00 = data00(~isnan(data00));
data02 = data02(~isnan(data02));
[r,p] = corrcoef(data00(:,1),data02(:,1))
ylabel({'\Delta Precipitation (%)', '/10% deforestation (DEF)'});
xlabel({'\Delta Precipitation (%)', '/100 ppm CO_2 increment (RAD)'});
% legend(modelname{:})
box on
% get(gca,'position')
set(gca,'YLim',[-3 1],'XLim',[-3 1.5],'LineWidth',1.5,'FontSize',13);
line([0 0], [-3 1],'LineStyle',':','Color','k')
line([-3 1.5], [0 0],'LineStyle',':','Color','k')
set(gca,'position',[0.420    0.2000    0.2    0.450])

% -----------------------------  subplot 3, rad vs bgc
data = nan(8,3); % sens, se, pval
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
for mi = 1 : 8
    load(['D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\co2rad\each_model_regression\regs_Amazon_',modelname{mi},'.ensmean.mat']);
    data(mi,1) = regs.beta(2)*100;
    data(mi,2) = regs.tstat.se(2)*100;
    data(mi,3) = regs.tstat.pval(2);
end

data2 = nan(8,3); % sens, se, pval
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
for mi = 1 : 8
%     if(mi == 1 || mi == 6)
%         continue;
%     end
    load(['D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\co2bgc\each_model_regression\regs_Amazon_',modelname{mi},'.ensmean.mat']);
    data2(mi,1) = regs.beta(2)*100;
    data2(mi,2) = regs.tstat.se(2)*100;
    data2(mi,3) = regs.tstat.pval(2);
end

% figure,
% p1 = plot(data(:,1), data2(:,1),'.');


subplot(1,3,3),
clr = parula(22);
% clr(9,:) = [0.7 0.7 0];
for i = 1 : 3: 22      
%     ps(i) = scatter(data((i-1)/3+1,1),data2((i-1)/3+1,1),120,clr(i,:),'Filled','MarkerEdgeColor',[0 0 0],'LineWidth',2);
    yneg = data2((i-1)/3+1,2);
    ypos = data2((i-1)/3+1,2);
    xneg = data((i-1)/3+1,2);
    xpos = data((i-1)/3+1,2);
    pe3(i) = errorbar(data((i-1)/3+1,1),data2((i-1)/3+1,1),yneg,ypos,xneg,xpos, ...
        'o',"MarkerSize",10,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',clr(i,:),'Color','k');
    hold on,
end
data(isnan(data2)) = nan;
data2(isnan(data)) = nan;
data00 = data(:,1);
data02 = data2(:,1);
data00 = data00(~isnan(data00));
data02 = data02(~isnan(data02));
[r,p] = corrcoef(data00(:,1),data02(:,1))
ylabel({'\Delta Precipitation (%)', '/100 ppm CO_2 increment (BGC)'});
xlabel({'\Delta Precipitation (%)', '/100 ppm CO_2 increment (RAD)'});
% legend(modelname{:})
box on
% get(gca,'position')
set(gca,'YLim',[-2 0.5],'XLim',[-3 1.5],'LineWidth',1.5,'FontSize',13);
line([0 0], [-2 0.5],'LineStyle',':','Color','k')
line([-3 1.5], [0 0],'LineStyle',':','Color','k')
set(gca,'position',[0.740    0.2000    0.2    0.450])

set(gcf,'position',[1000 400 1200 500])
