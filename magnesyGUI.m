classdef magnesyGUI < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                  matlab.ui.Figure
        ai                        matlab.ui.control.EditField
        SiaEditFieldLabel         matlab.ui.control.Label
        di                        matlab.ui.control.EditField
        OdlegoodXYEditFieldLabel  matlab.ui.control.Label
        xi                        matlab.ui.control.EditField
        WektorXEditFieldLabel     matlab.ui.control.Label
        yi                        matlab.ui.control.EditField
        WektorYEditFieldLabel     matlab.ui.control.Label
        y10                       matlab.ui.control.NumericEditField
        ystartoweEditFieldLabel   matlab.ui.control.Label
        x10                       matlab.ui.control.NumericEditField
        xstartoweEditFieldLabel   matlab.ui.control.Label
        m                         matlab.ui.control.NumericEditField
        MasakulkiEditFieldLabel   matlab.ui.control.Label
        l                         matlab.ui.control.NumericEditField
        DugoEditFieldLabel        matlab.ui.control.Label
        k                         matlab.ui.control.NumericEditField
        TumienieLabel             matlab.ui.control.Label
        DEFAULTButton             matlab.ui.control.Button
        STARTButton               matlab.ui.control.Button
        g                         matlab.ui.control.NumericEditField
        GrawitacjaLabel           matlab.ui.control.Label
        twodimensions             matlab.ui.control.UIAxes
        threedimensions           matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: STARTButton
        function STARTButtonPushed(app, event)
            m = app.m.Value;
            l = app.l.Value;
            k = app.k.Value;
            g = app.g.Value;
            x10 = app.x10.Value;
            y10 = app.y10.Value;

            set_param('lab8/Subsystem', 'ai', app.ai.Value);
            set_param('lab8/Subsystem', 'di', app.di.Value);
            set_param('lab8/Subsystem', 'xi', app.xi.Value);
            set_param('lab8/Subsystem', 'yi', app.yi.Value);
            set_param('lab8/Subsystem', 'm', num2str(m));
            set_param('lab8/Subsystem', 'l', num2str(l));
            set_param('lab8/Subsystem', 'k', num2str(k));
            set_param('lab8/Subsystem', 'g', num2str(g));
            set_param('lab8/Subsystem', 'x10', num2str(x10));
            set_param('lab8/Subsystem', 'y10', num2str(y10));
            out = sim("lab8");
            x = out.x;
            y = out.y;

            ai = str2num(app.ai.Value);
            di = str2num(app.di.Value);
            xi = str2num(app.xi.Value);
            yi = str2num(app.yi.Value);

            z = l - sqrt(l.^2 - x.^2 - y.^2);
        
            for i = 1:length(x)
                hold(app.twodimensions, 'off');
                plot(app.twodimensions, x(1:i), y(1:i), 'black');
                hold(app.twodimensions, 'on');
                for j = 1: length(xi)
                    plot(app.twodimensions, xi(j), yi(j), 'r.', 'MarkerSize', 20);
                end
                hold(app.twodimensions, 'off');
                app.twodimensions.XLim = [-3 3];
                app.twodimensions.YLim = [-3 3];
                
                hold(app.threedimensions, 'off');
                plot3(app.threedimensions, x(i), y(i), z(i), 'black.', 'MarkerSize', 40)
                hold(app.threedimensions, 'on');
                plot3(app.threedimensions, [0, x(i)], [0, y(i)], [l, z(i)], 'blue', 'LineWidth', 2)
                for j = 1: length(xi)
                    plot3(app.threedimensions, xi(j), yi(j), di(j), 'r.', 'MarkerSize', 20);
                end
                hold(app.threedimensions, 'off');
                app.threedimensions.XLim = [-0.75 * l 0.75 * l];
                app.threedimensions.YLim = [-0.75 * l 0.75 * l];
                pause(0.01);
            end
        end

        % Button pushed function: DEFAULTButton
        function DEFAULTButtonPushed(app, event)
            app.y10.Value = -1;
            app.x10.Value = -1;
            app.m.Value = 2;
            app.l.Value = 4;
            app.ai.Value = '[1 -1 1.5]';
            app.di.Value = '[0.1 0.1 0.1]';
            app.yi.Value = '[1 1 -1]';
            app.xi.Value = '[-1 1 1]';
            app.k.Value = 1;
            app.g.Value = 9.81;
            app.x10.Value = 0;
            app.y10.Value = 0;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 794 593];
            app.UIFigure.Name = 'MATLAB App';

            % Create threedimensions
            app.threedimensions = uiaxes(app.UIFigure);
            title(app.threedimensions, 'Wizualizacja 3D')
            xlabel(app.threedimensions, 'X')
            ylabel(app.threedimensions, 'Y')
            zlabel(app.threedimensions, 'Z')
            app.threedimensions.Position = [396 169 386 403];

            % Create twodimensions
            app.twodimensions = uiaxes(app.UIFigure);
            title(app.twodimensions, 'Wizualizacja 2D')
            xlabel(app.twodimensions, 'X')
            ylabel(app.twodimensions, 'Y')
            zlabel(app.twodimensions, 'Z')
            app.twodimensions.Position = [12 168 385 404];

            % Create GrawitacjaLabel
            app.GrawitacjaLabel = uilabel(app.UIFigure);
            app.GrawitacjaLabel.Position = [16 125 65 22];
            app.GrawitacjaLabel.Text = 'Grawitacja:';

            % Create g
            app.g = uieditfield(app.UIFigure, 'numeric');
            app.g.Position = [137 125 100 22];

            % Create STARTButton
            app.STARTButton = uibutton(app.UIFigure, 'push');
            app.STARTButton.ButtonPushedFcn = createCallbackFcn(app, @STARTButtonPushed, true);
            app.STARTButton.Position = [17 50 220 23];
            app.STARTButton.Text = 'START';

            % Create DEFAULTButton
            app.DEFAULTButton = uibutton(app.UIFigure, 'push');
            app.DEFAULTButton.ButtonPushedFcn = createCallbackFcn(app, @DEFAULTButtonPushed, true);
            app.DEFAULTButton.Position = [17 17 220 23];
            app.DEFAULTButton.Text = 'DEFAULT';

            % Create TumienieLabel
            app.TumienieLabel = uilabel(app.UIFigure);
            app.TumienieLabel.Position = [16 89 60 22];
            app.TumienieLabel.Text = 'Tłumienie:';

            % Create k
            app.k = uieditfield(app.UIFigure, 'numeric');
            app.k.Position = [137 89 100 22];

            % Create DugoEditFieldLabel
            app.DugoEditFieldLabel = uilabel(app.UIFigure);
            app.DugoEditFieldLabel.Position = [289 125 52 22];
            app.DugoEditFieldLabel.Text = 'Długość:';

            % Create l
            app.l = uieditfield(app.UIFigure, 'numeric');
            app.l.Position = [415 125 91 22];

            % Create MasakulkiEditFieldLabel
            app.MasakulkiEditFieldLabel = uilabel(app.UIFigure);
            app.MasakulkiEditFieldLabel.Position = [289 89 61 22];
            app.MasakulkiEditFieldLabel.Text = 'Masa kulki:';

            % Create m
            app.m = uieditfield(app.UIFigure, 'numeric');
            app.m.Position = [415 89 91 22];

            % Create xstartoweEditFieldLabel
            app.xstartoweEditFieldLabel = uilabel(app.UIFigure);
            app.xstartoweEditFieldLabel.Position = [289 51 93 22];
            app.xstartoweEditFieldLabel.Text = 'x startowe:';

            % Create x10
            app.x10 = uieditfield(app.UIFigure, 'numeric');
            app.x10.Position = [415 51 91 22];

            % Create ystartoweEditFieldLabel
            app.ystartoweEditFieldLabel = uilabel(app.UIFigure);
            app.ystartoweEditFieldLabel.Position = [289 18 63 22];
            app.ystartoweEditFieldLabel.Text = 'y startowe:';

            % Create y10
            app.y10 = uieditfield(app.UIFigure, 'numeric');
            app.y10.Position = [415 18 91 22];

            % Create WektorYEditFieldLabel
            app.WektorYEditFieldLabel = uilabel(app.UIFigure);
            app.WektorYEditFieldLabel.Position = [548 89 57 22];
            app.WektorYEditFieldLabel.Text = 'Wektor Y:';

            % Create yi
            app.yi = uieditfield(app.UIFigure, 'text');
            app.yi.Position = [659 89 110 22];

            % Create WektorXEditFieldLabel
            app.WektorXEditFieldLabel = uilabel(app.UIFigure);
            app.WektorXEditFieldLabel.Position = [547 125 57 22];
            app.WektorXEditFieldLabel.Text = 'Wektor X:';

            % Create xi
            app.xi = uieditfield(app.UIFigure, 'text');
            app.xi.Position = [659 125 110 22];

            % Create OdlegoodXYEditFieldLabel
            app.OdlegoodXYEditFieldLabel = uilabel(app.UIFigure);
            app.OdlegoodXYEditFieldLabel.Position = [547 51 97 22];
            app.OdlegoodXYEditFieldLabel.Text = 'Odległość od XY:';

            % Create di
            app.di = uieditfield(app.UIFigure, 'text');
            app.di.Position = [659 51 110 22];

            % Create SiaEditFieldLabel
            app.SiaEditFieldLabel = uilabel(app.UIFigure);
            app.SiaEditFieldLabel.Position = [548 18 28 22];
            app.SiaEditFieldLabel.Text = 'Siła:';

            % Create ai
            app.ai = uieditfield(app.UIFigure, 'text');
            app.ai.Position = [659 18 110 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = magnesyGUI

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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