clc
close all
clear all

out = sim("lab9");
h1 = out.h1;
h2 = out.h2;

S1 = str2num(get_param("lab9/Subsystem", "S1"));
S2 = str2num(get_param("lab9/Subsystem", "S2"));
Swy1 = str2num(get_param("lab9/Subsystem", "Swy1"));
Swy2 = str2num(get_param("lab9/Subsystem", "Swy2"));

for i = 1:length(h1)
    plot([0, 0], [0, max(h1) + 1], 'b')
    hold on
    plot([0, S1 + 1], [0, 0], 'b')
    plot([S1, S1], [Swy1, max(h1) + 1], 'b')
    plot([S1, S1 + 1], [Swy1, Swy1], 'b')
    plot([S1 + 1, S1 + S2 + 2], [0, 0], 'r')
    plot([S1 + 1, S1 + 1], [Swy1, max(h2) + 1 ], 'r')
    plot([S1 + S2 + 1, S1 + S2 + 1], [max(h2) + 1, Swy2], 'r')
    plot([S1 + S2 + 1, S1 + S2 + 2], [Swy2, Swy2], 'r')
    fill([0, S1, S1, 0], [0, 0, h1(i), h1(i)], [135/255, 205/255, 235/255], 'EdgeColor', 'none')
    fill([S1 + 1, S1 + S2 + 1, S1 + S2 + 1, S1 + 1], [0, 0, h2(i), h2(i)], [135/255, 205/255, 235/255], 'EdgeColor', 'none')
    fill([S1, S1, S1 + 1, S1 + 1], [0, Swy1, Swy1, 0], [135/255, 205/255, 235/255], 'EdgeColor', 'none')
    fill([S1 + S2 + 1, S1 + S2 + 1, S1 + S2 + 2, S1 + S2 + 2], [0, Swy2, Swy2, 0], [135/255, 205/255, 235/255], 'EdgeColor', 'none')
    hold off
    axis([-0.5 S1 + S2 + 2.5 -0.5 max(max(h1), max(h2)) + 1.5])
    pause(0.01)
end