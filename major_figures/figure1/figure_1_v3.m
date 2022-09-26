%%
clear,clc;
load D:\Study\landuse_climate_SSP\2021.04.25.co2_deforest_ssp\data_deforestation_co2.mat
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
clclr = [ 0 0 0.99 0.95; ...
    0 0.89 0 0.95; ...
    0.99 0.40 0.53 0.95; ...
    0 0.49 0.89 0.95; ...
    0.89 0 0 0.95];

% ----------------  CO2BGC -precip ------------------
figure('position',[ 337          -25        1000         840]),
subplot(3,2,1)
load D:\Study\landuse_climate_SSP\2021.05.12.major_figures\l1.major_figure1\PRE_CO2BGC.ensmean.mat precip co2
path = 'D:\Study\rainfall_deforestation\2020.05.12.physics_bar\l1.prepare_data\';
% deforest-globe (30yr, ann-wet-dry, models)
% for q (30yr, 1000-925_850-700_700-500, ann-wet-dry, models)
% obsprama = ncread([path,'pr_GPCC_region.nc'],'prama')/30;

for vi = 1 : 1
    precip_crv = precip(:,:,vi);
    precipmean = nanmean(precip_crv,2);
    precipstd = std(precip_crv,0,2,'omitnan');
    
%     treecvmean = reshape(treecv_crv,150*8,1);
%     precipmean = reshape(precip_crv,150*8,1);
    
    % plot
%     yy1 = movmean(precip_crv,11,1);
    yy1 = precipmean;
    xx1 = co2;
    x1 = [280 : 1 : 1200]';
    regs = regstats(yy1,xx1);
    save('regs_bgc_rainfall_Amazon.mat','regs');
    
    x11 = xx1(~isnan(xx1));
    y11 = yy1(~isnan(yy1));
    ff = fit(x11,y11,'poly1');
    ppp = predint(ff, x1, 0.95, 'observation','off');
    ppp2 = predint(ff, x1, 0.95, 'functional','off');
    vtc = [x1 ppp(:,1); flipud(x1) flipud(ppp(:,2))];
    vtc2 = [x1 ppp2(:,1); flipud(x1) flipud(ppp2(:,2))];
    lenv = length(ppp(:,1));
    fac = [1 2 lenv*2-1 lenv*2];
    for i = 2 : lenv-1
        fac = [fac ; i i+1 lenv*2-i lenv*2-i+1];
    end
%     xt = [x1; flipud(x1)]';a
%     yt = [ppp(:,1); ppp(:,2)]';
%     p3 = patch('Faces',fac,'Vertices',vtc,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,
%     p4 = patch('Faces',fac,'Vertices',vtc2,'FaceColor',[0.75 0.75 0.75],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,

    
%     p1 = plot(xx1,yy1,'o','LineWidth',1.5,'MarkerFaceColor',[175 194 225 51]./255,...
%         'MarkerEdgeColor',[0 0 255 51]./255,'MarkerSize',7,'LineWidth',0.5);
    p1 = scatter(xx1, yy1, 40,'o','filled','LineWidth',0.5,'MarkerFaceColor',[175 194 225]./255,...
        'MarkerEdgeColor',[0 0 255]./255,'MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5);
    box on
    hold on,
    alpha(p1,0.5)
    y1 = x1*regs.beta(2)+regs.beta(1);
    p2 = plot(x1,y1,'k--','LineWidth',1.5);
    
    % add current & future co2 concentration
    % 1995_2014 mean: 378.19ppm, 2081:2100(ssp3rcp7) mean: 792.64
    hold on,
%     ylm = get(gca,'YLim');
%     line([378.19 378.19],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.3 0.8 0.83 0.95],'LineStyle','--')
%     line([792.64 792.64],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.99 0.40 0.53 0.95],'LineStyle','--')
%     for kk = 1 : 5
%         xx1 = dataco2(end,kk)+280;
%         line([xx1 xx1], [ylm(1) ylm(2)],...
%             'LineWidth',1.5,'Color',clclr(kk,:),'LineStyle','--');
%     end
    ylm = [88 104];
    if(vi == 1)
        text(650,101,{[num2str(round(regs.beta(2)*100*100)/100),'¡À',num2str(round(regs.tstat.se(2)*100*100)/100),' %, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 100 ppm CO_2 increment'...
            },'FontSize',10,'BackgroundColor','none','EdgeColor','none')
    elseif(vi == 2)
        text(1,92,{'-0.12¡À0.03 % (-260¡À65 mm yr^{-1}) ';' per 1% deforestation'...
            },'FontSize',13)
    else
        text(1,92,{'-0.12¡À0.03 % (-260¡À65 mm yr^{-1}) ';' per 1% deforestation'...
            },'FontSize',13)
    end
    text(110, ylm(2), 'a','FontSize',16,'FontWeight','bold');

%     xlabel('CO_2 (ppm)')
    ylabel('Precipitation (%)')    
    set(gca,'XLim',[250 1200],'YLim',[ylm(1) ylm(2)],'FontSize',12);

end



% ----------------  LUMIP -rainfall ------------------
load D:\Study\landuse_climate_SSP\2021.05.12.major_figures\l1.major_figure1\PRE_LUMIP.ensmean.mat precip treecv
path = 'D:\Study\rainfall_deforestation\2020.05.12.physics_bar\l1.prepare_data\';
% deforest-globe (30yr, ann-wet-dry, models)
% for q (30yr, 1000-925_850-700_700-500, ann-wet-dry, models)
% obsprama = ncread([path,'pr_GPCC_region.nc'],'prama')/30;
tcval = nan(4,3);
tcval(:,1) = ncread('D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\extract_slice\treeFrac_hist_future.nc','treeFrac_Ama');
tcval(:,2) = ncread('D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\extract_slice\treeFrac_hist_future.nc','treeFrac_Con');
tcval(:,3) = ncread('D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\extract_slice\treeFrac_hist_future.nc','treeFrac_Asa');

subplot(3,2,2)
for vi = 1 : 1
    precip_crv = precip(:,:,vi);
    treecv_crv = treecv(:,:,vi);
    precip_crv(isnan(treecv_crv)) = nan;
    precip_crv(51:150,:) = nan;
    treecv_crv(51:150,:) = nan;
    
    treecvmean = nanmean(treecv_crv,2);
    precipmean = nanmean(precip_crv,2);
    treecvstd = std(treecv_crv,0,2,'omitnan');
    precipstd = std(precip_crv,0,2,'omitnan');
    
    yy1 = precipmean;
    xx1 = treecvmean;
    x1 = [1 : 1 : 44]';
    regs = regstats(yy1,xx1);
    save('regs_lumip_rainfall_Amazon.mat','regs');
    
    x11 = xx1(~isnan(xx1));
    y11 = yy1(~isnan(yy1));
    ff = fit(x11,y11,'poly1');
    ppp = predint(ff, x1, 0.95, 'observation','off');
    ppp2 = predint(ff, x1, 0.95, 'functional','off');
    vtc = [x1 ppp(:,1); flipud(x1) flipud(ppp(:,2))];
    vtc2 = [x1 ppp2(:,1); flipud(x1) flipud(ppp2(:,2))];
    lenv = length(ppp(:,1));
    fac = [1 2 lenv*2-1 lenv*2];
    for i = 2 : lenv-1
        fac = [fac ; i i+1 lenv*2-i lenv*2-i+1];
    end

%     p3 = patch('Faces',fac,'Vertices',vtc,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,
%     p4 = patch('Faces',fac,'Vertices',vtc2,'FaceColor',[0.75 0.75 0.75],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,

    
%     p1 = plot(xx1,yy1,'o','LineWidth',1.5,'MarkerFaceColor',[0.6 0.6 0.6],...
%         'MarkerEdgeColor','none','MarkerSize',7);
    p1 = scatter(xx1, yy1, 40,'o','filled','LineWidth',0.5,'MarkerFaceColor',[175 194 225]./255,...
        'MarkerEdgeColor',[0 0 255]./255,'MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5);
    box on
    hold on,
    y1 = x1*regs.beta(2)+regs.beta(1);
    p2 = plot(x1,y1,'k--','LineWidth',1.5);
    
    % add current & future deforestation rate
    hold on,
    ylm = [88 104];
%     line([(tcval(2,1)-tcval(1,1))*-1 (tcval(2,1)-tcval(1,1))*-1],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.3 0.8 0.83 0.95],'LineStyle','--')
%     line([(tcval(4,1)-tcval(1,1))*-1 (tcval(4,1)-tcval(1,1))*-1],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.99 0.40 0.53 0.95],'LineStyle','--')
%     for kk = 1 : 5
%         xx1 = datadef(end,kk)*-1;
%         line([xx1 xx1], [ylm(1) ylm(2)],...
%             'LineWidth',1.5,'Color',clclr(kk,:),'LineStyle','--');
%     end
    
    if(vi == 1)
        text(24,101.5,{[num2str(round(regs.beta(2)*10*10)/10),'¡À',num2str(round(regs.tstat.se(2)*10*10)/10),' %, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 10% deforestation'...
            },'FontSize',10)
    elseif(vi == 2)
        text(20,104.5,{[num2str(round(regs.beta(2)*10*10)/10),'¡À',num2str(round(regs.tstat.se(2)*10*10)/10),' %, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 10% deforestation'...
            },'FontSize',13)
    else
        text(20,104.5,{[num2str(round(regs.beta(2)*10*10)/10),'¡À',num2str(round(regs.tstat.se(2)*10*10)/10),' %, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 10% deforestation'...
            },'FontSize',13)
    end
    text(-4., ylm(2), 'b','FontSize',16,'FontWeight','bold');
    
%     xlabel('Deforestation (%)')
%     ylabel('Annual rainfall (%)')
    set(gca,'XLim',[0 45],'YLim',[ylm(1) ylm(2)],'FontSize',12);

end


% ----------------  CO2BGC -RH ------------------
subplot(3,2,3)
load D:\Study\landuse_climate_SSP\2021.05.25.rh_analysis\co2bgc\RH_CO2BGC.ensmean.mat relhumid relclim co2
path = 'D:\Study\rainfall_deforestation\2020.05.12.physics_bar\l1.prepare_data\';
% deforest-globe (30yr, ann-wet-dry, models)
% for q (30yr, 1000-925_850-700_700-500, ann-wet-dry, models)
% obsprama = ncread([path,'pr_GPCC_region.nc'],'prama')/30;

for vi = 1 : 1
    precip_crv = relhumid(:,:,vi);
    precipmean = nanmean(precip_crv,2)+relclim(vi);    
    precipstd = std(precip_crv,0,2,'omitnan');
    
%     treecvmean = reshape(treecv_crv,150*8,1);
%     precipmean = reshape(precip_crv,150*8,1);
    
    % plot
%     yy1 = movmean(precip_crv,11,1);
    yy1 = precipmean;
    xx1 = co2;
    x1 = [280 : 1 : 1200]';
    regs = regstats(yy1,xx1);
    save('regs_bgc_relhumid_Amazon.mat','regs');
    
    x11 = xx1(~isnan(xx1));
    y11 = yy1(~isnan(yy1));
    ff = fit(x11,y11,'poly1');
    ppp = predint(ff, x1, 0.95, 'observation','off');
    ppp2 = predint(ff, x1, 0.95, 'functional','off');
    vtc = [x1 ppp(:,1); flipud(x1) flipud(ppp(:,2))];
    vtc2 = [x1 ppp2(:,1); flipud(x1) flipud(ppp2(:,2))];
    lenv = length(ppp(:,1));
    fac = [1 2 lenv*2-1 lenv*2];
    for i = 2 : lenv-1
        fac = [fac ; i i+1 lenv*2-i lenv*2-i+1];
    end
%     xt = [x1; flipud(x1)]';a
%     yt = [ppp(:,1); ppp(:,2)]';
%     p3 = patch('Faces',fac,'Vertices',vtc,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,
%     p4 = patch('Faces',fac,'Vertices',vtc2,'FaceColor',[0.75 0.75 0.75],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,

    
%     p1 = plot(xx1,yy1,'o','LineWidth',1.5,'MarkerFaceColor',[0.6 0.6 0.6],...
%         'MarkerEdgeColor','none','MarkerSize',7);
    p1 = scatter(xx1, yy1, 40,'o','filled','LineWidth',0.5,'MarkerFaceColor',[146 255 142]./255,...
        'MarkerEdgeColor',[135 184 123]./255,'MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5);
    box on
    hold on,
    y1 = x1*regs.beta(2)+regs.beta(1);
    p2 = plot(x1,y1,'k--','LineWidth',1.5);
    
    % add current & future co2 concentration
    % 1995_2014 mean: 378.19ppm, 2081:2100(ssp3rcp7) mean: 792.64
    hold on,
%     ylm = get(gca,'YLim');
    ylm = [70 81];
%     line([378.19 378.19],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.3 0.8 0.83 0.95],'LineStyle','--')
%     line([792.64 792.64],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.99 0.40 0.53 0.95],'LineStyle','--')
%     for kk = 1 : 5
%         xx1 = dataco2(end,kk)+280;
%         line([xx1 xx1], [ylm(1) ylm(2)],...
%             'LineWidth',1.5,'Color',clclr(kk,:),'LineStyle','--');
%     end
    
    if(vi == 1)
        text(650,79,{[num2str(round(regs.beta(2)*100*100)/100),'¡À',num2str(round(regs.tstat.se(2)*100*100)/100),' %, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 100 ppm CO_2 increment'...
            },'FontSize',10,'BackgroundColor','none','EdgeColor','none')
    elseif(vi == 2)
        text(1,92,{'-0.12¡À0.03 % (-260¡À65 mm yr^{-1}) ';' per 1% deforestation'...
            },'FontSize',13)
    else
        text(1,92,{'-0.12¡À0.03 % (-260¡À65 mm yr^{-1}) ';' per 1% deforestation'...
            },'FontSize',13)
    end
    text(110, ylm(2), 'c','FontSize',16,'FontWeight','bold');

%     xlabel('CO_2 (ppm)')
    ylabel('Relative Humidity (%)')
    set(gca,'XLim',[250 1200],'YLim',[ylm(1) ylm(2)],'FontSize',12);

end


% ----------------  LUMIP -RH ------------------
load D:\Study\landuse_climate_SSP\2021.05.25.rh_analysis\lumip\RH_LUMIP.ensmean.mat relhumid relclim treecv
path = 'D:\Study\rainfall_deforestation\2020.05.12.physics_bar\l1.prepare_data\';
% deforest-globe (30yr, ann-wet-dry, models)
% for q (30yr, 1000-925_850-700_700-500, ann-wet-dry, models)
% obsprama = ncread([path,'pr_GPCC_region.nc'],'prama')/30;
tcval = nan(4,3);
tcval(:,1) = ncread('D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\extract_slice\treeFrac_hist_future.nc','treeFrac_Ama');
tcval(:,2) = ncread('D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\extract_slice\treeFrac_hist_future.nc','treeFrac_Con');
tcval(:,3) = ncread('D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\extract_slice\treeFrac_hist_future.nc','treeFrac_Asa');

subplot(3,2,4)
for vi = 1 : 1
    precip_crv = relhumid(:,:,vi);
    treecv_crv = treecv(:,:,vi);
    precip_crv(isnan(treecv_crv)) = nan;
    precip_crv(51:150,:) = nan;
    treecv_crv(51:150,:) = nan;
    
    treecvmean = nanmean(treecv_crv,2);
    precipmean = nanmean(precip_crv,2)+relclim(vi);
    treecvstd = std(treecv_crv,0,2,'omitnan');
    precipstd = std(precip_crv,0,2,'omitnan');
    
    yy1 = precipmean;
    xx1 = treecvmean;
    x1 = [1 : 1 : 44]';
    regs = regstats(yy1,xx1);
    save('regs_lumip_relhumid_Amazon.mat','regs');
    
    x11 = xx1(~isnan(xx1));
    y11 = yy1(~isnan(yy1));
    ff = fit(x11,y11,'poly1');
    ppp = predint(ff, x1, 0.95, 'observation','off');
    ppp2 = predint(ff, x1, 0.95, 'functional','off');
    vtc = [x1 ppp(:,1); flipud(x1) flipud(ppp(:,2))];
    vtc2 = [x1 ppp2(:,1); flipud(x1) flipud(ppp2(:,2))];
    lenv = length(ppp(:,1));
    fac = [1 2 lenv*2-1 lenv*2];
    for i = 2 : lenv-1
        fac = [fac ; i i+1 lenv*2-i lenv*2-i+1];
    end

%     p3 = patch('Faces',fac,'Vertices',vtc,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,
%     p4 = patch('Faces',fac,'Vertices',vtc2,'FaceColor',[0.75 0.75 0.75],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,

    
%     p1 = plot(xx1,yy1,'o','LineWidth',1.5,'MarkerFaceColor',[0.6 0.6 0.6],...
%         'MarkerEdgeColor','none','MarkerSize',7);
    p1 = scatter(xx1, yy1, 40,'o','filled','LineWidth',0.5,'MarkerFaceColor',[146 255 142]./255,...
        'MarkerEdgeColor',[135 184 123]./255,'MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5);
    box on
    hold on,
    y1 = x1*regs.beta(2)+regs.beta(1);
    p2 = plot(x1,y1,'k--','LineWidth',1.5);
    
    % add current & future deforestation rate
    hold on,
    ylm = [74.5 81];
%     line([(tcval(2,1)-tcval(1,1))*-1 (tcval(2,1)-tcval(1,1))*-1],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.3 0.8 0.83 0.95],'LineStyle','--')
%     line([(tcval(4,1)-tcval(1,1))*-1 (tcval(4,1)-tcval(1,1))*-1],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.99 0.40 0.53 0.95],'LineStyle','--')
%     for kk = 1 : 5
%         xx1 = datadef(end,kk)*-1;
%         line([xx1 xx1], [ylm(1) ylm(2)],...
%             'LineWidth',1.5,'Color',clclr(kk,:),'LineStyle','--');
%     end
    
    if(vi == 1)
        text(25,80.,{[num2str(round(regs.beta(2)*10*10)/10),'¡À',num2str(round(regs.tstat.se(2)*10*10)/10),' %, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 10% deforestation'...
            },'FontSize',10)
    elseif(vi == 2)
        text(20,104.5,{[num2str(round(regs.beta(2)*10*10)/10),'¡À',num2str(round(regs.tstat.se(2)*10*10)/10),' %, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 10% deforestation'...
            },'FontSize',13)
    else
        text(20,104.5,{[num2str(round(regs.beta(2)*10*10)/10),'¡À',num2str(round(regs.tstat.se(2)*10*10)/10),' %, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 10% deforestation'...
            },'FontSize',13)
    end
    text(-4., ylm(2), 'd','FontSize',16,'FontWeight','bold');
    
%     xlabel('Deforestation (%)')
%     ylabel('Annual rainfall (%)')
    set(gca,'XLim',[0 45],'YLim',[ylm(1) ylm(2)],'FontSize',12);

end


% ----------------  CO2BGC -temp ------------------
subplot(3,2,5)
load D:\Study\landuse_climate_SSP\2021.05.12.major_figures\l1.major_figure1\TEMP_CO2BGC.ensmean.mat temperature co2
path = 'D:\Study\rainfall_deforestation\2020.05.12.physics_bar\l1.prepare_data\';
% deforest-globe (30yr, ann-wet-dry, models)
% for q (30yr, 1000-925_850-700_700-500, ann-wet-dry, models)
% obsprama = ncread([path,'tair_CRU_region.nc'],'prama');

for vi = 1 : 1
    precip_crv = temperature(:,:,vi);
    precipmean = nanmean(precip_crv,2);
    precipstd = std(precip_crv,0,2,'omitnan');
    
%     treecvmean = reshape(treecv_crv,150*8,1);
%     precipmean = reshape(precip_crv,150*8,1);
    
    % plot
%     yy1 = movmean(precip_crv,11,1);
    yy1 = precipmean;
    xx1 = co2;
    x1 = [280 : 1 : 1200]';
    regs = regstats(yy1,xx1);
    save('regs_bgc_temperature_Amazon.mat','regs');
    regs.beta(2)
    regs.tstat.se(2)
    
    x11 = xx1(~isnan(xx1));
    y11 = yy1(~isnan(yy1));
    ff = fit(x11,y11,'poly1');
    ppp = predint(ff, x1, 0.95, 'observation','off');
    ppp2 = predint(ff, x1, 0.95, 'functional','off');
    vtc = [x1 ppp(:,1); flipud(x1) flipud(ppp(:,2))];
    vtc2 = [x1 ppp2(:,1); flipud(x1) flipud(ppp2(:,2))];
    lenv = length(ppp(:,1));
    fac = [1 2 lenv*2-1 lenv*2];
    for i = 2 : lenv-1
        fac = [fac ; i i+1 lenv*2-i lenv*2-i+1];
    end
%     xt = [x1; flipud(x1)]';a
%     yt = [ppp(:,1); ppp(:,2)]';
%     p3 = patch('Faces',fac,'Vertices',vtc,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,
%     p4 = patch('Faces',fac,'Vertices',vtc2,'FaceColor',[0.75 0.75 0.75],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,

    
%     p1 = plot(xx1,yy1,'o','LineWidth',1.5,'MarkerFaceColor',[0.6 0.6 0.6],...
%         'MarkerEdgeColor','none','MarkerSize',7);
    p1 = scatter(xx1, yy1, 40,'o','filled','LineWidth',0.5,'MarkerFaceColor',[255 194 175]./255,...
        'MarkerEdgeColor',[255 0 0]./255,'MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5);
    box on
    hold on,
    y1 = x1*regs.beta(2)+regs.beta(1);
    p2 = plot(x1,y1,'k--','LineWidth',1.5);
    
    % add current & future co2 concentration
    % 1995_2014 mean: 378.19ppm, 2081:2100(ssp3rcp7) mean: 792.64
    hold on,
%     ylm = get(gca,'YLim');
    ylm = [-0.3 1.5];
%     line([378.19 378.19],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.3 0.8 0.83 0.95],'LineStyle','--')
%     line([792.64 792.64],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.99 0.40 0.53 0.95],'LineStyle','--')
    
    if(vi == 1)
        text(650,0.15,{[num2str(round(regs.beta(2)*100*100)/100),'¡À',num2str(round(regs.tstat.se(2)*100*100)/100),' ^{o}C, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 100 ppm CO_2 increment'...
            },'FontSize',10,'BackgroundColor','none','EdgeColor','none')
%         text(700,1.3,{[num2str(round(regs.beta(2)*100*100)/100),'¡À',num2str(round(regs.tstat.se(2)*100*100)/100),' ^{o}C, P < 0.001'];' per 100 ppm CO_2'...
%             },'FontSize',10,'BackgroundColor','none','EdgeColor','none')
    elseif(vi == 2)
        text(1,92,{'-0.12¡À0.03 % (-260¡À65 mm yr^{-1}) ';' per 1% deforestation'...
            },'FontSize',13)
    else
        text(1,92,{'-0.12¡À0.03 % (-260¡À65 mm yr^{-1}) ';' per 1% deforestation'...
            },'FontSize',13)
    end
    text(110, ylm(2), 'e','FontSize',16,'FontWeight','bold');
%     title('C4MIP CO2BGC','FontSize',12);

    xlabel('CO_2 (ppm)')
    ylabel('Temperature (^oC)')
    set(gca,'XLim',[250 1200],'YLim',[ylm(1) ylm(2)],'FontSize',12);
end



% ----------------  LUMIP -temperature ------------------
subplot(3,2,6),
path = 'D:\Study\rainfall_deforestation\2020.05.12.physics_bar\l1.prepare_data\';
load D:\Study\landuse_climate_SSP\2021.05.12.major_figures\l1.major_figure1\TEMP_LUMIP.ensmean.mat temperature treecv
% deforest-globe (30yr, ann-wet-dry, models)
% for q (30yr, 1000-925_850-700_700-500, ann-wet-dry, models)
% obsprama = ncread([path,'tair_CRU_region.nc'],'prama');
tcval = nan(4,3);
tcval(:,1) = ncread('D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\extract_slice\treeFrac_hist_future.nc','treeFrac_Ama');
tcval(:,2) = ncread('D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\extract_slice\treeFrac_hist_future.nc','treeFrac_Con');
tcval(:,3) = ncread('D:\Study\landuse_climate_SSP\2020.11.25.curve_data_prep\extract_slice\treeFrac_hist_future.nc','treeFrac_Asa');


for vi = 1 : 1
    precip_crv = temperature(:,:,vi);
    treecv_crv = treecv(:,:,vi);
    precip_crv(isnan(treecv_crv)) = nan;
    precip_crv(51:150,:) = nan;
    treecv_crv(51:150,:) = nan;
    
    treecvmean = nanmean(treecv_crv,2);
    precipmean = nanmean(precip_crv,2);
    treecvstd = std(treecv_crv,0,2,'omitnan');
    precipstd = std(precip_crv,0,2,'omitnan');
    
%     treecvmean = reshape(treecv_crv,150*8,1);
%     precipmean = reshape(precip_crv,150*8,1);
    
    % plot
%     yy1 = movmean(precip_crv,11,1);
    yy1 = precipmean;
    xx1 = treecvmean;
    x1 = [1 : 1 : 44]';
    regs = regstats(yy1,xx1);
    save('regs_lumip_temperature_Amazon.mat','regs');
    regs.beta(2)
    regs.tstat.se(2)
    
    x11 = xx1(~isnan(xx1));
    y11 = yy1(~isnan(yy1));
    ff = fit(x11,y11,'poly1');
    ppp = predint(ff, x1, 0.95, 'observation','off');
    ppp2 = predint(ff, x1, 0.95, 'functional','off');
    vtc = [x1 ppp(:,1); flipud(x1) flipud(ppp(:,2))];
    vtc2 = [x1 ppp2(:,1); flipud(x1) flipud(ppp2(:,2))];
    lenv = length(ppp(:,1));
    fac = [1 2 lenv*2-1 lenv*2];
    for i = 2 : lenv-1
        fac = [fac ; i i+1 lenv*2-i lenv*2-i+1];
    end

%     p3 = patch('Faces',fac,'Vertices',vtc,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,
%     p4 = patch('Faces',fac,'Vertices',vtc2,'FaceColor',[0.75 0.75 0.75],'FaceAlpha',0.3,...
%         'EdgeColor','none');
%     hold on,

    
%     p1 = plot(xx1,yy1,'o','LineWidth',1.5,'MarkerFaceColor',[0.6 0.6 0.6],...
%         'MarkerEdgeColor','none','MarkerSize',7);
    p1 = scatter(xx1, yy1, 40,'o','filled','LineWidth',0.5,'MarkerFaceColor',[255 194 175]./255,...
        'MarkerEdgeColor',[255 0 0]./255,'MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5);
    box on
    hold on,
    y1 = x1*regs.beta(2)+regs.beta(1);
    p2 = plot(x1,y1,'k--','LineWidth',1.5);
    
    % add current & future deforestation rate
    hold on,
%     ylm = get(gca,'YLim');
    ylm = [-0.3 1];
%     line([(tcval(2,1)-tcval(1,1))*-1 (tcval(2,1)-tcval(1,1))*-1],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.3 0.8 0.83 0.95],'LineStyle','--')
%     line([(tcval(4,1)-tcval(1,1))*-1 (tcval(4,1)-tcval(1,1))*-1],[ylm(1) ylm(2)],...
%         'LineWidth',1.5,'Color',[0.99 0.40 0.53 0.95],'LineStyle','--')
    
    if(vi == 1)
        text(25,0.75,{[num2str(round(regs.beta(2)*10*100)/100),'¡À',num2str(round(regs.tstat.se(2)*10*100)/100),' ^{o}C, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 10% deforestation'...
            },'FontSize',10)
    elseif(vi == 2)
        text(23,-0.2,{[num2str(round(regs.beta(2)*10*100)/100),'¡À',num2str(round(regs.tstat.se(2)*10*100)/100),' ^{o}C, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 10% deforestation'...
            },'FontSize',13)
    else
        text(23,-0.2,{[num2str(round(regs.beta(2)*10*100)/100),'¡À',num2str(round(regs.tstat.se(2)*10*100)/100),' ^{o}C, P = ',num2str(round(regs.tstat.pval(2)*1000)/1000)];' per 10% deforestation'...
            },'FontSize',13)
    end
    text(-4., ylm(2), 'f','FontSize',16,'FontWeight','bold');
%     title('LUMIP deforest-glob','FontSize',16);
    
    xlabel('Deforestation level (%)')
%     ylabel('Temperature (^oC)')
    set(gca,'XLim',[0 45],'YLim',[ylm(1) ylm(2)],'FontSize',12);

end