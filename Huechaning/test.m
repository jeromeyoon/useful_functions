% clear all
% clc
% close all

 I1 = imread('/research1/db/KITTI/kitti_flow/training/colored_0/000000_10.png');
I2 = imread('/research1/db/KITTI/kitti_flow/training/colored_1/000000_10.png');
%I1 = view1;
%I2 = view5;

disparityRange = [0 64];
disparityMap1 = disparity(rgb2gray(I1),rgb2gray(I2),'BlockSize',15,'DisparityRange',disparityRange);

figure;
imshow(disparityMap1, disparityRange);
title('Disparity Map');
colormap jet
colorbar

ConvertImages = HueChange(im2double(I1) ,[size(I1,1),size(I1,2)]);
figure; imshow(ConvertImages{1})
Ic1 = im2uint8(ConvertImages{1});

ConvertImages = HueChange(im2double(I2) ,[size(I1,1),size(I1,2)]);
figure; imshow(ConvertImages{4})
Ic2 = im2uint8(ConvertImages{4});


disparityMap2 = disparity(rgb2gray(I1),rgb2gray(Ic2),'BlockSize',15,'DisparityRange',disparityRange);

figure;
imshow(disparityMap2, disparityRange);
title('Disparity Map');
colormap jet
colorbar