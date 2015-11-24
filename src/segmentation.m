%% Image segmentation

%% Segmentation
% Performs batch or single image segmentation.
%
% Location argument is specified as _dir('*.jpg')_ in
% case of folder or _filename_ in case of single file.
function segmentation(location)
%function segmentation(location, threshold)
    for file = 1:length(location)
        display(strcat('Processing: ', location(file).name))
        if not(isempty(location))
            segmentation_wo_threshold(location(file).name)
            %segmentation_w_threshold(location(file).name, threshold)
        end
    end
end

%% Segmentation without threshold
% Performs simple image segmentation
% using the calculated threshold.
function segmentation_wo_threshold(filename)
    i = imread(filename);
    gray = rgb2gray(i);
    s = size(gray);
    % Calculate the mean intensity for 4 small 
    %rectangles in the corner of image
    r1 = mean2(imcrop(gray, [0,0,200,200]));
    r2 = mean2(imcrop(gray, [0, s(1) - 200, 200, 200]));
    r3 = mean2(imcrop(gray, [s(2) - 200, 0, 200, 200]));
    r4 = mean2(imcrop(gray, [s(2) - 200, s(1) - 200, 200, 200]));
    threshold = mean2([r1, r2, r3, r4]);
    % Perform the segmentation
    bw = gray < threshold;
    % Fill the holes
    bw = imfill(bw, 'holes');
    n = i .* repmat(uint8(bw), [1, 1, 3]);
    imwrite(n, strcat('segm_wo_', filename));
end

%% Segmentation with threshold
% Performs simple image segmentation
% using the predefined threshold.
function segmentation_w_threshold(filename, threshold)
    i = imread(filename);
    bw = rgb2gray(i) < threshold;
    n = i .* repmat(uint8(bw), [1, 1, 3]);
    imwrite(n, strcat('segm_w_', filename));
end