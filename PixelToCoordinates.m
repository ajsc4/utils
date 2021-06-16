
%----------------------------------------------------
%Pixel to Coordinates.
%
%Author: M. Giorgi    email:mario_giorgi@hotmail.com
%Version: 1.0 | Production Version: 1
%
%
%This code transfrom pixels position into their centroid coordinates.
%It works with DICOM multislice images where each voxel is a cube.
%This function take as INPUT: VoxDim=Voxel dimension in micron;
%name_mask='MaskName.dcm'.
%It provides as OUTPUT the xyz coordinates of each pixel centroid
%------------------------------------------------

function [nodedata]=nodesCoordinates(VoxDim, name_mask)

tic
[testpoints] = dicomread(name_mask);
Image_Resolution=VoxDim/1000;
R=makerefmat(Image_Resolution/2,Image_Resolution/2,Image_Resolution,Image_Resolution);
c=[size(testpoints,1) size(testpoints,2) size(testpoints,4)];
idx = find(testpoints(:,:,:)>0);
[Row_ID,Col_ID Z_ID] = ind2sub(c, idx);
[x_mask,y_mask] = pix2map(R,Row_ID,Col_ID);
z_mask=Z_ID(:,1)*Image_Resolution-Image_Resolution;
n_nodes=(1:size(z_mask))';
nodedata=[n_nodes x_mask y_mask z_mask];
toc
%------------------------------------------------