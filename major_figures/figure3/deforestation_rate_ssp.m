%% 1. create a table to store the CO2 increment
clear,clc;
dataco2 = nan(4,5);
load co2_record.mat
for k = 1 : 5
    if(k ==1) 
        fut_co2 = ssp126_co2;
    elseif(k ==2)
        fut_co2 = ssp245_co2;
    elseif(k ==3)
        fut_co2 = ssp370_co2;
    elseif(k ==4)
        fut_co2 = ssp434_co2;
    else
        fut_co2 = ssp585_co2;
    end
    
    for i = 1 : 4
        dataco2(i,k) = mean(fut_co2(7+ (i-1)*20 : 26+(i-1)*20,2)) - hist_co2(101,2);
    end
end


%% 2. create a table to store the deforestation rate in Amazon
datadef = nan(4,5);

for k = 1 : 5
    if(k ==1)
        load treecover_ssp126_1850_2100.mat
    elseif(k ==2)
        load treecover_ssp245_1850_2100.mat
    elseif(k ==3)
        load treecover_ssp370_1850_2100.mat
    elseif(k ==4)
        load treecover_ssp434_1850_2100.mat
    else
        load treecover_ssp585_1850_2100.mat
    end
    for t = 1 : 4
        % treecover from 1850 - 2100, 251 years
        deforestation_rate = mean(treecover(:,:,2021-1849+(t-1)*20:2040-1849+(t-1)*20),3) - treecover(:,:,1);
        
        def_rate = nan(360,720);
        for i = 1 : 360
            for j = 1 : 720
                tmp = deforestation_rate( (i-1)*2+1 :i*2, (j-1)*2+1:j*2);
                tmp = tmp(~isnan(tmp));
                if(isempty(tmp))
                    continue;
                end
                def_rate(i,j) = mean(tmp);
            end
        end
        %         figure,imagesc(def_rate)
        amabasin = rot90(ncread('D:\Study\rainfall_deforestation\basin_map0.5.nc','cell_area'));
        amabass = amabasin;
        amabasin(:,1:360) = amabass(:,361:720);
        amabasin(:,361:720) = amabass(:,1:360);
%         figure,imagesc(amabasin)
        area = nan(360,720);
        for ilat = 1 : 360
            latt = (90-(ilat/2)+0.25) *pi/180;
            for ilon = 1 : 720
                area(ilat,ilon) = (111/2 * 111/2 *cos(latt)); %km2
            end
        end
        area(isnan(def_rate)) = nan;
        
        map1 = def_rate(:,:);
        map1(amabasin ~= 259) = nan;
        a1 = area;
        a1(isnan(map1)) = nan;
        datadef(t,k) = nansum(nansum(map1.*a1))/nansum(nansum(a1));
    end
end


% save data_deforestation_co2.mat datadef dataco2
%% 3. mapping, compute forest loss at different regions

clear,clc;
load data_deforestation_co2.mat
sspname = {'SSP126','SSP245','SSP370','SSP434','SSP585'};
figure,
for k = 1 : 5
    subplot(5,1,k),
    b(k) = bar([1:4]'-0.15,datadef(:,k)*-1,0.2,'FaceAlpha',0.6,...
        'FaceColor',[107 212 215]./255);
    grid on
    set(gca,'YLim',[0 15],'XLim',[0.1 4.9],'GridLineStyle',':',...
        'XTick',[1:4],'XTickLabel',{'2021-2040','2041-2060','2061-2081','2081-2100'})
    if(k ==3)
        ylabel('Deforestation (%)','FontSize',13)
    end
    text(0.2,12,sspname{k});
    yyaxis right
    
    bb(k) = bar([1:4]'+0.15,dataco2(:,k),0.2,'FaceAlpha',0.6,...
        'FaceColor',[255 109 128]./255);
    grid on
    set(gca,'YColor','red','YLim',[0 750],'XLim',[0.1 4.9])
%     ,...        'XTick',[1:4],'XTickLabel',{'','','',''})
    if(k ==3)
        ylabel('\Delta CO_2 (ppm)','FontSize',13)
        legend('Deforestation','CO_2 increase')                
    end
end


%% 4. re-order mapping, compute forest loss at different regions

clear,clc;
load data_deforestation_co2.mat
sspname = {'SSP126','SSP245','SSP370','SSP434','SSP585'};
figure,
for k = 1 : 5
    subplot(5,1,k),
    yyaxis right
    b(k) = bar([1:4]'+0.15,datadef(:,k)*-1,0.2,'FaceAlpha',0.6,...
        'FaceColor',[107 212 215]./255);
    grid on
    set(gca,'YColor',[107 212 215]./255,'YLim',[0 15],'XLim',[0.1 4.9],'GridLineStyle',':',...
        'XTick',[1:4],'XTickLabel',{'2021-2040','2041-2060','2061-2081','2081-2100'})
    if(k ==3)
        ylabel('Deforestation (%)','FontSize',13)
    end
    text(0.2,12,sspname{k});
    yyaxis left
    
    bb(k) = bar([1:4]'-0.15,dataco2(:,k),0.2,'FaceAlpha',0.6,...
        'FaceColor',[255 109 128]./255);
    grid on
    set(gca,'YColor','red','YLim',[0 750],'XLim',[0.1 4.9])
%     ,...        'XTick',[1:4],'XTickLabel',{'','','',''})
    if(k ==3)
        ylabel('\Delta CO_2 (ppm)','FontSize',13)
        legend('CO_2 increase','Deforestation')                
    end
end

% set(gcf,'position',[ 1000         218         560         720])

%% 5. deforestation new color, re-order mapping, compute forest loss at different regions

clear,clc;
load data_deforestation_co2.mat
sspname = {'SSP126','SSP245','SSP370','SSP434','SSP585'};
figure,
for k = 1 : 5
    subplot(5,1,k),
    yyaxis right
    b(k) = bar([1:4]'+0.15,datadef(:,k)*-1,0.2,'FaceAlpha',0.6,...
        'FaceColor',[150 75 0]./255);
    grid on
    set(gca,'YColor',[150 75 0]./255,'YLim',[0 15],'XLim',[0.1 4.9],'GridLineStyle',':',...
        'XTick',[1:4],'XTickLabel',{'2021-2040','2041-2060','2061-2081','2081-2100'})
    if(k ==3)
        ylabel('Deforestation (%)','FontSize',13)
    end
    text(0.2,12,sspname{k});
    yyaxis left
    
    bb(k) = bar([1:4]'-0.15,dataco2(:,k),0.2,'FaceAlpha',0.6,...
        'FaceColor',[246 183 112]./255);
    grid on
    set(gca,'YColor',[246 183 112]./255,'YLim',[0 750],'XLim',[0.1 4.9])
%     ,...        'XTick',[1:4],'XTickLabel',{'','','',''})
    if(k ==3)
        ylabel('\Delta CO_2 (ppm)','FontSize',13)
        ll = legend('CO_2 increase','Deforestation');
        set(ll, 'FontSize',10);
    end
end

set(gcf,'position',[ 1000         218         560         720])
