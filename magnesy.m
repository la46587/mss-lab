clc
close all
clear all

out = sim("lab8");
x = out.x;
y = out.y;
l = str2num(get_param("lab8/Subsystem", "l"));
m = str2num(get_param("lab8/Subsystem", "m"));
xi = str2num(get_param("lab8/Subsystem", "xi"));
yi = str2num(get_param("lab8/Subsystem", "yi"));
ai = str2num(get_param("lab8/Subsystem", "ai"));
di = str2num(get_param("lab8/Subsystem", "di"));

z = l - sqrt(l.^2 - x.^2 - y.^2);

for i = 1:length(x)
    hold off
    plot3(x(i), y(i), z(i), 'black.', 'MarkerSize', 40)
    hold on
    plot3([0, x(i)], [0, y(i)], [l, z(i)], 'blue', 'LineWidth', 2)
    plot3(x(1:i), y(1:i), z(1:i), 'magenta', 'LineWidth', 1)
    plot3(xi(1), yi(1), di(1), 'r.', 'MarkerSize', 20)
    plot3(xi(2), yi(2), di(2), 'g.', 'MarkerSize', 20)
    plot3(xi(3), yi(3), di(3), 'b.', 'MarkerSize', 20)
    hold off
    axis([-1.2 1.5 -1.2 1.5])
    pause(0.01)
end