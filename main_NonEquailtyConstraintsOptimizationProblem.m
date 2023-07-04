% Eşitlik kısıtlamalı problemlerin çözümü için yazılmış kod

clear; clc; close all;

% Değişken sayısı                    **** DEĞİŞTİRİLECEK KISIM ****
n = 2;

% Değişkenlerin tanımlanması
x = sym("x_", [1 n], 'real');

% Optimize edilecek fonksiyon        **** DEĞİŞTİRİLECEK KISIM ****
f_x = x(1)*x(2);

% Kısıt fonksiyonları                **** DEĞİŞTİRİLECEK KISIM ****
g_x = [x(1) + x(2) - 6;
    -x(1);
    -x(2)];

ProblemsWithNonEqualityConstraint(f_x, g_x, x);

%{

1)      Kısıt fonksiyonları "<=" veya "<" içerecek şekilde düzenlenip
        eşitliğin sağ tarafının 0 olması sağlanarak g_x'e girilmelidir...

2)      Bu kod "<=" veya ">=" gibi eşitsizlik kısıtlamaları için çalışmaktadır.
        
        "<" veya ">" gibi kısıtlamaları çözmek için sınırları güncelleyiniz...
        
        Örnek: "x + y < 13"  --->  "x + y <= 12.99999" olarak girilebilir.

        Örnek kısıt fonksiyonu tanımlaması;
            Kısıtlar: x + y < 6, x > 0, y <= -3
            
                =>   g_x = [x(1) + x(2) - 5.999999; 
                            -x(1); 
                            x(2) + 3];
%}


