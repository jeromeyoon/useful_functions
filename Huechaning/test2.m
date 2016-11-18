I1 = imread('/research1/db/KITTI/kitti_flow/training/colored_0/000000_10.png');
I2 = imread('/research1/db/KITTI/kitti_flow/training/colored_1/000000_10.png');
I1 = im2double(I1);
I2 = im2double(I2);
T = rand(3,3);
T = T./norm(T);
P1 = reshape(I1,size(I1,1) * size(I1,2),3) *T';
P2 = reshape(I1,size(I2,1) * size(I2,2),3) *T';
Result1 = reshape(P1,size(I1,1),size(I1,2),3);
Result2 = reshape(P2,size(I2,1),size(I2,2),3);
figure;imshow(Result1);
figure;imshow(rgb2gray(Result1));

imwrite(rgb2gray(Result1),'newL.png');
imwrite(rgb2gray(Result2),'newR.png');