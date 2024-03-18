clc
close all
clear all

out = sim("lab3");
fi = out.fi;

L = str2num(get_param("lab3/Subsystem", "l"));
m = str2num(get_param("lab3/Subsystem", "m"));
fi0 = str2num(get_param("lab3/Subsystem", "fi0"))

for i = 1:length(fi)
    plot([0 -L*sin(fi(i))],[0 -L*cos(fi(i))],'Color','r','LineWidth',2)
    hold on
    plot(-L*sin(fi(i)), -L*cos(fi(i)), 'b.','MarkerSize',5*m)
    hold off
    axis([-1.1*L 1.1*L -1.1*L 1.1*L])
    pause(0.01)
end