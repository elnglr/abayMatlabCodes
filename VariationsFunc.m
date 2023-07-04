function VariationsFunc(input)

    fprintf("\t\t\t\t~~~ ABAY PRODUCTION ~~~\n");
    fprintf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n\n");

    syms x1(t) x2(t) x3(t) t; x = [x1(t) x2(t) x3(t)];

    % Euler Equation Function
    EulerEq = @(g, x) diff(g, x) - diff(diff(g, diff(x)), t);

    % Boundary Values
    tVals = input.boundaryValues.tVals;
    xVals = input.boundaryValues.xVals;

    % Variable Number
    varNumber = length(xVals(:,1)); 
    varNumberError = sum(size(tVals) == [1 2]) == 2;
    err = ~isnan(tVals(1)) && sum(isnan(xVals(:, 1))) == 0;

    % Integrant and constrint functions
    g = input.g;
    f = input.f;
    c = input.c;

    x_t = [];
    if varNumberError
        if isnan(f)
    
            % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
            % Sınır değerlerinin belli olduğu durum
            % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
            if ~isnan(tVals(2)) && sum(isnan(xVals(:, 2))) == 0 && err
                if varNumber == 1
                    EulerEquation = EulerEq(g, x(1));
                    eqSet = [EulerEquation == 0; ...
                             subs(x(1), t, tVals(1)) == xVals(1); ...
                             subs(x(1), t, tVals(2)) == xVals(2)];
                    xTemp = vpa(dsolve(eqSet), 4);
                    x_t = [x_t; xTemp];
        
                    fprintf(">>> Euler Equation: "); disp(EulerEquation == 0);
                    x_opt = vpa(dsolve(EulerEq(g, x(1)) == 0), 4); fprintf("    ~~> x_optimum(t) = "); disp(x_opt); 
                    fprintf("Equation Set:\n-------------\n"); 
                    pretty(vpa([subs(x_opt, t, tVals(1)) == xVals(1); subs(x_opt, t, tVals(2)) == xVals(2)], 4));
                    fprintf("Solution:\n---------\n")
                    for j = 1 : length(xTemp)
                        fprintf(" --> x(t) = "); disp(vpa(xTemp(j), 4));
                    end
                    fprintf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n\n");
                else
                    EulerEquationSet = []; BoundaryValSet = [];
                    for i = 1 : varNumber
                        EulerEquationTemp = EulerEq(g, x(i)); 
                        EulerEquationSet = [EulerEquationSet; EulerEquationTemp == 0];
                        fprintf(">>> Euler Equation %d: ", i); disp(EulerEquationTemp == 0);
    
                        BoundaryValTemp = [subs(x(i), t, tVals(1)) == xVals(i, 1); ...
                                           subs(x(i), t, tVals(2)) == xVals(i, 2)];
                        BoundaryValSet = [BoundaryValSet; BoundaryValTemp];
                    end
                    eqSet = [EulerEquationSet; BoundaryValSet];
                    xTemp = vpa(dsolve(eqSet), 4);
                    x_t = [x_t; xTemp];
                    
                    x_opt = vpa(EulerEquationSet(i), 4);
                    for i = 1 : varNumber
                        fprintf("    ~~> x_%d_optimum(t) = ", i); disp(x_opt(i)); 
                    end
                    fprintf("Equation Set:\n-------------\n"); prettySet = [];
                    for i = 1 : varNumber
                        prettySet = subs(x_opt(i), t, tVals(1)) == xVals(i, 1); subs(x_opt(i), t, tVals(2)) == xVals(i, 2);
                    end
                    pretty(vpa([subs(x_opt, t, tVals(1)) == xVals(1); subs(x_opt, t, tVals(2)) == xVals(2)], 4));
                    fprintf("Solution:\n---------\n")
                    for j = 1 : length(xTemp)
                        fprintf(" --> x(t) = "); disp(vpa(xTemp(j), 4));
                    end
                    fprintf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n\n");
                end

            % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
            % x(t_final) belirsiz olduğu durum
            % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
            elseif ~isnan(tVals(2)) && sum(isnan(xVals(:, 2))) == length(xVals(:, 2)) && err
                if varNumber == 1
                    EulerEquation = EulerEq(g, x(1));
                    transversaliteCond = subs(diff(g, diff(x(1))), t, tVals(2)) == 0;  % Transversalite koşulu
                    eqSet = [EulerEquation == 0; ...
                             subs(x(1), t, tVals(1)) == xVals(1); ...
                             transversaliteCond];
                    xTemp = vpa(dsolve(eqSet), 4);
                    x_t = [x_t; xTemp];
        
                    fprintf(">>> Euler Equation: "); disp(EulerEquation == 0);
                    x_opt = vpa(dsolve(EulerEq(g, x(1)) == 0), 4); fprintf("    ~~> x_optimum(t) = "); disp(x_opt); 
                    fprintf("Equation Set:\n-------------\n"); 
                    pretty(vpa([subs(x_opt, t, tVals(1)) == xVals(1); transversaliteCond], 4));
                    fprintf("Solution:\n---------\n")
                    for j = 1 : length(xTemp)
                        fprintf(" --> x(t) = "); disp(vpa(xTemp(j), 4));
                    end
                    fprintf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n\n");
                else
                    fprintf("\n\n*** Birden fazla fonksiyona bağlı fonksiyoneller için sınır değerleri bilinmelidir! ***\n\n")
                end
    
    
            % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
            % t_final belirsiz olduğu durum
            % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
            elseif isnan(tVals(2)) && sum(isnan(xVals(:, 2))) == 0 && err
                if varNumber == 1
                    syms t_f positive real; syms C1 C2 real
                    EulerEquation = EulerEq(g, x(1)); x_opt = dsolve(EulerEquation == 0);
                    temp = subs(g - diff(g, diff(x(1))) * diff(x(1)), x(1), x_opt);
                    transversaliteCond = subs(temp, t, t_f) == 0;  % Transversalite koşulu
                    eqSet = [subs(x_opt, t, tVals(1)) == xVals(1); ...
                             subs(x_opt, t, t_f) == xVals(2); ...
                             transversaliteCond]; solution = vpasolve(eqSet);
                    C1_val = solution.C1; C2_val = solution.C2; t_f_val = solution.t_f; solNumber = length(C1_val); 
                    assignin("base", 'C1_val', C1_val); assignin("base", 'C2_val', C2_val); 
                    assignin("base", 't_f_val', t_f_val); assignin("base", 'solNumber', length(C1_val));
                    for j = 1 : solNumber
                        xTemp = vpa(subs(subs(x_opt, C1, C1_val(j)), C2, C2_val(j)), 4); x_t = [x_t; xTemp];
                    end
                    
                    fprintf(">>> Euler Equation: "); disp(EulerEquation == 0); fprintf("    ~~> x_optimum(t) = "); disp(x_opt);
                    fprintf("Equation Set:\n-------------\n"); pretty(vpa(eqSet, 4)); fprintf("Solution:\n---------\n")
                    for j = 1 : length(xTemp)
                        fprintf(" --> x(t) = "); disp(vpa(xTemp(j), 4));
                    end
                    fprintf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n\n");
                else
                    fprintf("\n\n*** Birden fazla fonksiyona bağlı fonksiyoneller için sınır değerleri bilinmelidir! ***\n\n")
                end
    
    
            % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
            % Hem t_final hem de x(t_final) belirsiz olduğu durum
            % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
            elseif isnan(tVals(2)) && sum(isnan(xVals(:, 2))) == length(xVals(:, 2)) && err && ~isnan(c)
                if varNumber == 1
                    syms t_f positive real; syms x_f C1 C2 real
                    EulerEquation = EulerEq(g, x(1));
                    x_opt = dsolve(EulerEquation == 0);
                    temp = subs(g + diff(g, diff(x(1))) * (diff(c) - diff(x(1))), x(1), x_opt);
                    transversaliteCond = subs(temp, t, t_f) == 0;
                    eqSet = [subs(x_opt, t, tVals(1)) == xVals(1); ...
                             subs(x_opt, t, t_f) == x_f; ...
                             transversaliteCond;
                             subs(c, t, t_f) == x_f];
                    solution = vpasolve(eqSet);
                    C1_val = solution.C1; C2_val = solution.C2; 
                    t_f_val = solution.t_f; x_f_val = solution.x_f; solNumber = length(C1_val);
                    assignin("base", 'C1_val', C1_val); assignin("base", 'C2_val', C2_val);  
                    assignin("base", 't_f_val', t_f_val); assignin("base", 'solNumber', length(C1_val));
                    for j = 1 : solNumber
                        xTemp = vpa(subs(subs(x_opt, C1, C1_val(j)), C2, C2_val(j)), 4);
                        x_t = [x_t; xTemp];
                    end
                    
                    fprintf(">>> Euler Equation: "); disp(EulerEquation == 0); fprintf("    ~~> x_optimum(t) = "); disp(x_opt);
                    fprintf("Equation Set:\n-------------\n"); pretty(vpa(eqSet, 4)); fprintf("Solution:\n---------\n")
                    for j = 1 : length(x_t)
                        fprintf(" --> x(t) = "); disp(vpa(x_t(j), 4));
                    end
                    fprintf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n\n");
                else
                    fprintf("\n\n*** Birden fazla fonksiyona bağlı fonksiyoneller için sınır değerleri bilinmelidir! ***\n\n")
                end
    
            % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
            % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
            else
                if ~err
                    fprintf("\n\n*** Başlangıç sınır değerleri bilinmelidir! ***\n\n");
                elseif isnan(tVals(2)) && sum(isnan(xVals(:, 2))) == length(xVals(:, 2)) && err && isnan(c)
                    fprintf("\n\n*** Bilinmeyen 't_f' ve 'x(t_f)' durumu için 'c' tanımlanmalıdır! ***\n\n");
                else
                    fprintf("\n\n*** Sınır değerleri homojen olmalıdır! ***\n\n");
                end
            end
    
        % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
        % *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
        else
            if ~isnan(tVals(2)) && sum(isnan(xVals(:, 2))) == 0 && err
                g_A = g; syms lambda_1(t) lambda_2(t) lambda_3(t); lambda = [lambda_1(t) lambda_2(t) lambda_3(t)];
                for i = 1 : length(f)
                    g_A = g_A + lambda(i) * f(i);
                end
                EulerEquationSet = []; boundaryValSet = [];
                for i = 1 : varNumber
                    EulerEquation = EulerEq(g_A, x(i)); 
                    boundaryVals = [subs(x(i), t, tVals(1)) == xVals(i, 1); ...
                                    subs(x(i), t, tVals(2)) == xVals(i, 2)];
                    EulerEquationSet = [EulerEquationSet; EulerEquation];
                    boundaryValSet = [boundaryValSet; boundaryVals];
                end
                eqSet = [EulerEquationSet == 0; ...
                         boundaryValSet;
                         f == 0];
                xSet = vpa(dsolve(eqSet), 4);
                x_t = [x_t; xSet];
    
                fprintf(">>> Euler Equations:\n"); disp(EulerEquationSet == 0);
                % x_optSet = vpa(dsolve(EulerEquationSet == 0), 4); fprintf("    ~~> x_optimum(t):\n"); disp(x_optSet); 
                fprintf("Equation Set:\n-------------\n"); disp(vpa(eqSet, 4))
                % pretty(vpa([subs(x_optSet, t, tVals(1)) == xVals(1); subs(x_optSet, t, tVals(2)) == xVals(2)], 4));
                % for i = 1 : varNumber
                %     pretty(vpa([subs(x(i), t, tVals(1)) == xVals(i, 1); subs(x(i), t, tVals(2)) == xVals(i, 2)], 4));
                % end
                % fprintf("Solution:\n---------\n"); disp(x_t);
                % for i = 1 : varNumber
                %     for j = 1 : length(xTemp(i))
                %         fprintf(" --> x(t) = "); disp(vpa(xTemp(j), 4));
                %     end
                % end
                fprintf("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n\n");
                
            end
        end
    else
        fprintf("\n\n*** size(tVals) = [1 2] ve size(xVals) = [n 2] olmalıdır! ***\n\n\n")
    end
    

    assignin("base", 'x_t', x_t);

    
end