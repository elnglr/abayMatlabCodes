% 4. dereceye kadar olan transfer fonksiyonları için integrant hesaplayan
% kod. Girdi olarak sembolik transfer fonskiyonu almaktadır, çıktı olarak
% da sembolik integrant vermektedir. "I = sym2ISE(system)"

function ISE = sym2ISE(system)
    if class(system) ~= "sym"
        ISE = NaN; fprintf("\n\n*** Only symbolic inputs! ***\n\n");
        return
    end

    syms s;
    system = collect(system,s); assignin("base", "system", system); [numSys, denSys] = numden(system);
    numSysCoeff = coeffs(numSys, s, "All"); assignin("base", "numSysCoeff", numSysCoeff);
    denSysCoeff = coeffs(denSys, s, "All"); assignin("caller", "denSysCoeff", denSysCoeff);

    if ~(length(denSysCoeff) > length(numSysCoeff))
        ISE = NaN; fprintf("\n\n*** The degree of the denominator must be greater than that of the numerator! ***\n\n")
        return
    end
    
    c = [flip(numSysCoeff) zeros(1, length(denSysCoeff) - length(numSysCoeff))];
    d = flip(denSysCoeff);
    degree = length(denSysCoeff) - 1;

    switch degree
        case 1
            ISE = c(0 + 1)^2 / (2*d(0 + 1)*d(1 + 1));
        case 2
            ISE = ((c(1 + 1)^2)*d(0 + 1) + (c(0 + 1)^2)*d(2 + 1)) / ...
                (2*d(0 + 1)*d(1 + 1)*d(2 + 1));
        case 3
            ISE = ((c(2 + 1)^2)*d(0 + 1)*d(1 + 1) + ((c(1 + 1)^2) - 2*c(0 + 1)*c(2 + 1))*d(0 + 1)*d(3 + 1) + ...
                (c(0 + 1)^2)*d(2 + 1)*d(3 + 1)) / (2*d(0 + 1)*d(3 + 1)*(-d(0 + 1)*d(3 + 1) + d(1 + 1)*d(2 + 1)));
        case 4
            ISE = ((c(3 + 1)^2)*(-(d(0 + 1)^2)*d(3 + 1) + d(0 + 1)*d(1 + 1)*d(2 + 1)) + ...
                (c(2 + 1)^2 - 2*c(1 + 1)*c(3 + 1))*d(0 + 1)*d(1 + 1)*d(4 + 1) + ...
                (c(1 + 1)^2 - 2*c(0 + 1)*c(2 + 1))*d(0 + 1)*d(3 + 1)*d(4 + 1) + ...
                ((c(0 + 1)^2)*(-d(1 + 1)*(d(4 + 1)^2) + d(2 + 1)*d(3 + 1)*d(4 + 1)))) / ...
                (2*d(0 + 1)*d(4 + 1)*(-d(0 + 1)*(d(3 + 1)^2) - (d(1 + 1)^2)*d(4 + 1) + d(1 + 1)*d(2 + 1)*d(3 + 1)));
        otherwise
            ISE = NaN; fprintf("\n\n*** Degree must be maximum 4! ***\n\n");
    end

end


