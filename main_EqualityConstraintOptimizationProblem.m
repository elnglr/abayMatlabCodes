% Eşitlik kısıtlamalı problemlerin çözümü için yazılmış kod

clear; clc; close all;

% Değişken sayısı                  **** DEĞİŞTİRİLECEK KISIM ****
n = 3;

% Değişkenlerin tanımlanması
x = sym("x_", [1 n], 'real');

% Optimize edilecek fonksiyon      **** DEĞİŞTİRİLECEK KISIM ****
f_x = x(1)^2 + x(2)^2 + x(3)^2;

% Kısıt fonksiyonları              **** DEĞİŞTİRİLECEK KISIM ****
g_x = [x(1) + 2*x(2) + x(3) - 1;
       2*x(1) - x(2) -3];

ProblemsWithEqualityConstraint(f_x, g_x, x)


%{
    NOT: Kısıt fonksiyonu eşitliğin sağ tarafı 0 olacak şekilde düzenlenip girilmeli...
    
    Örneğin, kısıt fonksiyonları x + y^2 = 2 ve 3z = -y olan bir problem için;
        g_x = [x(1) + x(2)^2 - 2; 3*x(3) + x(2)] 
%}