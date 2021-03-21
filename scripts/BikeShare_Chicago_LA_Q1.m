% clc; clear all;

%% read data for Chicago
Divvy_Chi = readtable('Divvy_Trips_2019_Q1.csv');
% trip_id_Chi = Divvy_Chi(:,1);
start_time_Chi = table2array(Divvy_Chi(:,2));
end_time_Chi = table2array(Divvy_Chi(:,3));
% bikeid_Chi = Divvy_Chi(:,4);
tripduration_Chi = table2array(Divvy_Chi(:,5))/60; 
% from_station_id_Chi = Divvy_Chi(:,6);
% from_station_name_Chi = Divvy_Chi(:,7);
% to_station_id_Chi = Divvy_Chi(:,8);
% to_station_name_Chi = Divvy_Chi(:,9);
usertype_Chi = categorical(table2array(Divvy_Chi(:,10)));
gender_Chi = categorical(table2array(Divvy_Chi(:,11)));
birthyear_Chi = table2array(Divvy_Chi(:,12));

%% read data for LA
Metro_LA = readtable('metro-bike-share-trips-2019-q1.csv');
% trip_id_LA = Metro_LA(:,1);
start_time_LA = table2array(Metro_LA(:,2));
end_time_LA = table2array(Metro_LA(:,3));
% bikeid_LA = Metro_LA(:,4);
tripduration_LA = table2array(Metro_LA(:,5)); 
% from_station_id_LA = Metro_LA(:,6);
% from_station_name_LA = Metro_LA(:,7);
% to_station_id_LA = Metro_LA(:,8);
% to_station_name_LA = Metro_LA(:,9);
usertype_LA = categorical(table2array(Metro_LA(:,10)));
birthyear_LA = table2array(Metro_LA(:,12));

%% Data Conditioning 
% Chicago
age_Chicago = (2021-birthyear_Chi);
DayName_Chicago = categorical((day(start_time_Chi,'name')));
DayName1_Chicago = reordercats(DayName_Chicago,{'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'});
% Date =datetime(start_time_Chi, 'Format', 'yyyy-mm-dd')
hour_Chicago = hour(start_time_Chi);

% Los Angeles
DayName_LA = categorical((day(start_time_LA,'name')));
DayName1_LA = reordercats(DayName_LA,{'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'});
hour_LA = hour(start_time_LA);
age_LA = (2021-birthyear_LA);

%% Graphical Representation

%-------------------FIGURE 1 : Trip Duration-------------------

figure1 = figure('Position', [1 1 1920 1080]); hold on;
subplot(1,2,1); %CHICAGO
histogram(tripduration_Chi,24,'BinLimits',[0 120])
set(gca,'FontSize',9,'TickDir','out'); 
xlabel('Trip duration(Minutes)', 'FontSize',12'); 
xticks(0:5:120); xtickangle(45); %xlim([500 2500]); 
ylabel('Count of users', 'FontSize',12'); ylim([0 550000]);
title('Chicago','FontSize', 15');grid on

subplot(1,2,2); %LOS ANGELES
histogram(tripduration_LA,24,'BinLimits',[0 120])
set(gca,'FontSize',9,'TickDir','out'); 
xlabel('Trip duration(Minutes)', 'FontSize',12'); 
xticks(0:5:120); xtickangle(45); %xlim([500 2500]); 
ylabel('Count of users', 'FontSize',12'); ylim([0 550000]);
title('Los Angeles','FontSize', 15');grid on

sgtitle('Histogram of trip duration (Q1 2019)','FontSize',20)
annotation('textbox', [0.80, 0.87, 0.1, 0.1], 'String',"Script Rev:09(March 18,2021)",'FontSize',9)
saveas(figure1,'Histogram of trip duration_Q1_2019.png');

%-------------------FIGURE 2 : Daily Demand Trend-------------------

figure2 = figure('Position', [1 1 1920 1080]); hold on;
subplot(1,2,1); %CHICAGO
histogram(DayName1_Chicago,'BarWidth',0.7);
xlabel('Weekday', 'FontSize',12'); xtickangle(45); 
ylabel('Count of users', 'FontSize',12'); ylim([0 70000]);
title('Chicago','FontSize', 15');grid on

subplot(1,2,2); %LOS ANGELES
histogram(DayName1_LA,'BarWidth',0.7);
xlabel('Weekday', 'FontSize',12'); xtickangle(45); 
ylabel('Count of users', 'FontSize',12'); ylim([0 70000]);
title('Los Angeles','FontSize', 15');grid on

sgtitle('Daily Demand Trend (Q1 2019)','FontSize',20)
annotation('textbox', [0.80, 0.87, 0.1, 0.1], 'String',"Script Rev:09(March 18,2021)",'FontSize',9)
saveas(figure2,'DailyDemandTrend_Q1_2019.png');

%-------------------FIGURE 3 : Monthly Demand Trend-------------------

figure3 = figure('Position', [1 1 1920 1080]); hold on;
subplot(1,2,1); %CHICAGO
histogram(start_time_Chi,12);
xlabel('Month', 'FontSize',12'); %xtickangle(45); 
ylabel('Count of users', 'FontSize',12'); ylim([0 70000]);
title('Chicago','FontSize', 15');grid on

subplot(1,2,2); %LOS ANGELES
histogram(start_time_LA,12);
xlabel('Month', 'FontSize',12'); %xtickangle(45); 
ylabel('Count of users', 'FontSize',12'); ylim([0 70000]);
title('Los Angeles','FontSize', 15');grid on

sgtitle('Monthly Demand Trend (Q1 2019)','FontSize',20)
annotation('textbox', [0.80, 0.87, 0.1, 0.1], 'String',"Script Rev:09(March 18,2021)",'FontSize',9)
saveas(figure3,'MonthlyTrend_Q1_2019.png');

%-------------------FIGURE 4 : Hourly Demand Trend-------------------
figure4 = figure('Position', [1 1 1920 1080]); hold on;
subplot(1,2,1); %CHICAGO
histogram(hour_Chicago,24,'BinLimits',[0 24]);
set(gca,'FontSize',9,'TickDir','out'); 
xticks(0:1:24); xtickangle(45);
xlabel('Hour', 'FontSize',12'); xtickangle(45); 
ylabel('Count of users', 'FontSize',12'); ylim([0 60000]);
title('Chicago','FontSize', 15');grid on

subplot(1,2,2); %LOS ANGELES
histogram(hour_LA,24,'BinLimits',[0 24]);
set(gca,'FontSize',9,'TickDir','out'); 
xticks(0:1:24); xtickangle(45);
xlabel('Hour', 'FontSize',12'); xtickangle(45); 
ylabel('Count of users', 'FontSize',12'); ylim([0 60000])
title('Los Angeles','FontSize', 15');grid on

sgtitle('Hourly Demand Trend (Q1 2019)','FontSize',20)
annotation('textbox', [0.80, 0.87, 0.1, 0.1], 'String',"Script Rev:09(March 18,2021)",'FontSize',9)
saveas(figure4,'HourlyTrend_Q1_2019.png');

%-------------------FIGURE 5 : Age of users-------------------
figure5 = figure('Position', [1 1 1920 1080]); hold on;

subplot(1,2,1); %CHICAGO
histogram(age_Chicago,20,'BinLimits',[0 100]);
set(gca,'FontSize',9,'TickDir','out'); 
xticks(0:10:100); xtickangle(45);
xlabel('Age(Years)', 'FontSize',12'); xtickangle(45); 
ylabel('Count of users', 'FontSize',12'); ylim([0 90000]);
title('Chicago','FontSize', 15');grid on

subplot(1,2,2); %LOS ANGELES
histogram(age_LA,20,'BinLimits',[0 100]);
set(gca,'FontSize',9,'TickDir','out');
xticks(0:10:100); xtickangle(45);
xlabel('Age(Years)', 'FontSize',12'); xtickangle(45); 
ylabel('Count of users', 'FontSize',12'); ylim([0 90000]);
title('Los Angeles','FontSize', 15');grid on

sgtitle('Age vs count of users (Q1 2019)','FontSize',20)
annotation('textbox', [0.80, 0.87, 0.1, 0.1], 'String',"Script Rev:09(March 18,2021)",'FontSize',9)
saveas(figure5,'AgeTrend_Q1_2019.png');

%-------------------FIGURE 6 : Subscribers vs Daily users-------------------
figure6 = figure('Position', [1 1 1920 1080]); hold on;
subplot(1,2,1); %CHICAGO
pie(usertype_Chi);
title('Chicago','FontSize', 15');

subplot(1,2,2); %LOS ANGELES
pie(usertype_LA);
title('Los Angeles','FontSize', 15');

sgtitle('Subscribers vs Daily Customers (Q1 2019)','FontSize',20)
annotation('textbox', [0.80, 0.87, 0.1, 0.1], 'String',"Script Rev:09(March 18,2021)",'FontSize',9)
saveas(figure6,'subscriberVsCustomer_Q1_2019.png');

