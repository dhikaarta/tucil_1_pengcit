function brightenedImage = image_brightening(image, a, b)
    % Check apakah image grayscale atau RGB
    if size(image, 3) == 1
        % Grayscale image
        brightenedImage = a * double(image) + b;
    else
        % Color (RGB) image
        brightenedImage = double(image);
        for channel = 1:3
            brightenedImage(:,:,channel) = a * brightenedImage(:,:,channel) + b;
        end
    end

    % Clamp value 
    brightenedImage(brightenedImage > 255) = 255;
    brightenedImage(brightenedImage < 0) = 0;

    % Convert the result to uint8 data type
    brightenedImage = uint8(brightenedImage);
end

