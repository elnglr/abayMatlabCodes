function nonlineer_elements = isLinear(g_x, x)
    nonlineer_elements = [];
    for i = 1 : length(x)
        diff_i = diff(g_x, x(i));
        temp = 0;
        for j = 1 : length(x)
            diff_ii = diff(diff_i, x(j));
            if diff_ii ~= sym(0)
                temp = temp + 1;
            end
        end
        if temp ~= 0
            nonlineer_elements = [nonlineer_elements x(i)];
        end
    end
end

