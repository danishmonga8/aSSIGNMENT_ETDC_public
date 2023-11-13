clc; clear all; close all;

% Specify the file path
file = 'D:\1_Phd\landslide_riview_paper\nasa_global_landslide_catalog_point.csv';

% Read the dataset
data = readtable(file);

% Replace the missing values in the fatality_count column with zero
data.fatality_count = fillmissing(data.fatality_count,'constant',0);

% Define the boundaries of the continents
continents = {'Africa', 'Asia', 'Europe', 'North America', 'South America', 'Oceania'};
lat_min = [-35, -10, 35, 5, -55, -50];
lat_max = [37, 81, 71, 83, 13, -10];
lon_min = [-18, 25, -10, -169, -81, 110];
lon_max = [51, 190, 40, -52, -35, 180];

% Define the range and bin size of fatality_count per event
f_min = 1;
f_max = 2100;
f_bin = 10;

% Define the colors for each continent
colors = {'r','g','b','c','m','y'};

% Initialize a figure to plot the F-N curves
figure
hold on

% Loop through the continents and plot their F-N curves
for j = 1:length(continents)
    % Filter the data set by the continent
    data_c = data(data.latitude >= lat_min(j) & data.latitude <= lat_max(j) & data.longitude >= lon_min(j) & data.longitude <= lon_max(j),:);
    
    % Calculate the frequency and cumulative frequency of events for each bin of fatality_count
    [f,f_edges] = histcounts(data_c.fatality_count,f_min:f_bin:f_max);
    F = cumsum(f);
    
    % Plot the F-N curve using a log-log scale
    loglog(f_edges(2:end),F,'Color',colors{j},'DisplayName',continents{j})
end

% Add labels and legend to the plot
xlabel('Number of fatality_count per event (N)')
ylabel('Cumulative frequency of events (F)')
legend('Location','southwest')
title('F-N curves for landslides from different continents')
grid on
hold off
