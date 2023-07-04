%{
Eşitsizlik kısıtlamalı problemi çözen fonkksiyon.

ProblemsWithNonEqualityConstraint(f_x, g_x, x)
%}

function ProblemsWithNonEqualityConstraint(f_x, g_x, x)

    % progressFunc(0.1)

    if length(x) > 1

        nonlineer_constraints = [];
        for i = 1 : length(g_x)
            nonlineer_elements = isLinear(g_x(i), x);
            if isempty(nonlineer_elements) == 0
                nonlineer_constraints = [nonlineer_constraints i];
            end
        end
        
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
            if isempty(g_x) == 0
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
            end

            fprintf("\n\n");
        
            optim_vals = FixedPointTypes(fixed_points, f_x, x, number_of_solutions, n);

            [~, optim_max_indx] = max(optim_vals);
            
            fprintf("\nElde edilen durağan noktalar için fonksiyon değerleri:\n\n");
            for i = 1 : number_of_solutions
                fprintf(" >> f(");
                for j = 1 : n
                    if j ~= n
                        fprintf("%.3f, ",fixed_points{j}(i));
                    else
                        fprintf("%.3f)",fixed_points{j}(i));
                    end
                end
                fprintf(" = %.3f\n",optim_vals(i));
            end

            fprintf("\n --> Optimum çözüm: [");
            for i = 1 : n
                if i ~= n
                    fprintf("%.3f, ",fixed_points{i}(optim_max_indx));
                else
                    fprintf("%.3f]\n",fixed_points{i}(optim_max_indx));
                end
            end

        else
            fprintf("\nGirilen fonksiyonun bu kısıtlar altında bir çözümü mevcut değildir!\n\n");
        end

        if isempty(nonlineer_constraints) == 0
            fprintf("\n****************************************************************************************\n")
            fprintf("Bulunan çözüm hatalıdır...\n");
            fprintf("Khun Tucker koşulları sadece lineer kısıtlı optimizasyon problemlerini çözmektedir!\n\n");
            fprintf("Non-Lineer kısıtlar: "); disp(nonlineer_constraints);
            fprintf("****************************************************************************************\n")
        end
    else
        fprintf("\nBu kod çok değişkenli fonksiyonlar için çalışmaktadır!\n\n");
    end
    fprintf("\n");
end

