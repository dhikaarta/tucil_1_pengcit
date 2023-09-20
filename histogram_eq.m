function equalizedImage = histogram_eq(image)
    channelCount = size(image, 3);

    % Count histogram 
    histim = zeros(256,1);
    [height, width,~] = size(image);

    for i = 1:height
        for j = 1:width
            for k = 1:channelCount
                pixelValue = image(i,j,k);
                histim(pixelValue + 1) = histim(pixelValue + 1) + 1;
            end
        end
    end

    % Count cumulative distribution function
    cdf = cumsum(histim);
    
    % Normalize
    cdf = cdf / numel(image);

    % Recreating equalized image
    equalizedImage = zeros(size(image), 'uint8');
    for i = 1:height
        for j = 1:width
            for k = 1:channelCount
                pixelValue = image(i,j,k);
                equalizedImage(i,j,k) = round(255 * cdf(pixelValue + 1));
            end
        end
    end
end