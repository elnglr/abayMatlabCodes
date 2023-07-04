%{
Eşitlik kısıtlamalı problemi çözen fonkksiyon.

ProblemsWithEqualityConstraint(f_x, g_x, x)
%}

function ProblemsWithEqualityConstraint(f_x, g_x, x)
    if length(x) > 1 
        n = length(x); m =length(g_x);
        lambda = sym("lambda_", [1 m], 'real');

        fprintf("\t\t\t\t ~~ ABAY PRODUCTION ~~\n");

        lagrange_function = LagrangeFunctionCalculator(f_x, g_x, lambda);

        fprintf("\nLagrange fonksiyonu: "); disp(lagrange_function)
    
        fixed_points = FixedPointCalculator(lagrange_function, g_x, x, lambda);
        if isempty(fixed_points) == 0
            number_of_solutions = length(fixed_points{1});
        else
            number_of_solutions = 0;
        end

        if number_of_solutions ~= 0 
            fprintf("\n>>> Durağan noktalar: ")
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
            fprintf("\n\n    --> Durağan noktalar için elde edilen lambda değerleri (sırasıyla): ");
            for i = 1 : number_of_solutions
                fprintf("[");
                for j = n + 1 : n + m
                    if j ~= n + m
                        fprintf("%.3f, ",fixed_points{j}(i));
                    elseif i ~= number_of_solutions
                        fprintf("%.3f], ",fixed_points{j}(i));
                    else
                        fprintf("%.3f]",fixed_points{j}(i));
                    end
                end
            end

            fprintf("\n\n");
        
            bordered_hessian_matrix = BorderedHessianMatrixCalculator(lagrange_function, g_x, x);
            fprintf("Verilen fonksiyon için elde edilen Sınırlandırılmış Hessian matris;\n");
            disp(bordered_hessian_matrix);
            
            bordered_hessian_matrix_group = []; 
            for i = 1 : number_of_solutions
                bordered_hessian_matrix_group = [bordered_hessian_matrix_group bordered_hessian_matrix];
            end
            for i = 1 : number_of_solutions
                for j = 1 : n
                    bordered_hessian_matrix_group(:, (n + m)*(i-1)+1:(n + m)*i) = subs(bordered_hessian_matrix_group(:, (n + m)*(i-1)+1:(n + m)*i), x(j), fixed_points{j}(i));
                end
                for j = 1 : m
                    bordered_hessian_matrix_group(:, (n + m)*(i-1)+1:(n + m)*i) = subs(bordered_hessian_matrix_group(:, (n + m)*(i-1)+1:(n + m)*i), lambda(j), fixed_points{n+j}(i));
                end
            end
            if isnumeric(bordered_hessian_matrix_group) == 1
                calculated_hessian_matrix = double(bordered_hessian_matrix_group);
            else
                calculated_hessian_matrix = bordered_hessian_matrix_group;
            end
            
            fprintf("===================================================================================\n\n");
            type_of_fixed_points_vec = [];
            for i = 1 : number_of_solutions
                fprintf(" >> %d. durağan nokta için elde edilen Sınırlandırılmış Hessian Matrix: \n\n", i);
                disp(vpa(bordered_hessian_matrix_group(:, (n + m)*(i-1)+1:(n + m)*i), 4));
                fprintf("Bu Sınırlandırılmış Hessian Matristen elde edilen alt matrisler:\n\n");
           
                hessian_matrix_i = calculated_hessian_matrix(:, (n + m)*(i-1)+1:(n + m)*i);
                type_of_fixed_points = FixedPointTypes(hessian_matrix_i, n, m);
                type_of_fixed_points_vec = [type_of_fixed_points_vec; type_of_fixed_points];

                fprintf("\n===================================================================================\n\n");
            end

            fprintf("Sonuç olarak;\n\n")

            for i = 1 : number_of_solutions
                fprintf(" >> [")
                for j = 1 : n
                    if j ~= n
                        fprintf("%.3f, ",fixed_points{j}(i));
                    else
                        fprintf("%.3f] ",fixed_points{j}(i));
                    end
                end
                if type_of_fixed_points_vec(i) == "LMIN"
                    fprintf("noktası LOKAL MİNİMUMLAŞTIRICIdır...\n");
                elseif  type_of_fixed_points_vec(i) == "LMAX"
                    fprintf("noktası LOKAL MAXİMUMLAŞTIRICIdır...\n");
                elseif type_of_fixed_points_vec(i) == "SADDLE"
                    fprintf("noktası EYER NOKTASIdır...\n");
                end
            end
            fprintf("\n");
        else
            fprintf("\nGirilen fonksiyonun reel bir durağan noktası bulunmamaktadır!\n\n");
        end
    else
        fprintf("\nBu kod çok değişkenli fonksiyonlar için çalışmaktadır!\n\n");
    end
    fprintf("\n");
end

