function show_histogram (image)
    %switch based on size of image channels
    switch size(image,3)
        case 1
            %initialize an array of zeros that will store count for
            %graylevel
            pixelCount = zeros(1,256);
            for i = 1:size(image,1)
                for j = i:size(image, 2)
                    %get pixel value for the pixel in coordinates (i,j)
                    grayLevel = double(image(i,j) + 1);
                    %increment the corresponding count in the array
                    pixelCount(grayLevel) = pixelCount(grayLevel) + 1;
                end
            end
            titleText = 'Histogram for Grayscale Image';
        case 3
        % Same but for RGB image, so have 3 channel
            pixelCount = zeros(256, 3);
            for i = 1:size(image, 1)
                for j = 1:size(image, 2)
                    for channel = 1:3
                        grayLevel = double(image(i, j, channel) + 1);
                        pixelCount(grayLevel, channel) = pixelCount(grayLevel, channel) + 1;
                    end
                end
            end
            titleText = 'Histogram for Color Image';
    end
    figure;
    if size(image, 3) == 1
        bar(pixelCount);
        xlabel('Gray Level');
        ylabel('Frequency');
    else
        bar(pixelCount(:, 1), 'r');
        hold on;
        bar(pixelCount(:, 2), 'g');
        bar(pixelCount(:, 3), 'b');
        xlabel('Gray Level');
        ylabel('Frequency');
        legend('Red', 'Green', 'Blue');
    end
    title(titleText);
    
end

