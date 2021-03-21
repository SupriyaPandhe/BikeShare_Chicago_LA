%% Read the Lat Long coordinate data of DIVVY bike stations
Divvy_Chi = xlsread('Divvy_Bicycle_Stations_-_All_-_Map.csv');
Lat_bike = Divvy_Chi(:,6);
Long_bike = Divvy_Chi(:,7);

%% read Lat Long coordinate data of Bus stops in Chicago
LStop_Chi = xlsread('CTA_L_Stops_Map.csv');
Lat_LStop = LStop_Chi(:,15);
Long_LStop = LStop_Chi(:,16);

%% Plot the geolocation of the Bike stops and Bus stops
figure;
%figure('color','w')
subplot(1,3,1);

% View the Data as a Geographic Scatter Plot

%geoplot(Lat,Long, '*')
%geoscatter(Lat_bike,Long_bike,'^','r')
%geoaxes('NextPlot','add');

geoscatter(Lat_LStop, Long_LStop,'o','k')
hold on
geoscatter(Lat_bike,Long_bike,'.','r')
%geoaxes('NextPlot','add');

geobasemap topographic
title('Station Location','FontSize',15)
legend('L Stops','Bike Station', 'Location','Southwest');
title('Divvy Bicycle Stations & Train(L) stops','FontSize',10)
%geobasemap streets
%geolimits([41.30 42.10],[-87.50 -87.30])

%Create a Density Plot Specifying the Radius
subplot(1,3,2)
radiusInMeters = 1e3;
geodensityplot(Lat_LStop,Long_LStop,'Radius',radiusInMeters,'FaceColor','k')
hold on
% %geoaxes('NextPlot','add')
geoscatter(Lat_bike,Long_bike,'.','r') 
geobasemap topographic
legend('L Stop Density','Bike Stops', 'Location','Southwest');
title('Divvy Bicycle Stations over Train(L) stop Density','FontSize',10)
annotation('textbox', [0.50, 0.78, 0.1, 0.1], 'String',"Radius in Meter = 1000 ",'FontSize',7)

% %alphamap(normalize((1:64).^0.5,'range'))

subplot(1,3,3)
radiusInMeters = 1e3;%1 km
geodensityplot(Lat_bike,Long_bike,'Radius',radiusInMeters,'FaceColor','r')
geobasemap topographic 
hold on
geoscatter(Lat_LStop, Long_LStop,'o','k')
legend('Bike Stops Density','Train(L)Stops', 'Location','Southwest');
%set(gcf,'CurrentAxes')
annotation('textbox', [0.79, 0.78, 0.1, 0.1], 'String',"Radius in Meter = 1000 ",'FontSize',7)
title('Train(L)Stops over Divvy Bicycle Station Density','FontSize',10)

sgtitle('Chicago','FontSize',20)


annotation('textbox', [0.80, 0.87, 0.1, 0.1], 'String',"Script Rev:08(March 17,2021)",'FontSize',9)
