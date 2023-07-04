%{
Durağan noktaları fonksiyondaki değerlerini döndüren kod.

type_of_fixed_points = FixedPointTypes(fixed_points, f_x, x, number_of_solutions, n)
%}

function optim_vals = FixedPointTypes(fixed_points, f_x, x, number_of_solutions, n)
    optim_vals = [];
    for i = 1 : number_of_solutions
        f_x_temp = f_x;
        for j = 1 : n
            f_x_temp = subs(f_x_temp, x(j), fixed_points{j}(i));
        end
        optim_vals = [optim_vals f_x_temp];
    end
end