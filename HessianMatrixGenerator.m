%{ 
Hessian matrix elde eden fonksiyon.

hessian_matrix = HessianMatrixGenerator(f_x, x)
%}

function hessian_matrix = HessianMatrixGenerator(f_x, x)
    hessian_matrix = sym(zeros(length(x)));
    for i = 1 : length(x)
        diff_temp_first = diff(f_x, x(i));
        for  j = 1 : length(x)
            hessian_matrix(i,j) = diff(diff_temp_first, x(j));
        end
    end
end