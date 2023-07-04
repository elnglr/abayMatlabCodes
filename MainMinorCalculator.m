%{ 
Temel minör bulan fonksiyon.

main_minors = MainMinorCalculator(matrix)
%}

function main_minors = MainMinorCalculator(matrix)
    main_minors = []; n = length(matrix);
    hessian_matrix_temp = matrix;
    row_col_vec = 1 : n;
    minor_order = [];
    for k = 1 : n
        empty_row_col_vec = nchoosek(row_col_vec, n-k);
        if ~isempty(empty_row_col_vec) == 1
            for i = 1 : length(empty_row_col_vec(:,1))
                hessian_matrix_temp(empty_row_col_vec(i,:),:) = [];
                hessian_matrix_temp(:,empty_row_col_vec(i,:)) = [];
                main_minors = [main_minors det(hessian_matrix_temp)];
                hessian_matrix_temp = matrix;
                minor_order = [minor_order k];
            end
        else
            main_minors = double([main_minors det(hessian_matrix_temp)]);
            minor_order = [minor_order n];
        end
    end
    main_minors = double([minor_order; main_minors]);
end