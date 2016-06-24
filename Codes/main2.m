%%% Amirpasha Shirazinia -- email: amirpasha.shirazinia@gmail.com,
%%% web: https://people.kth.se/~amishi/
%%% This script analyzes delay (in minutes) during June-August 2015 
%%% Generate CDF (figure 5 in the report)


clc
clear
close all

years = 2015;
months = 6:8;

delay = [];
tic
for y = 1:length(years)
    year = years(y)
    for m = 1:length(months)
        month = months(m)
        % Downloading data (.zip file) from web: http://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time
        url = ['http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_',num2str(year),'_',num2str(month),'.zip'];
        
        % Unzip the compressed file (.csv file)
        unzip(url,['CSV_Files/',num2str(year)]);
        
        % Reading data from the .csv file using the function csvimport()
        filename = ['CSV_Files/',num2str(year),'/On_Time_On_Time_Performance_',num2str(year),'_',num2str(month),'.csv'];
        [ArrDelayMinutes] = csvimport(filename,'columns',{'"ArrDelayMinutes"'});
        
        
        % concatenating delay in an array for the whole period
        [delay] = delayInMinutes(ArrDelayMinutes,delay);
        
        
    end
end
toc

% save data
str.delay = delay;
save('Output2.mat','-struct','str')

% load Output2.mat

% Generate figure 5
figure; 
[ycdf,xcdf] = cdfcalc(delay);
yccdf = 1-ycdf(1:end-1); % Complementary CDF
plot(xcdf,yccdf, 'LineWidth',2);
axis([0,180,0,1])
xlabel('Delay (minutes)')
ylabel('Complementary CDF')
title('')
grid



















