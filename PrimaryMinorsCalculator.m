%{ 
Öncü temel minör bulan fonksiyon.

primary_minors = PrimaryMinorsCalculator(matrix)
%}

function primary_minors = PrimaryMinorsCalculator(matrix)
    primary_minors = []; n = length(matrix); minor_order = [];
    for i = 1 : n
        primary_minors = [primary_minors det(matrix(1:i, 1:i))]; 
        minor_order = [minor_order i];
    end
    primary_minors = double([minor_order; primary_minors]);
end
