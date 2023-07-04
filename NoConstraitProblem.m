%{ 
Kısıtlamasız optimizasyonunu çözen fonksiyon.

NoConstraitProblem(f_x, x, n)
%}

function NoConstraitProblem(f_x, x, n)
    if length(x) > 1 
        % Durağan noktaların elde edilmesi ve yazdırılması
        fixed_points = FixedPointsCalculator(f_x, x); 
        if isempty(fixed_points) == 0
            number_of_solutions = length(fixed_points{1});
        else
            number_of_solutions = 0;
        end
        if number_of_solutions ~= 0
            fprintf("\t\t\t\t ~~ ABAY PRODUCTION ~~\n\n");
            fprintf(">>> Durağan noktalar: ")
            for i = 1 : number_of_solutions
                fprintf("[");
                for j = 1 : n
                    if j ~= n
                        fprintf("%.3f, ",fixed_points{j}(i));
                    elseif i ~= number_of_solutions
                        fprintf("%.3f], ",fixed_points{j}(i));
                    else
                        fprintf("%.3f]",fixed_points{j}(i));
                    end
                end
            end
            fprintf("\n\n");
            
            % Hessian matrixin elde edilmesi ve yazdırılması
            hessian_matrix = HessianMatrixGenerator(f_x, x);
            fprintf("Verilen fonksiyon için elde edilen Hessian matris;\n");
            disp(hessian_matrix);
            
            % Çözümlerin Hessian matriste yerine konulması
            hessian_matrix_group = []; 
            for i = 1 : number_of_solutions
                hessian_matrix_group = [hessian_matrix_group hessian_matrix];
            end
            for i = 1 : number_of_solutions
                for j = 1 : length(x)
                    hessian_matrix_group(:,n*(i-1)+1:n*i) = subs(hessian_matrix_group(:,n*(i-1)+1:n*i), x(j), fixed_points{j}(i));
                end
            end
            if isnumeric(hessian_matrix_group) == 1
                calculated_hessian_matrix = double(hessian_matrix_group);
            else
                calculated_hessian_matrix = hessian_matrix_group;
            end
            
            % Temel ve öncü temel minörlerin elde edilmesi
            main_minors = []; primary_minors = [];
            for i = 1 : number_of_solutions
                main_minors = double([main_minors; MainMinorCalculator(calculated_hessian_matrix(:,n*(i-1)+1:n*i))]);
                primary_minors = double([primary_minors; PrimaryMinorsCalculator(calculated_hessian_matrix(:,n*(i-1)+1:n*i))]);
            end
            
            types_of_hessian_matrices = []; type_of_the_fixed_points = [];
            for i = 1 : number_of_solutions
                fprintf("================================================================================================\n")
                fprintf("%d. durağan nokta için elde edilen Hessian matris;\n\n", i);
                hessian_matrix_i = vpa(hessian_matrix_group(:,n*(i-1)+1:n*i), 4);
                type_of_the_matrix = MatrixType(hessian_matrix_i);
                types_of_hessian_matrices = [types_of_hessian_matrices; type_of_the_matrix];
            end
            fprintf("\nDolayısıyla,\n")
            for i = 1 : length(types_of_hessian_matrices(:,1))
                fprintf(" >>> %d. durağan nokta: [", i);
                for j = 1 : n
                    if j ~= n
                        fprintf("%.3f ",fixed_points{j}(i));
                    else
                        fprintf("%.3f]",fixed_points{j}(i));
                    end
                end
                type_of_the_fixed_point = FixedPointType(types_of_hessian_matrices(i,:));
                type_of_the_fixed_points = [type_of_the_fixed_points; type_of_the_fixed_point];
            end
        else
            fprintf("\nGirilen fonksiyonun reel bir durağan noktası bulunmamaktadır!\n\n");
        end
    else
        fprintf("\nBu kod çok değişkenli fonksiyonlar için çalışmaktadır!\n\n");
    end
    fprintf("\n");
end
