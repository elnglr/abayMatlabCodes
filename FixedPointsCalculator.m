%{ 
Durağan noktaları elde eden fonksiyon.

fixed_points = FixedPointsCalculator(f_x, x)
%}

function fixed_points = FixedPointsCalculator(f_x, x)
    diff_vec = []; 
    prob_vec = [];
    for i = 1 : length(x)
        diff_temp = diff(f_x, x(i));
        diff_vec = [diff_vec; diff_temp];
        prob_vec = [prob_vec; diff_temp == 0];
    end
    solution = solve(prob_vec);
    if isempty(solution) == 0
        fixed_points = struct2cell(solution);
    else
        fixed_points = [];
    end
end