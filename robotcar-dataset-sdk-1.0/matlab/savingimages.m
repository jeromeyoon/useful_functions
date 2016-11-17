clear all;  
close all;
savepath = '/research2/Oxford_png';
mainpath = '/research2/Oxford_data';
LUT_left_file = '../camera_model/stereo_wide_left_distortion_lut.bin';
LUT_right_file = '../camera_model/stereo_wide_right_distortion_lut.bin';

lut_file = fopen(LUT_left_file);
LUT_left = fread(lut_file, 'double');
LUT_left = reshape(LUT_left, [numel(LUT_left)/2, 2]);
fclose(lut_file);
lut_file = fopen(LUT_right_file);
LUT_right = fread(lut_file, 'double');
LUT_right = reshape(LUT_right, [numel(LUT_right)/2, 2]);
fclose(lut_file);

folders = dir(mainpath);

for i =3:length(folders)
    fprintf('processing %d/%d \n',i,length(folders));
    leftpath = fullfile(mainpath,folders(i).name,'stereo/left');
    rightpath = fullfile(mainpath,folders(i).name,'stereo/right');
    leftfiles = dir(fullfile(leftpath,'*.png'));
    rightfiles = dir(fullfile(rightpath,'*.png'));
    
    if (length(leftfiles) == length(rightfiles))
        for j = 100:length(leftfiles)
            image = demosaic(imread(fullfile(leftpath,leftfiles(j).name)), 'gbrg');
            image = UndistortImage(image, LUT_left);
            if ~exist(fullfile(savepath,folders(i).name,'stereo/left'))
                mkdir(fullfile(savepath,folders(i).name,'stereo/left'))
                mkdir(fullfile(savepath,folders(i).name,'stereo/right'))
            end
            imwrite(image,fullfile(savepath,folders(i).name,'stereo/left',leftfiles(j).name));
            
            image = demosaic(imread(fullfile(rightpath,rightfiles(j).name)), 'gbrg');
            image = UndistortImage(image, LUT_right);
            imwrite(image,fullfile(savepath,folders(i).name,'stereo/right',rightfiles(j).name));
        end
        
        
            
          
    end
end
    