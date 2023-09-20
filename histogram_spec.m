function specifiedImage = histogram_spec(image, reference)
    channelCount = size(image, 3); % Assuming reference channel is the same
    
    histInput = zeros(256, channelCount);
    histReference = zeros(256, channelCount);

    % Calculating histograms
    [height, width, ~] = size(image);
    for i = 1:height
        for j = 1:width
            for k = 1:channelCount
                intensityReference = reference(i,j,k);
                intensityInput = image(i,j,k);
                histReference(intensityReference + 1, k) = histReference(intensityReference + 1, k) + 1;
                histInput(intensityInput + 1, k) = histInput(intensityInput + 1, k) + 1; 
            end
        end
    end
    

    cdfReference = cumsum(histReference, 1);
    cdfInput = cumsum(histInput, 1);

    lut = zeros(256, channelCount);

    for i = 1:256
        for j = 1:channelCount
            [~, index] = min(abs(cdfReference(:,j) - cdfInput(i, j)));
            lut(i, j) = index - 1;
        end
    end


    specifiedImage = zeros(size(image), 'uint8');
    for i = 1:height
        for j = 1:width
            for k = 1:channelCount
                specifiedImage(i,j,k) = lut(image(i,j,k), k);
            end
        end
    end
end