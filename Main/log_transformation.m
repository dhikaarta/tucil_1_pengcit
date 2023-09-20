function logTransformedImage = log_transformation(image, c)
    if size(image, 3) == 1
        % Grayscale image
        logTransformedImage = c * log((1 + double(image)));
    else
        % Color (RGB) image
        logTransformedImage = double(image);
        for channel = 1:3
            logTransformedImage(:,:,channel) = c * log((1 + logTransformedImage(:,:,channel)));
        end
    end

    logTransformedImage = uint8(logTransformedImage);
end