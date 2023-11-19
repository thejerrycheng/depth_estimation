% Point CLoud 3D Plane Fitting 
clear all;
clc; 


%% Loading the point cloud file:

data = load('point_cloud.mat');
point_cloud = data.point_cloud;

% visualize the point cloud data:

% Assuming extracted_point_cloud is your point cloud data
x = point_cloud(:, 1);  % X coordinates
y = point_cloud(:, 2);  % Y coordinates
z = point_cloud(:, 3);  % Z coordinates

% Create a 3D scatter plot
scatter3(x, y, z, 3);  % '3' here sets the marker size

% Label the axes
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');

% Optionally, you can add grid, title or change other plot properties
grid on;
title('3D Point Cloud Visualization');

%% Plane Extraction Here:
ptCloud = pointCloud(point_cloud);  % Convert to pointCloud object

maxDistance = 4;
% referenceVector = [0,0,1];
maxAngularDistance = 5;

[model1, inlierIndices, outlierIndices] = pcfitplane(ptCloud, maxDistance);
plane1 = select(ptCloud, inlierIndices);
remainPtCloud = select(ptCloud, outlierIndices);

% Now move on to the second plane: 
roi = [-inf,inf;0.4,inf;-inf,inf];
sampleIndices = findPointsInROI(remainPtCloud,roi);

[model2, inlierIndices, outlierIndices] = pcfitplane(remainPtCloud, maxDistance, SampleIndices=sampleIndices);
plane2 = select(remainPtCloud, inlierIndices);
remainPtCloud = select(remainPtCloud, outlierIndices);

% plot the extracted plane one and plane two

figure
pcshow(plane1)
title("First Plane")

figure
pcshow(plane2)
title("Second Plane")

figure
pcshow(remainPtCloud)
title("Remaining Point Cloud")

