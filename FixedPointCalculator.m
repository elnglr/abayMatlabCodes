%{
Durağan noktaları veren fonksiyon.

fixed_points = FixedPointCalculator(lagrange_function, g_x, x, lambda)
%}

function fixed_points = FixedPointCalculator(lagrange_function, g_x, x, lambda)
    problem_set = [];

    for i = 1 : length(x)
        problem_set = [problem_set; diff(lagrange_function, x(i)) == 0];
    end

    for i = 1 : length(g_x)
        problem_set = [problem_set; lambda(i)*g_x(i) == 0];
        problem_set = [problem_set; lambda(i) >= 0];
        problem_set = [problem_set; g_x(i) <= 0];
    end
    solution = solve(problem_set, [x lambda]);
    fixed_points = struct2cell(solution);
end