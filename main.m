%% Image segmentation and cropping
% Performs automated image segmentation and cropping.
% Processes images inside the \input folder and inside all
% subfolders within \input folder.
function main()
    addpath(fullfile(pwd, 'src'));
    import segmentation.*
    import autocrop.*

    cd('input');
    input_content = dir();
    input = pwd;
    % Cover the case of subfolders
    for i = 1:length(input_content)
        file = input_content(i).name;
        if isdir(file)
            try
                cd(file);
                segmentation(dir('*.jpg'));
                %segmentation(dir('*.jpg'), 210);
                autocrop(dir('segm*.jpg'));
                cd(input);
            catch
            end
        end
    end
    cd('..');
end
