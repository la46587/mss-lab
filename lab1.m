close all;
clc;

% Zadanie 1
x = -3:0.5:3;
y = [-0.17, -0.3, 0.6, 0.98, 0.36, -0.28, 0, 0.28, -0.36, -0.98, -0.6, 0.3, 0.17];

% Zadanie 2
yi121Linear = interp1(x, y, 1.21, 'linear');
yi121Nearest = interp1(x, y, 1.21, 'nearest');
yi121Spline = interp1(x, y, 1.21, 'spline');
yi121Cubic = interp1(x, y, 1.21, 'cubic');

fprintf('Linear: %f\n' ,yi27Linear)
fprintf('Nearest: %f\n', yi27Nearest)
fprintf('Spline: %f\n' ,yi27Spline)
fprintf('Cubic: %f\n', yi27Cubic)
% najlepsza metoda - spline (lub cubic)

% Zadanie 3
xi = -3:0.001:3;
yiNearest = interp1(x, y, xi, 'nearest');
yiLinear = interp1(x, y, xi, 'linear');
yiSpline = interp1(x, y, xi, 'spline');
yiCubic = interp1(x, y, xi, 'cubic');

figure
hold on
plot(x, y, 'blacko')
plot(xi, yiNearest, 'cyan')
plot(xi, yiLinear, 'yellow')
plot(xi, yiSpline, 'blue')
plot(xi, yiCubic, 'red')
legend('points', 'nearest', 'linear', 'spline', 'cubic')
hold off
% najlepsza metoda - spline (lub cubic)

% Zadanie 4
xp = linspace(-3, 3, 1000);

p1 = polyfit(x, y, 1);
yp1 = polyval(p1, xp);

p2 = polyfit(x, y, 2);
yp2 = polyval(p2, xp);

p3 = polyfit(x, y, 3);
yp3 = polyval(p3, xp);

p4 = polyfit(x, y, 4);
yp4 = polyval(p4, xp);

p5 = polyfit(x, y, 5);
yp5 = polyval(p5, xp);

p6 = polyfit(x, y, 6);
yp6 = polyval(p6, xp);

p7 = polyfit(x, y, 7);
yp7 = polyval(p7, xp);

p8 = polyfit(x, y, 8);
yp8 = polyval(p8, xp);

p9 = polyfit(x, y, 9);
yp9 = polyval(p9, xp);

p10 = polyfit(x, y, 10);
yp10 = polyval(p10, xp);

p11 = polyfit(x, y, 11);
yp11 = polyval(p11, xp);

p12 = polyfit(x, y, 12);
yp12 = polyval(p12, xp);

figure
tiledlayout(3, 4)
nexttile
hold on
plot(xp, yp1, 'r')
plot(x, y, 'blacko')
title('stopień 1')
hold off
nexttile
hold on
plot(xp, yp2, 'r')
plot(x, y, 'blacko')
title('stopień 2')
hold off
nexttile
hold on
plot(xp, yp3, 'r')
plot(x, y, 'blacko')
title('stopień 3')
hold off
nexttile
hold on
plot(xp, yp4, 'r')
plot(x, y, 'blacko')
title('stopień 4')
hold off
nexttile
hold on
plot(xp, yp5, 'r')
plot(x, y, 'blacko')
title('stopień 5')
hold off
nexttile
hold on
plot(xp, yp6, 'r')
plot(x, y, 'blacko')
title('stopień 6')
hold off
nexttile
hold on
plot(xp, yp7, 'r')
plot(x, y, 'blacko')
title('stopień 7')
hold off
nexttile
hold on
plot(xp, yp8, 'r')
plot(x, y, 'blacko')
title('stopień 8')
hold off
nexttile
hold on
plot(xp, yp9, 'r')
plot(x, y, 'blacko')
title('stopień 9')
hold off
nexttile
hold on
plot(xp, yp10, 'r')
plot(x, y, 'blacko')
title('stopień 10')
hold off
nexttile
hold on
plot(xp, yp11, 'r')
plot(x, y, 'blacko')
title('stopień 11')
hold off
nexttile
hold on
plot(xp, yp12, 'r')
plot(x, y, 'blacko')
title('stopień 12')
hold off
% na oko najbardziej zbliżone są wielomiany stopnia 9 i 10

% Zadanie 5
% dla 1.21 wychodzi około -0.67, co jest najbardziej zgodne z cubic