function [] = plotDataAnalysis3(mapDelayByCarrier, mapFlightByCarrier, mapDelayByState, mapFlightByState)


%filename = ['CSV_Files/',num2str(year),'/On_Time_On_Time_Performance_',num2str(year),'_',num2str(month),'.csv'];
%[carriers, ArrivalDelayGroups] = csvimport(filename,'columns',{'"UniqueCarrier"', '"ArrivalDelayGroups"'});
        


numOfDelayByCarr = cell2mat(mapDelayByCarrier.values.toArray.cell);
numOfFlightsByCarr = cell2mat(mapFlightByCarrier.values.toArray.cell);
numOfDelayByState = cell2mat(mapDelayByState.values.toArray.cell);
numOfFlightByState = cell2mat(mapFlightByState.values.toArray.cell);


keyDelayByCarr = mapDelayByCarrier.keySet.toArray.cell;
keyFlightByCarr = mapFlightByCarrier.keySet.toArray.cell;
keyDelayByState = mapDelayByState.keySet.toArray.cell;
keyFlightByState = mapFlightByState.keySet.toArray.cell;

[numOfDelayByCarr_sorted , ind1] = sort(numOfDelayByCarr);
j = 1;
c = cell(1,length(ind1));
for i=1:length(ind1)
    c{j} = keyDelayByCarr{ind1(i)};
    j = j + 1;
end


[numOfFlightsByCarr_sorted, ind2] = sort(numOfFlightsByCarr);
j = 1;
d = cell(1,length(ind2));
for i=1:length(ind2)
    d{j} = keyFlightByCarr{ind2(i)};
    j = j + 1;
end    


delayOverFlight = numOfDelayByCarr./numOfFlightsByCarr;
[delayOverFlight_sorted, ind3] = sort(delayOverFlight);
j = 1;
e = cell(1,length(ind3));
for i=1:length(ind3)
    e{j} = keyFlightByCarr{ind3(i)};
    j = j + 1;
end    

[numOfDelayByState_sorted, ind4] = sort(numOfDelayByState);
j = 1;
f = cell(1,length(ind4));
for i=1:length(ind4)
    f{j} = keyDelayByState{ind4(i)};
    j = j + 1;
end    


[numOfFlightByState_sorted, ind5] = sort(numOfFlightByState);
j = 1;
g = cell(1,length(ind5));
for i=1:length(ind5)
    g{j} = keyFlightByState{ind5(i)};
    j = j + 1;
end    

%%% Plots

% delays by carrier
figure;
bar(1:length(ind1),numOfDelayByCarr_sorted)
set(gca,'XTick',1:length(ind1),'XTickLabel',strrep( c,'"',''))
%xticklabel_rotate;
xlabel('Airlines')
ylabel('Delayed flights')

% flights by carrier
figure;
bar(1:length(ind2),numOfFlightsByCarr_sorted)
set(gca,'XTick',1:length(ind2),'XTickLabel',strrep( d,'"',''))
xlabel('Airlines')
ylabel('Total flights')

% delay/flights by carrier
figure;
bar(1:length(ind3),delayOverFlight_sorted)
set(gca,'XTick',1:length(ind3),'XTickLabel',strrep( e,'"',''))
xlabel('Airlines')
ylabel('Delayed-to-total flights')

% delays by state
figure;
bar(1:length(ind4),numOfDelayByState_sorted)
set(gca,'XTick',1:length(ind4),'XTickLabel',strrep( f,'"',''));
%xticklabel_rotate;
axis([0,length(ind4)+1,0,max(numOfDelayByState_sorted)])
ylabel('Delayed flights')
xticklabel_rotate;

% flights by state
figure;
bar(1:length(ind5),numOfFlightByState_sorted)
set(gca,'XTick',1:length(ind5),'XTickLabel',strrep( g,'"',''));
%xticklabel_rotate;
axis([0,length(ind5)+1,0,max(numOfFlightByState_sorted)])
ylabel('Total flights')
xticklabel_rotate;








