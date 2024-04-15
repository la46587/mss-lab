clc
close all
clear all

out = sim("lab6");
r = out.r;
th = out.th;

g = str2num(get_param("lab6/Subsystem", "g")); % przyspieszenie ziemskie
m1 = str2num(get_param("lab6/Subsystem", "m1")); % masa wahadla
m2 = str2num(get_param("lab6/Subsystem", "m2")); % masa ciezarka
r0 = str2num(get_param("lab6/Subsystem", "r0"));
th0 = str2num(get_param("lab6/Subsystem", "th0"));
