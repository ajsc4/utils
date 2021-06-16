
clear; 

addpath 'S:\Images'
info = imfinfo('S:\Images\20210610_fluorospheresandfocalchecks_flow_50mBar_1.01ms_exposure_1in5000dilution_extraresistance165um_widefield00012.tif');
imdescr = info.ImageDescription; frameinterval = str2double(imdescr(:, 58:66)); %position of string in custom metadata
pixelsize = 330E-9;
stack = tiffstackread('S:\Images\20210610_fluorospheresandfocalchecks_flow_50mBar_1.01ms_exposure_1in5000dilution_extraresistance165um_widefield00012.tif');
%%

peaks2 = FastPeakFind(stack(:,:,81), 400);
p_coords = [peaks(1:2:end), peaks(2:2:end)];

figure();imshow(stack(:,:,81), []); hold on; 
plot(peaks2(1:2:end), peaks2(2:2:end), 'r+'); hold off

for i = 1:numel(stack(1,1,:))
    
    peakstemp = FastPeakFind(stack(:,:,i), 400);
    peaks{:,i} = peakstemp;
    p_coords{i} = [peaks{i}(1:2:end), peaks{i}(2:2:end)];

end

pcoordsnew(1,:) = p_coords(~cellfun(@isempty, p_coords)); %filtering out frames without any peaks detected
pcoordsnewindices = find(~cellfun(@isempty, p_coords) == 1); %keeping track of the original indices from the stack 

for h = 45%1:numel(stack(:,1,1))

    for k = 1:numel(pcoordsnew)
        index{k} = find([pcoordsnew{k}(:,2) == h]); %finds all instances of peak at particular y-coordinate (bead moving horizontally)
    end
    
    if any(cell2mat(cellfun(@length,index,'uni',false)) > 1) == 1 %check if any more than two localisations along same y-value
        continue
    else
    if isempty(find(~cellfun(@isempty, index) == 1)) == 1 %check if array is empty
        continue
    else
        
   
        for j = 1:numel(index)
            y_value{j} = pcoordsnew{1,j}(index{1,j},1);
        end

        y_valuesnew = cell2mat(y_value(~cellfun(@isempty, y_value)));
        y_diffs = diff(y_valuesnew);
%         figure; 
%         scatter(1:numel(y_diffs), y_diffs);

        y_diffsfiltered = y_diffs(y_diffs > 0 & y_diffs < 30);
        mean_ydiff = mean(y_diffsfiltered);
    end
    end
end






