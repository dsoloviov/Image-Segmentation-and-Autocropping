%% Autocrop
% Performs batch or single image cropping.
%
% Location argument is specified as _dir('segm_*.jpg')_ in
% case of folder or _filename_ in case of single file.
function autocrop(location)
    try
        for file = 1:length(location)
            display(strcat('Processing: ', location(file).name))
            if not(isempty(location))
                batch_autocrop(location(file).name)
            end
        end
    catch
        display(strcat('Processing: ', location))
        batch_autocrop(location)
    end
end

%% Batch autocrop
% Performs automated cropping of segmented image
function batch_autocrop(filename)
    % Find the xmin and ymin values of cropping rectangle
    i = imread(filename);
    g = rgb2gray(i);
    isize = size(g);

    % Calculate ymin value for crop rectangle
    for row = 1:isize(1)
        %display(g(row, :)); % display row
        x = g(row, :);
        if sum(x) ~= 0 && sum(x) > 5000 % TODO: fix it
            irow = row; % non-zero row index (y for crop rectangle)
            break
        end
    end

    % Calculate xmin value for crop rectangle
    for column = 1:isize(2)
        y = g(:, column);
        if sum(y) ~= 0 && sum(y) > 5000 % TODO: fix it
            icolumn = column; % non-zero column index (x for crop rectangle)
            break
        end
    end
    rect = [icolumn, irow, isize(2), isize(1)];
    i2 = imcrop(i, rect);
    imwrite(i2, 'temp.jpg');

    % Find the height and width values of cropping rectangle
    temp = imread('temp.jpg');
    g = rgb2gray(temp);
    isize = size(g);

    % Calculate height value for crop rectangle
    for row = 1:isize(1)
        x = g(row, :);
        if sum(x) == 0
            height = row; % zero row index (y for crop rectangle)
            break
        end
    end

    % Calculate width value for crop rectangle
    for column = 1:isize(2)
        y = g(:, column);
        if sum(y) == 0
            width = column; % zero column index (x for crop rectangle)
            break
        end
    end

    rect = [icolumn, irow, width, height];
    i2 = imcrop(i, rect);
    imwrite(i2, strcat('crop_', filename));
    delete('temp.jpg');
end
