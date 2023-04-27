%% figure2
% Rainfall attribution - 2
% No CO2-radiation effect
clear,clc;
load D:\Study\landuse_climate_SSP\2021.04.25.co2_deforest_ssp\data_deforestation_co2.mat datadef dataco2

load D:\Study\landuse_climate_SSP\2021.05.12.major_figures\l1.major_figure1\regs_lumip_temperature_Amazon.mat
regs_def = regs;
% load D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\co2rad\regs_data_rainfall_Amazon.mat
% regs_rad = regs;
load D:\Study\landuse_climate_SSP\2021.05.12.major_figures\l1.major_figure1\regs_bgc_temperature_Amazon.mat
regs_bgc = regs;

amapr = ncread('D:\Study\rainfall_deforestation\2020.05.12.physics_bar\l1.prepare_data\tas_Amazon_congo_Asa_piControl_lst30lumip.nc','amatas');
amafutpr = ncread('D:\Study\landuse_climate_SSP\2021.04.27.ssp_rainfall\tas_ssp_fut.nc','tas_Ama');
rainclim = nanmean(mean(amapr(:,1,:),1),3);
ssprain = (nanmean(amafutpr,3) - rainclim);

% residue = ssprain - ((datadef(:,k)*-1*regs_def.beta(2)) + (dataco2(:,k)*regs_rad.beta(2)) + ...
%     (dataco2(:,k)*regs_bgc.beta(2)));

sspname = {'SSP126','SSP245','SSP370','SSP434','SSP585'};
figure,
for k = 1 : 5
    subplot(5,1,k),
    if(k==4)
        continue;
    end
    defd = (datadef(:,k)*-1*regs_def.beta(2))./ssprain(:,k)*100
    co2d = (dataco2(:,k)*regs_bgc.beta(2))./ssprain(:,k)*100
    
    b(k) = bar([1:4]'+0.1,datadef(:,k)*-1*regs_def.beta(2),0.15,'FaceAlpha',0.6,...
        'FaceColor',[107 212 215]./255);
    grid on
    if(k == 5 || k ==3)
        set(gca,'YLim',[0 8],'XLim',[0.1 4.9],'GridLineStyle',':',...
            'XTick',[1:4],'XTickLabel',{'2021-2040','2041-2060','2061-2081','2081-2100'})
        for kk = 1 : 4
            text(kk-0.15,6,[num2str(round(defd(kk)+co2d(kk))),'%'],'color',[255 109 128]./255);
        end
    else
        set(gca,'YLim',[0 5],'XLim',[0.1 4.9],'GridLineStyle',':',...
            'XTick',[1:4],'XTickLabel',{'2021-2040','2041-2060','2061-2081','2081-2100'})
        for kk = 1 : 4
            text(kk-0.15,3.8,[num2str(round(defd(kk)+co2d(kk))),'%'],'color',[255 109 128]./255);
        end
    end
    if(k ==3)
        ylabel('\Delta Temperature (^{o}C)','FontSize',10)
    end
    if(k == 5 || k ==3)
        text(0.2,6,sspname{k});
    else
        text(0.2,3.8,sspname{k});
    end
%     yyaxis right
%     hold on,
%     bb(k) = bar([1:4]'-0.1,dataco2(:,k)*regs_rad.beta(2),0.15,'FaceAlpha',0.6,...
%         'FaceColor',[255 109 128]./255);
%     grid on
    
    hold on,
    bbb(k) = bar([1:4]'-0.1,dataco2(:,k)*regs_bgc.beta(2),0.15,'FaceAlpha',0.6,...
        'FaceColor',[246 183 112]./255);
    grid on
    
    hold on,
    bbbb(k) = bar([1:4]'+0.3,ssprain(:,k),0.15,'FaceAlpha',0.6,...
        'FaceColor',[187 205 191]./255);
    grid on

    if(k ==5)
%         ylabel('\Delta CO_2 (ppm)','FontSize',13)
        legend({'Deforestation','CO_2 BGC','SSP'},'NumColumns',4)                
    end
end


 %% figure2 - deforest new color
% Rainfall attribution - 2
% No CO2-radiation effect
clear,clc;
load D:\Study\landuse_climate_SSP\2021.04.25.co2_deforest_ssp\data_deforestation_co2.mat datadef dataco2

load D:\Study\landuse_climate_SSP\2021.05.12.major_figures\l1.major_figure1\regs_lumip_temperature_Amazon.mat
regs_def = regs;
% load D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\co2rad\regs_data_rainfall_Amazon.mat
% regs_rad = regs;
load D:\Study\landuse_climate_SSP\2021.05.12.major_figures\l1.major_figure1\regs_bgc_temperature_Amazon.mat
regs_bgc = regs;

amapr = ncread('D:\Study\rainfall_deforestation\2020.05.12.physics_bar\l1.prepare_data\tas_Amazon_congo_Asa_piControl_lst30lumip.nc','amatas');
amafutpr = ncread('D:\Study\landuse_climate_SSP\2021.04.27.ssp_rainfall\tas_ssp_fut.nc','tas_Ama');
rainclim = nanmean(mean(amapr(:,1,:),1),3);
ssprain = (nanmean(amafutpr,3) - rainclim);

% residue = ssprain - ((datadef(:,k)*-1*regs_def.beta(2)) + (dataco2(:,k)*regs_rad.beta(2)) + ...
%     (dataco2(:,k)*regs_bgc.beta(2)));

sspname = {'SSP126','SSP245','SSP370','SSP434','SSP585'};
figure,
for k = 1 : 5
    subplot(5,1,k),
    if(k==4)
        continue;
    end
    defd = (datadef(:,k)*-1*regs_def.beta(2))./ssprain(:,k)*100
    co2d = (dataco2(:,k)*regs_bgc.beta(2))./ssprain(:,k)*100
    
%     b(k) = bar([1:4]'+0.1,datadef(:,k)*-1*regs_def.beta(2),0.15,'FaceAlpha',0.6,...
%         'FaceColor',[107 212 215]./255);
    b(k) = bar([1:4]'+0.1,datadef(:,k)*-1*regs_def.beta(2),0.15,'FaceAlpha',0.6,...
        'FaceColor',[150 75 0]./255);
    grid on
    if(k == 5 || k ==3)
        set(gca,'YLim',[0 8],'XLim',[0.1 4.9],'GridLineStyle',':',...
            'XTick',[1:4],'XTickLabel',{'2021-2040','2041-2060','2061-2081','2081-2100'})
        for kk = 1 : 4
            text(kk-0.15,6,[num2str(round(defd(kk)+co2d(kk))),'%'],'color',[255 109 128]./255);
        end
    else
        set(gca,'YLim',[0 5],'XLim',[0.1 4.9],'GridLineStyle',':',...
            'XTick',[1:4],'XTickLabel',{'2021-2040','2041-2060','2061-2081','2081-2100'})
        for kk = 1 : 4
            text(kk-0.15,3.8,[num2str(round(defd(kk)+co2d(kk))),'%'],'color',[255 109 128]./255);
        end
    end
    if(k ==3)
        ylabel('\Delta Temperature (^{o}C)','FontSize',13)
    end
    if(k == 5 || k ==3)
        text(0.2,6,sspname{k});
    else
        text(0.2,3.8,sspname{k});
    end
%     yyaxis right
%     hold on,
%     bb(k) = bar([1:4]'-0.1,dataco2(:,k)*regs_rad.beta(2),0.15,'FaceAlpha',0.6,...
%         'FaceColor',[255 109 128]./255);
%     grid on
    
    hold on,
    bbb(k) = bar([1:4]'-0.1,dataco2(:,k)*regs_bgc.beta(2),0.15,'FaceAlpha',0.6,...
        'FaceColor',[246 183 112]./255);
    grid on
    
    hold on,
    bbbb(k) = bar([1:4]'+0.3,ssprain(:,k),0.15,'FaceAlpha',0.6,...
        'FaceColor',[187 205 191]./255);
    grid on

    if(k ==5)
%         ylabel('\Delta CO_2 (ppm)','FontSize',13)
        ll = legend({'Deforestation','CO_2 BGC','SSP'},'NumColumns',4);
        set(ll,'FontSize',10);
    end
end
set(gcf,'position',[ 1000         218         560         720])



 %% figure2 - deforest new color +  add each model regression result
% Rainfall attribution - 2
% No CO2-radiation effect
clear,clc;

% -------------------- compute each model's contribution & ssp uncertainty
datach_def = nan(4,5,8);
datach_co2 = nan(4,5,8);
datach_ssp = nan(4,5,8);
modname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
load D:\Study\landuse_climate_SSP\2021.04.25.co2_deforest_ssp\data_deforestation_co2.mat datadef dataco2
for k = 1 : 5
    if(k == 4)
        continue;
    end
    for mi = 1 : 8
        if(mi == 1 || mi == 6)
            continue;
        end
        load(['D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\lumip\each_model_regression\regs_tair_Amazon_',modname{mi},'.ensmean.mat']);
        datach_def(:,k,mi) = datadef(:,k)*-1*regs.beta(2);
    end
end

for k = 1 : 5
    if(k == 4)
        continue;
    end
    for mi = 1 : 8        
        load(['D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\co2bgc\each_model_regression\regs_tair_Amazon_',modname{mi},'.ensmean.mat']);
        datach_co2(:,k,mi) = dataco2(:,k)*regs.beta(2);
    end
end
amapr = ncread('D:\Study\rainfall_deforestation\2020.05.12.physics_bar\l1.prepare_data\tas_Amazon_congo_Asa_piControl_lst30lumip.nc','amatas');
amafutpr = ncread('D:\Study\landuse_climate_SSP\2021.04.27.ssp_rainfall\tas_ssp_fut.nc','tas_Ama');
rainclim = reshape(mean(amapr(:,1,:),1),8,1);
for mi = 1 : 8
    datach_ssp(:,:,mi) = amafutpr(:,:,mi) - rainclim(mi);
end
datach_defstd = nanstd(datach_def,0,3);
datach_co2std = nanstd(datach_co2,0,3);
datach_sspstd = nanstd(datach_ssp,0,3);


% -------------------- compute the multi model mean & draw the plot
load D:\Study\landuse_climate_SSP\2021.04.25.co2_deforest_ssp\data_deforestation_co2.mat datadef dataco2

load D:\Study\landuse_climate_SSP\2021.05.12.major_figures\l1.major_figure1\regs_lumip_temperature_Amazon.mat
regs_def = regs;
% load D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\co2rad\regs_data_rainfall_Amazon.mat
% regs_rad = regs;
load D:\Study\landuse_climate_SSP\2021.05.12.major_figures\l1.major_figure1\regs_bgc_temperature_Amazon.mat
regs_bgc = regs;

amapr = ncread('D:\Study\rainfall_deforestation\2020.05.12.physics_bar\l1.prepare_data\tas_Amazon_congo_Asa_piControl_lst30lumip.nc','amatas');
amafutpr = ncread('D:\Study\landuse_climate_SSP\2021.04.27.ssp_rainfall\tas_ssp_fut.nc','tas_Ama');
rainclim = nanmean(mean(amapr(:,1,:),1),3);
ssprain = (nanmean(amafutpr,3) - rainclim);

% residue = ssprain - ((datadef(:,k)*-1*regs_def.beta(2)) + (dataco2(:,k)*regs_rad.beta(2)) + ...
%     (dataco2(:,k)*regs_bgc.beta(2)));

sspname = {'SSP1-2.6','SSP2-4.5','SSP3-7.0','SSP4-3.4','SSP5-8.5'};
figure,
for k = 1 : 5
    subplot(5,1,k),
    if(k==4)
        continue;
    end
    defd = (datadef(:,k)*-1*regs_def.beta(2))./ssprain(:,k)*100
    co2d = (dataco2(:,k)*regs_bgc.beta(2))./ssprain(:,k)*100
    
%     b(k) = bar([1:4]'+0.1,datadef(:,k)*-1*regs_def.beta(2),0.15,'FaceAlpha',0.6,...
%         'FaceColor',[107 212 215]./255);
    b(k) = bar([1:4]'+0.1,datadef(:,k)*-1*regs_def.beta(2),0.15,'FaceAlpha',0.6,...
        'FaceColor',[150 75 0]./255);
    hold on,
    b0(k) = errorbar([1:4]'+0.1,datadef(:,k)*-1*regs_def.beta(2),[0 0 0 0]',datach_defstd(:,k),'LineStyle','none','Color',[0.4 0.4 0.6]);
    
    grid on
    if(k == 5 || k ==3)
        set(gca,'YLim',[0 10],'XLim',[0.1 4.9],'GridLineStyle',':',...
            'XTick',[1:4],'XTickLabel',{'2021-2040','2041-2060','2061-2081','2081-2100'})
        for kk = 1 : 4
            text(kk-0.15,3,[num2str(round(defd(kk)+co2d(kk))),'%'],'color',[255 109 128]./255);
        end
    else
        set(gca,'YLim',[0 6],'XLim',[0.1 4.9],'GridLineStyle',':',...
            'XTick',[1:4],'XTickLabel',{'2021-2040','2041-2060','2061-2081','2081-2100'})
        for kk = 1 : 4
            text(kk-0.15,2,[num2str(round(defd(kk)+co2d(kk))),'%'],'color',[255 109 128]./255);
        end
    end
    if(k ==3)
        ylabel('\Delta Temperature (^{o}C)','FontSize',13)
    end
    if(k == 5 || k ==3)
        text(0.2,8,sspname{k});
    else
        text(0.2,5,sspname{k});
    end
%     yyaxis right
%     hold on,
%     bb(k) = bar([1:4]'-0.1,dataco2(:,k)*regs_rad.beta(2),0.15,'FaceAlpha',0.6,...
%         'FaceColor',[255 109 128]./255);
%     grid on
    
    hold on,
    bbb(k) = bar([1:4]'-0.1,dataco2(:,k)*regs_bgc.beta(2),0.15,'FaceAlpha',0.6,...
        'FaceColor',[246 183 112]./255);
    hold on,
    bbb0(k) = errorbar([1:4]'-0.1,dataco2(:,k)*regs_bgc.beta(2),[0 0 0 0]',datach_co2std(:,k),'LineStyle','none','Color',[0.4 0.4 0.6]);
    grid on
    
    hold on,
    bbbb(k) = bar([1:4]'+0.3,ssprain(:,k),0.15,'FaceAlpha',0.6,...
        'FaceColor',[187 205 191]./255);
    hold on,
    bbbb0(k) = errorbar([1:4]'+0.3,ssprain(:,k),[0 0 0 0]',datach_sspstd(:,k),'LineStyle','none','Color',[0.4 0.4 0.6]);
    grid on

%     if(k ==5)
% %         ylabel('\Delta CO_2 (ppm)','FontSize',13)
%         ll = legend({'Deforestation','CO_2 BGC','SSP'},'NumColumns',4);
%         set(ll,'FontSize',10);
%     end
end
set(gcf,'position',[ 1000         218         560         720])

 
