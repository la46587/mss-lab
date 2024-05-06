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

a = sqrt(x.^2 + y.^2);
b = sqrt(l.^2 - a.^2);
z = l - b;

for i = 1:length(x)
    plot3([0, x(i)], [0, y(i)], [l, z(i)], 'blue', 'LineWidth', 2)
    hold on
    plot3(xi(1), yi(1), di(1), 'r.', 'MarkerSize', 20)
    plot3(xi(2), yi(2), di(2), 'g.', 'MarkerSize', 20)
    plot3(xi(3), yi(3), di(3), 'b.', 'MarkerSize', 20)
    plot3(x(i), y(i), z(i), 'black.', 'MarkerSize', 40)
    hold off
    axis([-1.2 1.5 -1.2 1.5])
    pause(0.01)
end