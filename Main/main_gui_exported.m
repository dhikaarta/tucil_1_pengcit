%IGNORE THIS PAGE, ini cuman hasil export GUI biar ga binary doang.
%gapenting



classdef main_gui_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        Menu                  matlab.ui.container.Menu
        RightPanel            matlab.ui.container.Panel
        ReferenceLabel        matlab.ui.control.Label
        LoadImageButton       matlab.ui.control.Button
        RedAxes_11            matlab.ui.control.UIAxes
        RedAxes_10            matlab.ui.control.UIAxes
        RedAxes_9             matlab.ui.control.UIAxes
        ImageReference        matlab.ui.control.UIAxes
        CenterPanel           matlab.ui.container.Panel
        OutputLabel           matlab.ui.control.Label
        output_blue           matlab.ui.control.UIAxes
        output_green          matlab.ui.control.UIAxes
        output_red            matlab.ui.control.UIAxes
        ImageOutput           matlab.ui.control.UIAxes
        LeftPanel             matlab.ui.container.Panel
        InputLabel            matlab.ui.control.Label
        EditField_2           matlab.ui.control.NumericEditField
        bEditFieldLabel       matlab.ui.control.Label
        EditField_1           matlab.ui.control.NumericEditField
        aEditFieldLabel       matlab.ui.control.Label
        GOButton              matlab.ui.control.Button
        DropDown              matlab.ui.control.DropDown
        DropDownLabel         matlab.ui.control.Label
        LoadInputImageButton  matlab.ui.control.Button
        ImageInput            matlab.ui.control.UIAxes
        input_blue            matlab.ui.control.UIAxes
        input_green           matlab.ui.control.UIAxes
        input_red             matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        InputImage 
    end

    % Methods that control component visibility
    methods (Access = private) 
        
        function histogramSpecs(app)
            app.CenterPanel.Enable = 'off';
            app.RightPanel.Enable = 'off';

            app.EditField_1.Visible ='off';
            app.EditField_2.Visible ='off';
            
            app.aEditFieldLabel.Visible = 'off';
            app.bEditFieldLabel.Visible = 'off';
        end
        
        function oneInputSpecs(app, input1)
            app.CenterPanel.Enable = 'on';
            app.RightPanel.Enable = 'off';

            app.EditField_1.Visible ='on';
            app.EditField_2.Visible ='off';
            
            app.aEditFieldLabel.Visible = 'on';
            app.bEditFieldLabel.Visible = 'off';

            app.aEditFieldLabel.Text = input1;
        end
            
        function twoInputSpecs(app, input1, input2)
            app.CenterPanel.Enable = 'on';
            app.RightPanel.Enable = 'off';

            app.EditField_1.Visible ='on';
            app.EditField_2.Visible ='on';
            
            app.aEditFieldLabel.Visible = 'on';
            app.bEditFieldLabel.Visible = 'on';

            app.aEditFieldLabel.Text = input1;
            app.bEditFieldLabel.Text = input2;
        end

        function noInputSpecs(app)
            app.CenterPanel.Enable = 'on';
            app.RightPanel.Enable = 'off';

            app.EditField_1.Visible ='off';
            app.EditField_2.Visible ='off';
            
            app.aEditFieldLabel.Visible = 'off';
            app.bEditFieldLabel.Visible = 'off';
        end

        function histogramSpecSpecs(app)
            app.CenterPanel.Enable = 'on';
            app.RightPanel.Enable = 'on';

            app.EditField_1.Visible ='off';
            app.EditField_2.Visible ='off';
            
            app.aEditFieldLabel.Visible = 'off';
            app.bEditFieldLabel.Visible = 'off';
        end
    end
    
    %Image Methods
    methods (Access = public)

        %Function to show image
        function showImage(app, image, imageAxes, histogramR, histogramG, histogramB)
            switch size(image,3)
                case 1
                    % Display the grayscale image
                    imshow(image, 'Parent', imageAxes,'XData', [1 imageAxes.Position(3)],'YData', [1 imageAxes.Position(4)]);
                    [~, pixelCount] = show_histogram(image);
                    
                    
                    histogramG.Visible = "off";
                    histogramB.Visible = "off";
                    
                    histogramR.Title.String = "Grey Level";

                    bar(histogramR, pixelCount, "black")
                case 3
                    % Display the truecolor image
                    imshow(image, 'Parent', imageAxes,'XData', [1 imageAxes.Position(3)],'YData', [1 imageAxes.Position(4)]);
                    [~, pixelCount] = show_histogram(image);

                    histogramR.Visible = "on";
                    histogramB.Visible = "on";
                    % Plot the histograms
                    bar(histogramR,pixelCount(:, 1), 'r')
                    bar(histogramG,pixelCount(:, 2), 'g')
                    bar(histogramB,pixelCount(:, 3), 'b')
                otherwise
                    % Error when image is not grayscale or truecolor
                    uialert(app.UIFigure,"Image must be grayscale or truecolor.","Image Error");
                    return;
            end
        end

        %Function to updateImage
        function updateImage(app,imagefile)
                try
                    im = imread(imagefile);
                catch ME
                    % If problem reading image, display error message
                    uialert(app.UIFigure,ME.message,"Image Error");
                    return;            
                end 
                app.InputImage = im;
            
            % Create histograms based on number of color channels
            showImage(app, im, app.ImageInput, app.input_red, app.input_green, app.input_blue)   
        end
        
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.CenterPanel.Enable = 'off';
            app.RightPanel.Enable = 'off';

            app.EditField_1.Visible ='off';
            app.EditField_2.Visible ='off';
            
            app.aEditFieldLabel.Visible = 'off';
            app.bEditFieldLabel.Visible = 'off';
        end

        % Value changed function: DropDown
        function DropDownValueChanged(app, event)
            value = app.DropDown.Value;
            switch value
                case 'Show Histogram'
                    histogramSpecs(app);
                case 'Image Brightening'
                    twoInputSpecs(app, 'a', 'b')
                case 'Pos to Neg'
                    noInputSpecs(app)
                case 'Neg to Pos'
                    noInputSpecs(app)
                case 'Log Transform'
                    oneInputSpecs(app, 'c')
                case 'Power Transform'
                    twoInputSpecs(app, 'c', 'y')
                case 'Contrast Stretching'
                    noInputSpecs(app)
                case 'Histogram Eq'
                    noInputSpecs(app)
                case 'Histogram Spec'
                    histogramSpecSpecs(app)
                otherwise
                
            end
        end

        % Drop down opening function: DropDown
        function DropDownOpening(app, event)
            
        end

        % Button pushed function: LoadInputImageButton
        function LoadInputImageButtonPushed(app, event)
            % Display uigetfile dialog
            filterspec = {'*.jpg;*.tif;*.png;*.bmp','All Image Files'};
            [file, path] = uigetfile(filterspec);
            
            % Make sure user didn't cancel uigetfile dialog
            if (ischar(path))
               fname = [path file];
               updateImage(app,fname);
            end
        end

        % Button pushed function: LoadImageButton
        function LoadImageButtonPushed(app, event)
            % Display uigetfile dialog
            filterspec = {'*.jpg;*.tif;*.png;*.bmp','All Image Files'};
            [file, path] = uigetfile(filterspec);
            
            % Make sure user didn't cancel uigetfile dialog
            if (ischar(path))
               fname = [path file];
               updateImage(app,fname);
            end
        end

        % Button pushed function: GOButton
        function GOButtonPushed(app, event)
            dropdownValue = app.DropDown.Value;
            if(strcmp(dropdownValue, "Image Brightening"))
                a = app.EditField_1.Value;
                b = app.EditField_2.Value;

                brightenedImage = image_brightening(app.InputImage, a, b);
                showImage(app, brightenedImage, app.ImageOutput, app.output_red, app.output_green, app.output_blue)
            elseif(strcmp(dropdownValue, "Pos to Neg") || strcmp(dropdownValue, "Neg to Pos"))
                flippedImage = pos_to_neg(app.InputImage);
                showImage(app, flippedImage, app.ImageOutput, app.output_red, app.output_green, app.output_blue)
            elseif(strcmp(dropdownValue, "Log Transform"))
                c = app.EditField_1.Value;

                logTransformedImage = log_transformation(app.InputImage,c);
                showImage(app, logTransformedImage, app.ImageOutput, app.output_red, app.output_green, app.output_blue)
            elseif(strcmp(dropdownValue, "Power Transform"))
                c = app.EditField_1.Value;
                gamma = app.EditField_2.Value;

                powerTransformedImage = power_transformation(app.InputImage,c, gamma);
                showImage(app, powerTransformedImage, app.ImageOutput, app.output_red, app.output_green, app.output_blue)
            elseif(strcmp(dropdownValue, "Contrast Stretching"))
                stretchedImage = contrast_stretching(app.InputImage);
                showImage(app, stretchedImage, app.ImageOutput, app.output_red, app.output_green, app.output_blue)
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1090 737];
            app.UIFigure.Name = 'MATLAB App';

            % Create Menu
            app.Menu = uimenu(app.UIFigure);
            app.Menu.Text = 'Menu';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.UIFigure);
            app.LeftPanel.Position = [1 1 388 737];

            % Create input_red
            app.input_red = uiaxes(app.LeftPanel);
            title(app.input_red, 'Red')
            xlabel(app.input_red, 'Grey Level')
            ylabel(app.input_red, 'Frequency')
            app.input_red.XLim = [0 255];
            app.input_red.XTick = [0 128 255];
            app.input_red.XTickLabelRotation = 0;
            app.input_red.YTickLabelRotation = 0;
            app.input_red.ZTickLabelRotation = 0;
            app.input_red.Position = [87 296 211 127];

            % Create input_green
            app.input_green = uiaxes(app.LeftPanel);
            title(app.input_green, 'Green')
            xlabel(app.input_green, 'Grey Level')
            ylabel(app.input_green, 'Frequency')
            app.input_green.XLim = [0 255];
            app.input_green.XTick = [0 128 255];
            app.input_green.XTickLabelRotation = 0;
            app.input_green.YTickLabelRotation = 0;
            app.input_green.ZTickLabelRotation = 0;
            app.input_green.Position = [87 154 211 127];

            % Create input_blue
            app.input_blue = uiaxes(app.LeftPanel);
            title(app.input_blue, 'Blue')
            xlabel(app.input_blue, 'Grey Level')
            ylabel(app.input_blue, 'Frequency')
            app.input_blue.XLim = [0 255];
            app.input_blue.XTick = [0 128 255];
            app.input_blue.XTickLabelRotation = 0;
            app.input_blue.YTickLabelRotation = 0;
            app.input_blue.ZTickLabelRotation = 0;
            app.input_blue.Position = [87 13 211 127];

            % Create ImageInput
            app.ImageInput = uiaxes(app.LeftPanel);
            app.ImageInput.XTick = [];
            app.ImageInput.XTickLabelRotation = 0;
            app.ImageInput.XTickLabel = {'[ ]'};
            app.ImageInput.YTick = [];
            app.ImageInput.YTickLabelRotation = 0;
            app.ImageInput.ZTickLabelRotation = 0;
            app.ImageInput.Position = [19 442 218 216];

            % Create LoadInputImageButton
            app.LoadInputImageButton = uibutton(app.LeftPanel, 'push');
            app.LoadInputImageButton.ButtonPushedFcn = createCallbackFcn(app, @LoadInputImageButtonPushed, true);
            app.LoadInputImageButton.Position = [257 587 110 71];
            app.LoadInputImageButton.Text = 'Load Input Image';

            % Create DropDownLabel
            app.DropDownLabel = uilabel(app.LeftPanel);
            app.DropDownLabel.HorizontalAlignment = 'right';
            app.DropDownLabel.Position = [84 666 65 22];
            app.DropDownLabel.Text = 'Drop Down';

            % Create DropDown
            app.DropDown = uidropdown(app.LeftPanel);
            app.DropDown.Items = {'Show Histogram', 'Image Brightening', 'Pos to Neg', 'Neg to Pos', 'Log Transform', 'Power Transform', 'Contrast Stretching', 'Histogram Eq', 'Histogram Spec'};
            app.DropDown.DropDownOpeningFcn = createCallbackFcn(app, @DropDownOpening, true);
            app.DropDown.ValueChangedFcn = createCallbackFcn(app, @DropDownValueChanged, true);
            app.DropDown.Placeholder = 'Choose Function';
            app.DropDown.Position = [164 666 138 22];
            app.DropDown.Value = 'Show Histogram';

            % Create GOButton
            app.GOButton = uibutton(app.LeftPanel, 'push');
            app.GOButton.ButtonPushedFcn = createCallbackFcn(app, @GOButtonPushed, true);
            app.GOButton.Position = [279 460 67 27];
            app.GOButton.Text = 'GO!';

            % Create aEditFieldLabel
            app.aEditFieldLabel = uilabel(app.LeftPanel);
            app.aEditFieldLabel.HorizontalAlignment = 'right';
            app.aEditFieldLabel.Position = [266 551 25 22];
            app.aEditFieldLabel.Text = 'a';

            % Create EditField_1
            app.EditField_1 = uieditfield(app.LeftPanel, 'numeric');
            app.EditField_1.Position = [306 551 51 22];

            % Create bEditFieldLabel
            app.bEditFieldLabel = uilabel(app.LeftPanel);
            app.bEditFieldLabel.HorizontalAlignment = 'right';
            app.bEditFieldLabel.Position = [267 505 25 22];
            app.bEditFieldLabel.Text = 'b';

            % Create EditField_2
            app.EditField_2 = uieditfield(app.LeftPanel, 'numeric');
            app.EditField_2.Position = [307 505 51 22];

            % Create InputLabel
            app.InputLabel = uilabel(app.LeftPanel);
            app.InputLabel.FontWeight = 'bold';
            app.InputLabel.Position = [164 708 34 22];
            app.InputLabel.Text = 'Input';

            % Create CenterPanel
            app.CenterPanel = uipanel(app.UIFigure);
            app.CenterPanel.Position = [389 1 364 737];

            % Create ImageOutput
            app.ImageOutput = uiaxes(app.CenterPanel);
            app.ImageOutput.XTick = [];
            app.ImageOutput.XTickLabelRotation = 0;
            app.ImageOutput.XTickLabel = {'[ ]'};
            app.ImageOutput.YTick = [];
            app.ImageOutput.YTickLabelRotation = 0;
            app.ImageOutput.ZTickLabelRotation = 0;
            app.ImageOutput.Position = [73 451 218 216];

            % Create output_red
            app.output_red = uiaxes(app.CenterPanel);
            title(app.output_red, 'Red')
            xlabel(app.output_red, 'Grey Level')
            ylabel(app.output_red, 'Frequency')
            app.output_red.XLim = [0 255];
            app.output_red.XTick = [0 128 255];
            app.output_red.XTickLabelRotation = 0;
            app.output_red.YTickLabelRotation = 0;
            app.output_red.ZTickLabelRotation = 0;
            app.output_red.Position = [77 296 211 127];

            % Create output_green
            app.output_green = uiaxes(app.CenterPanel);
            title(app.output_green, 'Green')
            xlabel(app.output_green, 'Grey Level')
            ylabel(app.output_green, 'Frequency')
            app.output_green.XLim = [0 255];
            app.output_green.XTick = [0 128 255];
            app.output_green.XTickLabelRotation = 0;
            app.output_green.YTickLabelRotation = 0;
            app.output_green.ZTickLabelRotation = 0;
            app.output_green.Position = [77 154 211 127];

            % Create output_blue
            app.output_blue = uiaxes(app.CenterPanel);
            title(app.output_blue, 'Blue')
            xlabel(app.output_blue, 'Grey Level')
            ylabel(app.output_blue, 'Frequency')
            app.output_blue.XLim = [0 255];
            app.output_blue.XTick = [0 128 255];
            app.output_blue.XTickLabelRotation = 0;
            app.output_blue.YTickLabelRotation = 0;
            app.output_blue.ZTickLabelRotation = 0;
            app.output_blue.Position = [77 13 211 127];

            % Create OutputLabel
            app.OutputLabel = uilabel(app.CenterPanel);
            app.OutputLabel.FontWeight = 'bold';
            app.OutputLabel.Position = [161 708 44 22];
            app.OutputLabel.Text = 'Output';

            % Create RightPanel
            app.RightPanel = uipanel(app.UIFigure);
            app.RightPanel.Position = [752 1 338 737];

            % Create ImageReference
            app.ImageReference = uiaxes(app.RightPanel);
            app.ImageReference.XTick = [];
            app.ImageReference.XTickLabelRotation = 0;
            app.ImageReference.XTickLabel = {'[ ]'};
            app.ImageReference.YTick = [];
            app.ImageReference.YTickLabelRotation = 0;
            app.ImageReference.ZTickLabelRotation = 0;
            app.ImageReference.Position = [14 451 218 216];

            % Create RedAxes_9
            app.RedAxes_9 = uiaxes(app.RightPanel);
            title(app.RedAxes_9, 'Red')
            xlabel(app.RedAxes_9, 'Grey Level')
            ylabel(app.RedAxes_9, 'Frequency')
            app.RedAxes_9.XLim = [0 255];
            app.RedAxes_9.XTick = [0 128 255];
            app.RedAxes_9.XTickLabelRotation = 0;
            app.RedAxes_9.YTickLabelRotation = 0;
            app.RedAxes_9.ZTickLabelRotation = 0;
            app.RedAxes_9.Position = [64 296 211 127];

            % Create RedAxes_10
            app.RedAxes_10 = uiaxes(app.RightPanel);
            title(app.RedAxes_10, 'Red')
            xlabel(app.RedAxes_10, 'Grey Level')
            ylabel(app.RedAxes_10, 'Frequency')
            app.RedAxes_10.XLim = [0 255];
            app.RedAxes_10.XTick = [0 128 255];
            app.RedAxes_10.XTickLabelRotation = 0;
            app.RedAxes_10.YTickLabelRotation = 0;
            app.RedAxes_10.ZTickLabelRotation = 0;
            app.RedAxes_10.Position = [64 154 211 127];

            % Create RedAxes_11
            app.RedAxes_11 = uiaxes(app.RightPanel);
            title(app.RedAxes_11, 'Red')
            xlabel(app.RedAxes_11, 'Grey Level')
            ylabel(app.RedAxes_11, 'Frequency')
            app.RedAxes_11.XLim = [0 255];
            app.RedAxes_11.XTick = [0 128 255];
            app.RedAxes_11.XTickLabelRotation = 0;
            app.RedAxes_11.YTickLabelRotation = 0;
            app.RedAxes_11.ZTickLabelRotation = 0;
            app.RedAxes_11.Position = [64 13 211 127];

            % Create LoadImageButton
            app.LoadImageButton = uibutton(app.RightPanel, 'push');
            app.LoadImageButton.ButtonPushedFcn = createCallbackFcn(app, @LoadImageButtonPushed, true);
            app.LoadImageButton.Position = [242 517 87 71];
            app.LoadImageButton.Text = 'Load Image';

            % Create ReferenceLabel
            app.ReferenceLabel = uilabel(app.RightPanel);
            app.ReferenceLabel.FontWeight = 'bold';
            app.ReferenceLabel.Position = [172 708 63 22];
            app.ReferenceLabel.Text = 'Reference';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main_gui_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end