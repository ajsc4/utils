
function [outtiffstack] = tiffstackread(tiffstack)

tifinfo = imfinfo(tiffstack);

tiff_stack = imread(tiffstack, 1) ; % read in first image
%concatenate each successive tiff to tiff_stack
    for ii = 2 : size(tifinfo, 1)
        temp_tiff = imread(tiffstack, ii);
        tiff_stack = cat(3 , tiff_stack, temp_tiff);
    end
outtiffstack = tiff_stack;
end