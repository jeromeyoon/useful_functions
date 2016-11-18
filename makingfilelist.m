clear all;
close all;
mainpath ='/research2/Oxford_png';
folders  = dir(mainpath);
leftname ='Oxford_left.txt';
rightname ='Oxford_right.txt';
foldername = 'Oxford_folder.txt';
fl = fopen(leftname,'w');
fr = fopen(rightname,'w');
fname = fopen(foldername,'w');
for i=3:length(folders)
        Leftimgs = dir(fullfile(mainpath,folders(i).name,'stereo/left/*.png'));
        Rightimgs = dir(fullfile(mainpath,folders(i).name,'stereo/right/*.png'));
        if(length(Leftimgs) == length(Rightimgs))
            
            for j =1:length(Leftimgs)
                fprintf(fname,'%s \n',fullfile(mainpath,folders(i).name));
                fprintf(fl,'%s \n',Leftimgs(j).name);
                fprintf(fr,'%s \n',Rightimgs(j).name);
            end
        end
            
            
end
fclose(fl);
fclose(fr);
fclose(fname);