function flippedImage = pos_to_neg(image)
    % Check if image grayscale or RGB
    if size(image, 3) == 1
        % Grayscale image
        flippedImage = 255-image;
    else
        % Color (RGB) image
       flippedImage = double(image);
        for channel = 1:3
            flippedImage(:,:,channel) = 255 - flippedImage(:,:,channel);
        end
    end
    flippedImage = uint8(flippedImage);
end
     