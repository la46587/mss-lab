clc
close all
clear all

out = sim("lab7");
th1 = out.th1;
th2 = out.th2;

l1 = str2num(get_param("lab7/Subsystem", "l1"));
l2 = str2num(get_param("lab7/Subsystem", "l2"));
m1 = str2num(get_param("lab7/Subsystem", "m1"));
m2 = str2num(get_param("lab7/Subsystem", "m2"));

x1 = -l1 * sin(th1);
y1 = -l1 * cos(th1);
x2 = x1 - l2 * sin(th2);
y2 = y1 - l2 * cos(th2);

for i = 1:length(th1)
    plot([0 x1(i)], [0 y1(i)],'Color','black','LineWidth', 2)
    hold on
    plot([x1(i) x2(i)], [y1(i) y2(i)], 'Color', 'black', 'LineWidth', 2)
    plot(x1(i), y1(i), 'b.','MarkerSize', 20*m1)
    plot(x2(i), y2(i), 'r.', 'MarkerSize', 20*m2)
    hold off
    axis([-1.1*(l1 + l2) 1.1*(l1 + l2) -1.1*(l1 + l2) 1.1*(l1 + l2)])
    pause(0.01)
end