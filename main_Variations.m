%{  
      NOTLAR:

    -> Problem tanımı gereği g veya f; x(t), x_dot(t) ve t'nin fonksiyonu olacak 
       şekilde tanımlanmalıdır. İkinci veya daha yüksek dereceden türev içeren
       problemler için türev derecesi düşürülerek bu kod kullanılabilir...

    -> Bu kod sadece "tek fonksiyona bağlı fonksiyoneller için" çalışmaktadır...
   
    -> g = x^2 + x_dot^2 - x*x_dot ---> g = x(1)^2 + diff(x(1))^2 - x(1)*diff(x(1))
       olacak şekilde girilmelidir.

    -> size(tVals) = 1x2, size(xVals) = nx2 olmalıdır... (n: Fonksiyon sayısı)

    -> Bilinmeyen sınırlar için "NaN" veya "nan" girilmelidir...

    -> "f" şimdilik kullanılamıyor...
%}

clear; clc; close all; syms x1(t) x2(t) x3(t) t; x = [x1(t) x2(t) x3(t)];

% Sınır değerleri
tVals = [0 1]; 
xVals = [2 nan];

% Integrant
g = 0.5*diff(x(1))^2 + 0.5*x(1)^2 +diff(x(1))*x(1) +  diff(x(1));
% g = sqrt(1 + diff(x(1))^2);
g = 12*t*x(1) - diff(x(1))^2;
g = (diff(x(1)))^2/t^3;

% Kısıt fonksiyonu
% f = diff(x(2)) - x(1);
f = nan;

% Belirsiz "t_f" ve "x(t_f)" durumu için eğri tanımı
c = nan; 
% c = 0.5*(t-5)^2 - 0.5;

% Çözümün elde edilmesi
input = struct("boundaryValues", struct("tVals", tVals, "xVals", xVals), "g", g, "f", f, "c", c);
VariationsFunc(input);


% NOT: Eğer "Unrecognized function C3" hatası alırsanız MATLAB'i yeniden başlatın



