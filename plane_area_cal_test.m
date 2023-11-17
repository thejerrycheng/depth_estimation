clear all;
clc;

[model, inlierIndices, ~] = pcfitplane(ptCloud, maxDistance);
area = calculatePlaneArea(model, inlierIndices, ptCloud);
disp(['Estimated area of the plane: ', num2str(area)]);
