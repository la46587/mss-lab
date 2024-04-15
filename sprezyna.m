clc
close all
clear all

out = sim("lab5");
r = out.r;
th = out.th;

L = str2num(get_param("lab5/Subsystem", "l"));
m = str2num(get_param("lab5/Subsystem", "m"));

xa = 0; ya = 0; xb = 2; yb = 2; ne = 10; a = 1; ro = 0.3;
[xs,ys] = spring(xa,ya,xb,yb,ne,a,ro); plot(xs,ys,'LineWidth',2)

for i = 1:length(th)
    [xs,ys]=spring(xa,ya,0 -(L + r(i))*sin(th(i)),0 -(L + r(i))*cos(th(i))); plot(xs,ys,'LineWidth',2)
    hold on
    plot(-(L + r(i))*sin(th(i)), -(L + r(i))*cos(th(i)), 'b.','MarkerSize', 5*m)
    hold off
    axis([-1.1*(L + max(r)) 1.1*(L + max(r)) -1.1*(L + max(r)) 1.1*(L + max(r))])
    pause(0.01)
end