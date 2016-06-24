%%% Amirpasha Shirazinia -- email: amirpasha.shirazinia@gmail.com,
%%% web: https://people.kth.se/~amishi/
%%% This script analyzes delay and cancelation profile of passenger flights
%%% in th US from Jan. 2000 to Dec. 2015
%%% Generate figures 1-4 in the report

clc
clear
close all

years = 2000:2015;
months = 1:12;


% Pre-allocations
numOfFlights = zeros(length(years),length(months));
numOfCanceled = zeros(length(years),length(months));
numOfDiverted = zeros(length(years),length(months));
numOfArrDelayed = zeros(length(years),length(months));
numOfDepDelayed = zeros(length(years),length(months));
carrierDelay = zeros(length(years),length(months));
weatherDelay = zeros(length(years),length(months));
NASDelay = zeros(length(years),length(months));
securityDelay = zeros(length(years),length(months));
LateAircraftDelay = zeros(length(years),length(months));



canceledRatio = zeros(length(years),length(months));
divertedRatio = zeros(length(years),length(months));
arrDelayedRatio = zeros(length(years),length(months));
depDelayedRatio = zeros(length(years),length(months));

tic
for y = 1:length(years)
    for m = 1:length(months)
        year = years(y);
        month = months(m);
        
        % Downloading data (.zip file) from web: http://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time
        url = ['http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_',num2str(year),'_',num2str(month),'.zip'];
        
        % Unzip the compressed file (.csv file)
        unzip(url,['CSV_Files/',num2str(year)]);
        
        % Reading data from the .csv file using the function csvimport()
        filename = ['CSV_Files/',num2str(year),'/On_Time_On_Time_Performance_',num2str(year),'_',num2str(month),'.csv'];
        [DepDel15, ArrDel15, Canceled, Diverted] = csvimport(filename,'columns',{'"DepDel15"','"ArrDel15"','"Cancelled"', '"Diverted"'});
        
        % [CarrierDelay, WeatherDelay, NASDelay, SecurityDelay, LateAircraftDelay] = csvimport(filename,'columns',{'"CarrierDelay"', '"WeatherDelay"','"NASDelay"', '"SecurityDelay"', '"LateAircraftDelay"' });
        % Analysis of data 
        numOfFlights(y,m) = length(Canceled);
        numOfCanceled(y,m) = sum(Canceled);
        canceledRatio(y,m) = numOfCanceled(y,m)/numOfFlights(y,m);
        
        numOfDiverted(y,m) = sum(Diverted);
        divertedRatio(y,m) = numOfDiverted(y,m)/numOfFlights(y,m);
        
        
        [numOfArrDelayed(y,m), arrDelayedRatio(y,m)] = DelRatio(ArrDel15);
        [numOfDepDelayed(y,m), depDelayedRatio(y,m)] = DelRatio(DepDel15);
        
        
        
        
    end
end
toc


s.numOfFlights = numOfFlights;
s.numOfCanceled = numOfCanceled;
s.canceledRatio = canceledRatio;
s.numOfDiverted = numOfDiverted;
s.divertedRatio = divertedRatio;
s.numOfArrDelayed = numOfArrDelayed;
s.arrDelayedRatio = arrDelayedRatio;
s.numOfDepDelayed = numOfDepDelayed;
s.depDelayedRatio = depDelayedRatio;

save('Output1.mat','-struct','s')

% load Output1.mat
% Plots Figures 1-4 in the report
startDate = datenum('01-01-2000');
endDate = datenum('12-31-2015');
plotDataAnalysis(startDate, endDate, months, years, numOfFlights, ...
    numOfCanceled, canceledRatio, numOfDiverted, divertedRatio, ...
    numOfArrDelayed, arrDelayedRatio, numOfDepDelayed, depDelayedRatio);
    











