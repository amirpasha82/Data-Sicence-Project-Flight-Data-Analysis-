function [] = plotDataAnalysis(startDate, endDate, months, years, numOfFlights, ...
    numOfCanceled, canceledRatio, numOfDiverted, divertedRatio, ...
    numOfArrDelayed, arrDelayedRatio, numOfDepDelayed, depDelayedRatio)


% Plot ratio of delayed, cancelled and diverted flights in the interval Jan.
% 2000 till Dec. 2015

xData = linspace(startDate,endDate,length(years)*length(months));
tmp1 = canceledRatio'; cancelVec = tmp1(:)*100;
tmp2 = arrDelayedRatio'; arrDelVec = tmp2(:)*100;
tmp3 = depDelayedRatio'; depDelVec = tmp3(:)*100;
tmp4 = divertedRatio'; divDelVec = tmp4(:)*100;
figure; plot(xData, arrDelVec, xData, cancelVec, xData, divDelVec, 'LineWidth', 2);
axis([xData(1),xData(end),0,35])
ylabel('Percentage of delayed/canceled/diverted flights (%)')
legend('Delayed', 'Canceled', 'Diverted')
NumTicks = 48;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mmm yyyy','keeplimits', 'keepticks')
xticklabel_rotate;
set(gca,'XMinorTick','on','YMinorTick','on')


% Plot number of regular, delayed, cancelled and diverted flights in the interval Jan.
% 2000 till Dec. 2015


tmp5 = numOfFlights'; flightlVec = tmp5(:);
tmp6 = numOfCanceled'; numCancelVec = tmp6(:);
tmp7 = numOfArrDelayed'; numArrDelVec = tmp7(:);
tmp8 = numOfDepDelayed'; numDepDelVec = tmp8(:);
tmp9 = numOfDiverted'; numDivVec = tmp9(:);
figure; plot(xData, flightlVec, xData, numCancelVec , xData, numArrDelVec, xData, numDivVec, 'LineWidth',2);
axis([xData(1),xData(end),0,7e5])
ylabel('Number of flights')
legend('Total flights','Canceled flights', 'Delayed flights', 'Diverted flights')
NumTicks = 48;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x','mmm yyyy','keeplimits', 'keepticks')
xticklabel_rotate;
set(gca,'XMinorTick','on','YMinorTick','on')

% Average plots
s = datenum('01-01-2009');
e = datenum('12-31-2009');
xDataAverage = linspace(s,e,12);
figure; bar(xDataAverage,mean(numOfFlights),0.25,'FaceColor',[0,0,1],...
                     'EdgeColor',[0,0,1]);   
hold on;
bar(xDataAverage,mean(numOfDepDelayed),0.45,'FaceColor',[0,1,0],...
                     'EdgeColor',[0,1,0]);  
bar(xDataAverage,mean(numOfCanceled),0.7,'FaceColor',[1,0,0]);
ylabel('Number of total/delayed/canceled flights (on average)')
legend('Total flights','Delayed flights','Cancelled flights')
ax = gca;
ax.XTick = xDataAverage;
datetick('x','mmm','keepticks')
hold off


% CDF plots
figure; 
hold on
divCDF = cdfplot(numDivVec);
cancelCDF = cdfplot(numCancelVec);
delayCDF = cdfplot(numArrDelVec);
legend('Diverted','Canceled', 'Delayed')
xlabel('Number of diverted/canceled/delayed flights')
ylabel('CDF')
set(cancelCDF,'LineWidth',2)
set(delayCDF,'LineWidth',2)
set(divCDF,'LineWidth',2)

title('')
hold off






