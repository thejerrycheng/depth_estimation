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

%% Here is the point cloud 3D plane fitting

ptCloud = pointCloud(point_cloud);  % Convert to pointCloud object

maxDistance = 1;  % Maximum distance of points to plane for them to be considered inliers
% referenceVector = [0, 0, 1];  % A reference vector to guide the orientation of the plane

numPlanes = 10;  % Number of planes to fit
planes = cell(numPlanes, 1);  % Cell array to store plane models
numFittedPlanes = 0;

while numFittedPlanes < numPlanes
    [model, inlierIndices, ~] = pcfitplane(ptCloud, maxDistance);
    
    % Check if a plane was found
    if isempty(model)
        break;  % Exit if no more planes can be fitted
    end

    % Extract the normal vector for the current plane
    normalCurrent = model.Parameters(1:3);

    % Check the angle with previous planes
    isNewPlane = true;
    for j = 1:numFittedPlanes
        normalPrevious = planes{j}.Parameters(1:3);
        angle = acosd(dot(normalCurrent, normalPrevious) / (norm(normalCurrent) * norm(normalPrevious)));
        if angle < 30 || angle > 150  % Check the angle
            distance = abs(dot(normalCurrent, planes{j}.Parameters(1:3)) + planes{j}.Parameters(4)) / norm(normalCurrent);
            if distance < 50  % Check the distance
                isNewPlane = false;
                break;
            end
%         else 
%             distance = abs(dot(normalCurrent, planes{j}.Parameters(1:3)) + planes{j}.Parameters(4)) / norm(normalCurrent);
%             if distance < 50  % Check the distance
%                 isNewPlane = false;
%                 break;
%             end
        end

    end

    % Add the plane if it is sufficiently different
    if isNewPlane
        numFittedPlanes = numFittedPlanes + 1;
        planes{numFittedPlanes} = model;
        remainingIndices = true(ptCloud.Count, 1);  % Create a logical array of 'true' values
        remainingIndices(inlierIndices) = false;    % Set the inliers to 'false'
       
        % Now select the remaining points
        ptCloud = select(ptCloud, remainingIndices);  % This should match the size of the point cloud
    end
end

planes = planes(1:numFittedPlanes);  % Trim the cell array



figure;
pcshow(ptCloud);
hold on;

for i = 1:length(planes)
    model = planes{i};
    plot(model)
    % You can plot the plane model using `plot(model)` or other visualization techniques
    % This might involve creating a meshgrid and evaluating the plane equation
end

xlabel('X');
ylabel('Y');
zlabel('Z');
title('Point Cloud with Fitted Planes');
hold off;
