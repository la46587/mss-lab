clc
close all
clear all

out = sim("lab6");
r = out.r;
th = out.th;

for i = 1:length(th)
    L = 2 * max(r);
    r2 = L - r(i);
    plot([-2 0], [0 0],'Color','r','LineWidth', 2)
    hold on
    plot([-2 -2], [0 -r2],'Color','r','LineWidth', 2)
    plot([0 -r(i)*sin(th(i))], [0 -r(i)*cos(th(i))],'Color','r','LineWidth', 2)
    plot(-2, -r2, 'black.','MarkerSize', 40)
    plot(0, 0, 'b.','MarkerSize', 20)
    plot(-2, 0, 'b.','MarkerSize', 20)
    plot(-r(i)*sin(th(i)), -r(i)*cos(th(i)), 'b.','MarkerSize', 20)
    hold off
    axis([-2.5 1.5 -3 1.5])
    pause(0.01)
end