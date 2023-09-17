function stretchedImage = contrast_stretching(inputImage)
    % Check if image is grayscale or RGB
    if size(inputImage, 3) == 1
        % Grayscale image

        % Find min and max pixel value
        min_val = min(inputImage(:));
        max_val = max(inputImage(:));
        
        x = inputImage - min_val;
        y = max_val - min_val;
        
        stretchedImage = x * (255 / y);
        
    else
        % Color (RGB) image
        stretchedImage = double(inputImage);
        for channel = 1:3
            % Find min and max pixel value each R,G,B
            individualMatrix = stretchedImage(:,:,channel);
            min_val = min(individualMatrix(:));
            max_val = max(individualMatrix(:));

            disp(min_val)
            disp(max_val)
            
            x = stretchedImage(:,:,channel) - min_val;
            y = max_val - min_val;
 
            stretchedImage(:,:,channel) = x * (255 / y);
        end
    end

    % Convert to Int
    stretchedImage = uint8(stretchedImage);
end
