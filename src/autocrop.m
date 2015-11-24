%% Image Autocrop

%% Autocrop
% Performs batch or single image cropping.
%
% Location argument is specified as _dir('segm_*.jpg')_ in
% case of folder or _filename_ in case of single file.
function autocrop(location)
    for file = 1:length(location)
        display(strcat('Processing: ', location(file).name))
        if not(isempty(location))   
            crop(location(file).name)
        end
    end
end

%% Crop
% Performs automated cropping of segmented image
function crop(filename)
    i = imread(filename);
    g = rgb2gray(i);
    object = bwlabel(g > 40);
    info = regionprops(object);
    m = max([info(:).Area]); % find max occupied area
    index = find([info.Area] == m); % find an index of max occupied area
    rect = info(index).BoundingBox;
    i2 = imcrop(i, rect);
    imwrite(i2, strcat('crop_', filename));
end
