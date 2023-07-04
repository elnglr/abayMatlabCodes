%{ 
Matrisin türünü belirleyen fonksiyon.

type_of_the_matrix = MatrixType(matrix)
%}

function type_of_the_matrix = MatrixType(matrix)
    n = length(matrix); type_of_the_matrix = [];
    main_minors = MainMinorCalculator(matrix);
    primary_minors = PrimaryMinorsCalculator(matrix);
    
    negative_definite_vec = [];
    for i = 1 : length(primary_minors(1,:))
        negative_definite_vec = [negative_definite_vec (-1)^primary_minors(1,i) * primary_minors(2,i)];
    end
    
    negative_semi_definite_vcec = [];
    for i = 1 : length(main_minors(1,:))
        negative_semi_definite_vcec = [negative_semi_definite_vcec (-1)^main_minors(1,i) * main_minors(2,i)];
    end
    
    disp(matrix);
    fprintf("Bu matristen elde edilen\n\nTemel Minörler;\n---------------\n");
    for i = 1 : n
        fprintf(" >> %d. dereceden temel minörler: ", i);
        index = main_minors(1,:) == i;
        disp(main_minors(2,index));
    end
    fprintf("Öncü Temel Minörler;\n--------------------\n");
    for i = 1 : n
        fprintf(" >> %d. dereceden öncü temel minör: ", i);
        indx = primary_minors(1,:) == i;
        disp(primary_minors(2,indx));
    end
    fprintf("\n");
    
    if sum(primary_minors(2,:) > 0) == length(primary_minors(2,:))
        fprintf(" >>> Sonuç olarak bu matris POZİTİF TANIMLIdır... ");
        type_of_the_matrix = [type_of_the_matrix "PT"];
    elseif sum(negative_definite_vec > 0) == length(negative_definite_vec)
        fprintf(" >>> Sonuç olarak bu matris NEGATİF TANIMLIdır... ");
        type_of_the_matrix = [type_of_the_matrix "NT"];
    end

    if isempty(type_of_the_matrix) == 0 
        if sum(main_minors(2,:) >= 0) == length(main_minors(2,:))
            fprintf("Aynı zamanda, POZİTİF YARI TANIMLIdır...\n\n");
            type_of_the_matrix = [type_of_the_matrix "PYT"];
        elseif sum(negative_semi_definite_vcec >= 0) == length(negative_semi_definite_vcec)
            fprintf("Aynı zamanda, NEGATİF YARI TANIMLIdır...\n\n");
            type_of_the_matrix = [type_of_the_matrix "NYT"];
        end
    else
        if sum(main_minors(2,:) >= 0) == length(main_minors(2,:))
            fprintf(" >>> Sonuç olarak bu matris POZİTİF YARI TANIMLIdır...\n\n");
            type_of_the_matrix = [type_of_the_matrix "PYT"];
        elseif sum(negative_semi_definite_vcec >= 0) == length(negative_semi_definite_vcec)
            fprintf(" >>> Sonuç olarak bu matris NEGATİF YARI TANIMLIdır...\n\n");
            type_of_the_matrix = [type_of_the_matrix "NYT"];
        end
    end

    if isempty(type_of_the_matrix) == 1
        fprintf(" >>> Sonuç olarak bu matris TANIMSIZdır...\n\n");
        type_of_the_matrix = [type_of_the_matrix "TSZ"];
    end

    for i = 1 : 2 - length(type_of_the_matrix)
        type_of_the_matrix = [type_of_the_matrix "NaN"];
    end

    fprintf("================================================================================================\n")
end