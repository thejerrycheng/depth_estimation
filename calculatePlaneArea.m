function area = calculatePlaneArea(model, inlierIndices, ptCloud)
    % Extract inlier points
    inlierPoints = ptCloud.Location(inlierIndices, :);

    % Plane coefficients
    planeEq = model.Parameters;

    % Normal vector of the plane
    normal = planeEq(1:3);

    % A point on the plane (assuming C is not zero)
    if normal(3) ~= 0
        pointOnPlane = [0, 0, -planeEq(4)/planeEq(3)];
    elseif normal(2) ~= 0
        pointOnPlane = [0, -planeEq(4)/planeEq(2), 0];
    else
        pointOnPlane = [-planeEq(4)/planeEq(1), 0, 0];
    end

    % Project inlier points onto the plane
    projectedPoints = inlierPoints - dot((inlierPoints - pointOnPlane), normal) .* normal;

    % Choose dimension to drop for 2D projection
    [~, dimToDrop] = min(abs(normal));
    projectedPoints2D = projectedPoints(:, setdiff(1:3, dimToDrop));

    % Compute the convex hull
    convHullIndices = convhull(projectedPoints2D);
    convHullPoints = projectedPoints2D(convHullIndices, :);

    % Calculate the area of the convex hull
    area = polyarea(convHullPoints(:, 1), convHullPoints(:, 2));
end
