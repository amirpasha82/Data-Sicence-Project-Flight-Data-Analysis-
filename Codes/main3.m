%%% Amirpasha Shirazinia -- email: amirpasha.shirazinia@gmail.com,
%%% web: https://people.kth.se/~amishi/
%%% This script analyzes delay and cancelation profile of passenger flights
%%% in th US from Jan. 2000 to Dec. 2015
%%% Focused on delays and volume of flights by ailines (carriers) by states
%%% Generating Figs 6-13 in the report

clc
clear
close all

years = 2008:2015;
months = 1:12;


% Pre-allocations
delay60 = zeros(length(years),length(months));

% Using Hash Table in Java libraries
import java.util.Hashtable
mapDelayByCarrier = java.util.Hashtable;
mapFlightByCarrier = java.util.Hashtable;
mapDelayByState = java.util.Hashtable;
mapFlightByState = java.util.Hashtable;


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
        [UniqueCarrier, ArrivalDelayGroups, DestState] = csvimport(filename,'columns',{'"UniqueCarrier"', '"ArrivalDelayGroups"', '"DestState"'});
        
        % Outputs: Hash tables (HashTable 1: (key, data) = (carrier, no. of flights with delay>60)
        % HashTable 2 = (key, data) = (carrier, number of flights))
        % delay60: number of delays > 60 mins (in total).
        
        % Analysis of data 
        [mapDelayByCarrier, mapFlightByCarrier, mapDelayByState, mapFlightByState, delay60(y,m)] = delayAnalysis(mapDelayByCarrier, mapFlightByCarrier, mapDelayByState, mapFlightByState, UniqueCarrier, ArrivalDelayGroups, DestState);
        
        
    end
end
toc

st.mapDelayByCarrier = mapDelayByCarrier;
st.mapFlightByCarrier = mapFlightByCarrier;
st.mapDelayByState = mapDelayByState;
st.mapFlightByState = mapFlightByState;
st.delay60 = delay60;

save('Output3.mat','-struct','st')

% load Output3.mat

% generating figs 6-13
plotDataAnalysis3(mapDelayByCarrier, mapFlightByCarrier, mapDelayByState, mapFlightByState)





