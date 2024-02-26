close all;
clc;

x = linspace(0.1, 4, 1000);

F1 = @(x) sin(x) + cos(x);
F2 = @(x) exp(x) + log(x);
F3 = @(x, y) sin(x) .* cos(y);

figure();
hold on
plot(x, F1(x));
plot(x, F2(x));
legend('sin(x) + cos(x)', 'exp(x) + log(x)')
hold off

figure();
x = linspace(-2 * pi, 2 * pi, 100);
y = linspace(-2 * pi, 2 * pi, 100);
[xx, yy] = meshgrid(x, y);
surf(xx, yy, F3(xx, yy));

x = rand(1, 7) * (5 - 2) + 2;
y = rand(1, 7) * (7 - 3) + 3;

RYSUJ(x, y);

function RYSUJ(a, b)
    figure()
    hold on
    plot(a, b, 'rsquare', 'MarkerSize', 15);
    plot(a, b, '--', 'LineWidth', 3);
end