clc
clear
close all

out = sim("lab4");
x = out.x;
y = out.y;

R = str2num(get_param("lab4/Subsystem", "R"));
rs = str2num(get_param("lab4/Subsystem", "rs"));

for i = 1:length(x)
    plot(x(1:i), y(1:i))
    axis([-8, 8, -8, 8])
    daspect([1, 1, 1])
    hold on
    rectangle('Position', [x(i) - rs, y(i) - rs, 2*rs, 2*rs], 'Curvature', [1 1])
    rectangle('Position', [0 - R, 0 - R, 2*R, 2*R], 'Curvature', [1 1])
    hold off
    pause(2^(-7))
end