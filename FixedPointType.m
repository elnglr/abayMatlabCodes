%{ 
Durağan noktanın türünü belirleyen fonksiyon.

type_of_the_fixed_point = FixedPointType(type_of_the_matrix)
%}

function type_of_the_fixed_point = FixedPointType(type_of_the_matrix)
    type_of_the_fixed_point = [];

    if sum(type_of_the_matrix == "NT") == 1 
        fprintf(" LOKAL MAXİMİZE EDİCİdir...");
        type_of_the_fixed_point = [type_of_the_fixed_point "LMAX"];
    elseif sum(type_of_the_matrix == "PT") == 1
        fprintf(" LOKAL MİNİMİZE EDİCİdir...");
        type_of_the_fixed_point = [type_of_the_fixed_point "LMİN"];
    end
    
    if isempty(type_of_the_fixed_point) == 0
        if sum(type_of_the_matrix == "NYT") == 1
            fprintf(" Aynı zamanda GLOBAL MAXİMİZE EDİCİdir...\n");
            type_of_the_fixed_point = [type_of_the_fixed_point "GMAX"];
        elseif sum(type_of_the_matrix == "PYT") == 1
            fprintf(" Aynı zamanda GLOBAL MİNİMİZE EDİCİdir...\n");
            type_of_the_fixed_point = [type_of_the_fixed_point "GMİN"];
        end
    else
        if sum(type_of_the_matrix == "NYT") == 1
            fprintf(" GLOBAL MAXİMİZE EDİCİdir...\n");
            type_of_the_fixed_point = [type_of_the_fixed_point "GMAX"];
        elseif sum(type_of_the_matrix == "PYT") == 1
            fprintf(" GLOBAL MİNİMİZE EDİCİdir...\n");
            type_of_the_fixed_point = [type_of_the_fixed_point "GMİN"];
        end
    end

    if isempty(type_of_the_fixed_point) == 1
        if sum(type_of_the_matrix == "TSZ") == 1
            fprintf(" bir EYER NOKTASIdır...\n")
            type_of_the_fixed_point = [type_of_the_fixed_point "SADDLE"];
        end
    end

    for i = 1 : 2 - length(type_of_the_fixed_point)
        type_of_the_fixed_point = [type_of_the_fixed_point "NaN"];
    end
end