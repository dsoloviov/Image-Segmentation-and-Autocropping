%% Image segmentation

%% Segmentation
% Performs batch or single image segmentation 
% using the predefined threshold value.
%
% Location argument is specified as _dir('*.jpg')_ in
% case of folder or _filename_ in case of single file.
function segmentation(location, threshold)
    for file = 1:length(location)
        display(strcat('Processing: ', location(file).name))
        if not(isempty(location))
            simple_segmentation(location(file).name, threshold)
        end
    end
end

%% Simple image segmentation
% Performs simple image segmentation
% based on provided threshold
function simple_segmentation(filename, threshold)
    i = imread(filename);
    bw = rgb2gray(i) < threshold;
    n = i .* repmat(uint8(bw), [1, 1, 3]);
    imwrite(n, strcat('segm_', filename));
end