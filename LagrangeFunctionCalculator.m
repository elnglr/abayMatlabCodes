%{
Lagrange fonksiyonunu veren fonksiyon.

lagrange_function = LagrangeFunctionCalculator(f_x, g_x, lambda)
%}

function lagrange_function = LagrangeFunctionCalculator(f_x, g_x, lambda)
    lagrange_function = f_x;
    for i = 1 : length(g_x)
        lagrange_function = lagrange_function - lambda(i) * g_x(i);
    end
end