% Kısıtlamasız optimizasyon problemlerinin çözümü

clear; clc; close all;

% Değişken sayısı  **** DEĞİŞTİRİLECEK KISIM ****
n = 2;

% Değişkenlerin tanımlanması
x = sym("x_", [1 n], 'real');

% Optimize edilecek fonksiyon  **** DEĞİŞTİRİLECEK KISIM ****
f_x = x(1)^2 - x(1)*x(2) + x(2)^2 + 3*x(1) - 2*x(2) +1;

NoConstraitProblem(f_x, x, n);


