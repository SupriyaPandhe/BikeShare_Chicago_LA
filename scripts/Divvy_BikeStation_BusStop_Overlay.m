%% Read the Lat Long coordinate data of DIVVY bike stations
Divvy_Chi = xlsread('Divvy_Bicycle_Stations_-_All_-_Map.csv');
Lat_bike = Divvy_Chi(:,6);
Long_bike = Divvy_Chi(:,7);

%% read Lat Long coordinate data of Bus stops in Chicago
BusStop_Chi = xlsread('CTA_BusStops_Chicago.csv');
Lat_bus = BusStop_Chi(:,14);
Long_bus = BusStop_Chi(:,13);

%% Plot the geolocation of the Bike stops and Bus stops
figure;
%figure('color','w')
subplot(1,3,1);

% View the Data as a Geographic Scatter Plot

%geoplot(Lat,Long, '*')
%geoscatter(Lat_bike,Long_bike,'^','r')
%geoaxes('NextPlot','add');

geoscatter(Lat_bus, Long_bus,'.','y')
hold on
geoscatter(Lat_bike,Long_bike,'^','r')
%geoaxes('NextPlot','add');

geobasemap topographic
title('Station Location','FontSize',15)
legend('Bus Stops','Bike Station', 'Location','Southwest');
title('Divvy Bicycle Stations & Bus stops','FontSize',10)
%geobasemap streets
%geolimits([41.30 42.10],[-87.50 -87.30])

%Create a Density Plot Specifying the Radius
subplot(1,3,2)
radiusInMeters = 1e3;
geodensityplot(Lat_bus,Long_bus,'Radius',radiusInMeters,'FaceColor','y')
hold on
% %geoaxes('NextPlot','add')
geoscatter(Lat_bike,Long_bike,'.','r') 
geobasemap topographic
legend('Bus Stops Density','Bike Stops', 'Location','Southwest');
title('Divvy Bicycle Stations over Bus stop Density','FontSize',10)
annotation('textbox', [0.50, 0.78, 0.1, 0.1], 'String',"Radius in Meter = 1000 ",'FontSize',7)

% %alphamap(normalize((1:64).^0.5,'range'))

subplot(1,3,3)
radiusInMeters = 1e3;%1 km
geodensityplot(Lat_bike,Long_bike,'Radius',radiusInMeters,'FaceColor','r')
geobasemap topographic 
legend('Bike Stops Density', 'Location','Southwest');
%set(gcf,'CurrentAxes')
annotation('textbox', [0.79, 0.78, 0.1, 0.1], 'String',"Radius in Meter = 1000 ",'FontSize',7)

title('Divvy Bicycle Station Density','FontSize',10)

sgtitle('Chicago','FontSize',20)


annotation('textbox', [0.80, 0.87, 0.1, 0.1], 'String',"Script Rev:07(March 17,2021)",'FontSize',9)
