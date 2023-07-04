%{
Sınırlandırılmış Hessian matris elde eden fonksiyon.

bordered_hessian_matrix = BorderedHessianMatrixCalculator(lagrange_function, g_x, x)
%}

function bordered_hessian_matrix = BorderedHessianMatrixCalculator(lagrange_function, g_x, x)

    diff_g_x = [];
    for i = 1 : length(g_x)
        diff_temp = [];
        for j = 1 : length(x)
            diff_temp = [diff_temp diff(g_x(i), x(j))];
        end
        diff_g_x = [diff_g_x; diff_temp];
    end

    diff_lagrange = sym(zeros(length(x)));
    for i = 1 : length(x)
        diff_temp_first = diff(lagrange_function, x(i));
        for  j = 1 : length(x)
            diff_lagrange(i,j) = diff(diff_temp_first, x(j));
        end
    end

    bordered_hessian_matrix = [zeros(length(g_x)) diff_g_x; transpose(diff_g_x) diff_lagrange];
end