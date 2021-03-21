clear all
close all

% Read Data from source data file 
% T = readtable('metro-bike-share-trips-2019-q1.csv');
% T = readtable('metro-bike-share-trips-2019-q2.csv');
% T = readtable('metro-bike-share-trips-2019-q3.csv');
T = readtable('metro-bike-share-trips-2019-q4.csv');


start_time_LA = table2array(T(:,2));
hour_LA = hour(start_time_LA);

%% Data Conditioning

DayOfWeek = weekday(start_time_LA);
i=1; m=numel(DayOfWeek);
DayOfWeekZeroOne = zeros(m,1);

% Find out the if the day is Weekend or weekday
for i = 1:m
    if (DayOfWeek(i) == 1 || DayOfWeek(i)==7) 
        DayOfWeekZeroOne(i) = 1; %Weekend = 1
    else 
        DayOfWeekZeroOne(i)= 0; %Weekday = 0
    end
end

% Data pre-preprocessing for the holiday check
holidayKey = {'2019-01-01', '2019-01-21', '2019-05-27', '2019-07-04', '2019-08-02', '2019-11-11', '2019-11-28', '2019-12-25'};
holidayValue = [1, 2, 3, 4, 5, 6, 7, 8];
holidayMap = containers.Map(holidayKey, holidayValue);

holidayInYearZeroOne = zeros(m, 1);
DateOnly = datetime(start_time_LA, 'Format', 'yyyy-MM-dd');
DateOnlyString = string(DateOnly);

% Find out the if the day is Holiday or Non-Holiday
for i = 1:m
    if (isKey(holidayMap, DateOnlyString(i)))
        holidayInYearZeroOne(i) = 1; %Holiday = 1
    else
        holidayInYearZeroOne(i) = 0; %Non-Holiday = 1
    end
end

% Create table of independent variables and response 

WDstr = num2str(DayOfWeekZeroOne);
HDstr = num2str(holidayInYearZeroOne);
HRstr = num2str(hour_LA);
strDel = string(strcat(WDstr,{'-'},HDstr,{'-'},HRstr));

strDelUnique = string(unique(strDel));
k=length(strDelUnique);
strDelUniqueCount = zeros(k,1);
for i = 1: length(strDelUnique)
    strDelUniqueCount(i) = numel(find(strDel==strDelUnique(i)));
end
newStr = split(strDelUnique, '-');
newNum = double(newStr);
Weekend = newNum(:,1); 
Holiday = newNum(:,2);
HourOfDay = newNum(:,3);
TripCount = strDelUniqueCount;

% Regression table to run Linear Regression Model
FinalRegressionTable = table(Weekend, Holiday, HourOfDay, TripCount);
% writetable(FinalRegressionTable,'LA_Q1.csv');
% writetable(FinalRegressionTable,'LA_Q2.csv');
% writetable(FinalRegressionTable,'LA_Q3.csv');
writetable(FinalRegressionTable,'LA_Q4.csv');

%Fit Regression Model and view results
mdl=fitlm(FinalRegressionTable)
anova(mdl, 'summary')

