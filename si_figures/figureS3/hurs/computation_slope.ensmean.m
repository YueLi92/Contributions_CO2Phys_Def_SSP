%% compute the regression slope and pval - data1
clear,clc;
def = ncread('def_co2.nc','def');
def = def(1:50);
co2 = ncread('def_co2.nc','co2');

lat = ncread('all_data1.ensmean.nc','lat'); 
lon = ncread('all_data1.ensmean.nc','lon'); 
prepp = ncread('all_data1.ensmean.nc','prepp'); % lon, lat, yr, model
prepm = nanmean(prepp,4);
regsta = nan(360,180,2);
modb = nan(360,180,8);
modpval = nan(360,180,8);
mdagre = nan(360,180);

for ilon = 270 : 330
    ilon
    for ilat = 66 : 113
%         for mth = 1 : 12
            yy = reshape(prepm(ilon,ilat,:),50,1);
%             if(yy(1) <=0)
%                 continue;
%             end
            xx = def;
            
            reg = regstats(yy,xx);
            
            regsta(ilon,ilat,1) = reg.beta(2)*10;
            regsta(ilon,ilat,2) = reg.tstat.pval(2);
%         end
    end
end

for mi = 1 : 8
    mi
    if(mi == 1 || mi == 3 || mi == 4 || mi == 6)
        continue;
    end
    for ilon = 270 : 330
        for ilat = 66 : 113
%             for mth = 1 : 12
                yy = reshape(prepp(ilon,ilat,:,mi),50,1);
%                 if(yy(1) <=0)
%                     continue;
%                 end
                xx = def;
                
                reg = regstats(yy,xx);
                
                modb(ilon,ilat,mi) = reg.beta(2)*10;
                modpval(ilon,ilat,mi) = reg.tstat.pval(2);
%             end
        end
    end
end

for ilon = 270 : 330
    for ilat = 66 : 113
%         for mth = 1 : 12            
            y1 = regsta(ilon,ilat,1);
            y2 = reshape(modb(ilon,ilat,:),8,1);
            yt = y1*y2;
            mdagre(ilon,ilat) = length(find(yt>0));            
%         end
    end
end
mdagre = mdagre / 3.1499;



%% write to nc
ncwrite('all_data1.ensmean.nc','regsta',regsta);
ncwrite('all_data1.ensmean.nc','modb',modb);
ncwrite('all_data1.ensmean.nc','modpval',modpval);
ncwrite('all_data1.ensmean.nc','mdagre',mdagre);


%% compute the regression slope and pval - data2
clear,clc;
def = ncread('def_co2.nc','def');
def = def(1:50);
co2 = ncread('def_co2.nc','co2');

% lat = ncread('all_data2.nc','lat'); 
% lon = ncread('all_data2.nc','lon'); 
prepp = ncread('all_data2.ensmean.nc','prepp2'); % lon, lat, yr, model
prepm = nanmean(prepp,4);
regsta = nan(360,180,2);
modb = nan(360,180,8);
modpval = nan(360,180,8);
mdagre = nan(360,180);

for ilon = 270 : 330
    ilon
    for ilat = 66 : 113
%         for mth = 1 : 12
            yy = reshape(prepm(ilon,ilat,:),140,1);
%             if(yy(1) <=0)
%                 continue;
%             end
            xx = co2;
            
            reg = regstats(yy,xx);
            
            regsta(ilon,ilat,1) = reg.beta(2)*100;
            regsta(ilon,ilat,2) = reg.tstat.pval(2);
%         end
    end
end

for mi = 1 : 8
    mi
    if(mi == 1|| mi == 4 || mi == 6)
        continue;
    end
    for ilon = 270 : 330
        for ilat = 66 : 113
%             for mth = 1 : 12
                yy = reshape(prepp(ilon,ilat,:,mi),140,1);
%                 if(yy(1) <=0)
% %                     continue;
%                 end
                xx = co2;
                
                reg = regstats(yy,xx);
                
                modb(ilon,ilat,mi) = reg.beta(2)*100;
                modpval(ilon,ilat,mi) = reg.tstat.pval(2);
%             end
        end
    end
end

for ilon = 270 : 330
    for ilat = 66 : 113
%         for mth = 1 : 12            
            y1 = regsta(ilon,ilat,1);
            y2 = reshape(modb(ilon,ilat,:),8,1);
            yt = y1*y2;
            mdagre(ilon,ilat) = length(find(yt>0));            
%         end
    end
end
mdagre = mdagre / 3.1499;



%% write to nc
ncwrite('all_data2.ensmean.nc','regsta2',regsta);
ncwrite('all_data2.ensmean.nc','modb2',modb);
ncwrite('all_data2.ensmean.nc','modpval2',modpval);
ncwrite('all_data2.ensmean.nc','mdagre2',mdagre);
