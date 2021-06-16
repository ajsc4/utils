function [averageRadialProfile] = radial_profile(volume)

[rows, columns, planes] = size(volume);

% Find the average radial profile of an image from a center location specified by the user.

profileSums = zeros(1, rows); 
profileCounts = zeros(1, rows); 


for column = 1 : columns
	for row = 1 : rows
        for depth = 1 : planes
            thisDistance = round(sqrt((row-(rows/2))^2 + (column-(columns/2))^2 + (depth-(planes/2))^2));
            if thisDistance <= 0
                continue;
            end
            profileSums(thisDistance) = profileSums(thisDistance) + double(volume(row, column, depth));
            profileCounts(thisDistance) = profileCounts(thisDistance) + 1;
        end
	end
end

% Divide the sums by the counts at each distance to get the average profile
averageRadialProfile = profileSums ./ profileCounts;


% We want to have the circles over the image be at the same distances as the grid lines along the x axis.
% Get the tick marks along the x axis

