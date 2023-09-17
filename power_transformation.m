function powerTransformedImage = power_transformation(image, c, gamma)
    % Check if image is grayscale or RGB
    if size(image, 3) == 1
        % Grayscale image
        image = double(image);
        % Normalize pixels
        image = image / 255.0;
        powerTransformedImage = c * (image.^gamma);
    else
        % Color (RGB) image
        powerTransformedImage = double(image) / 255.0; % Normalize pixels 
        for channel = 1:3
            powerTransformedImage(:,:,channel) = c * (powerTransformedImage(:,:,channel).^gamma);
        end
    end
    
    % Scale back 
    powerTransformedImage = uint8(powerTransformedImage * 255);
end
