function [sys,x0,str,ts] = lab3_wahadlo(t, x, u, flag, L, m, fi0)
    switch flag
        case 0
            [sys, x0, str, ts] = mdlInitializeSizes(L, m, fi0); % Initialization
        case 2
            sys = mdlUpdate(t, x, u, L);
        case { 1, 3, 4, 9 }
            sys = []; % Unused flags
        otherwise
            error(['Unhandled flag = ',num2str(flag)]); % Error handling
    end
end
%==============================================================
function [sys,x0,str,ts] = mdlInitializeSizes(L, m, fi0)
    % Call function simsizes to create the sizes structure.
    sizes = simsizes;
    % Load the sizes structure with the initialization information.
    sizes.NumContStates= 0;
    sizes.NumDiscStates= 0;
    sizes.NumOutputs= 0;
    sizes.NumInputs= 1;
    sizes.DirFeedthrough=1;
    sizes.NumSampleTimes=1;
    % Load the sys vector with the sizes information.
    sys = simsizes(sizes);
    x0 = []; % No continuous states
    str = []; % No state ordering
    ts = [0 0]; % Inherited sample time
    Inicjalizacja(L, m, fi0);
end
%==============================================================
function sys = mdlUpdate(t, x, u, L)
    fig = get_param(gcbh,'UserData');
    if ishandle(fig)
        ud = get(fig,'UserData');
        % Aktualizacja rysunku
        set(ud.s, 'XData', -L*sin(u), 'YData', -L*cos(u)) ;
        set(ud.p, 'XData', [0 -L*sin(u)], 'YData', [0 -L*cos(u)]) ;
        drawnow
        pause(0.01)
    end
    sys = [];
end
%==============================================================
function Inicjalizacja(L, m, fi0)
    close all
    FigureName = 'Wizualizacja wahadla';
    Fig = figure('Name', FigureName);
    fi0 = fi0 * pi / 180;
    % Pierwsze rysowanie wahadła
    p = plot([0 -L*sin(fi0)],[0 -L*cos(fi0)],'Color','r','LineWidth',2);
    hold on
    s = plot(-L*sin(fi0), -L*cos(fi0), 'b.','MarkerSize',5*m);
    hold off
    % Ustawienia osi
    axis([-1.1*L 1.1*L -1.1*L 1.1*L])
    set(gca,'DataAspectRatio',[1 1 1])
    set(gca,'XTick',[-L 0 L],'YTick',[-L 0 L])
    % Zapamiętanie uchwytów na wykresy
    FigUD.p = p;
    FigUD.s = s;
    set(Fig,'UserData',FigUD);
    set_param(gcbh,'UserData',Fig);
end