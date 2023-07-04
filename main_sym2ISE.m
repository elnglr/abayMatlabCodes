clear; clc; close all;

syms s K tau

% Açık çevrim tf'nin tanımlanması
Gs_ol_sym = (K/(s)) / (1 + (K/(s))*(tau*s + 1)); 

% Girişin tanımlanması
R_sym = 1/s;

% Hata ifadesinin tanımlanması
E_sym = R_sym / (1 + Gs_ol_sym);
pretty(E_sym);

% Integral tablosu kullanılarak ISE kriterinin elde edilmesi
ISE = sym2ISE(E_sym);
pretty(ISE);

