classdef simpleStationaryHeatflux < mySolver

    methods

        function foam = solve(obj, foam)

            T_aCoeficients = zeros(foam.mesh.cellnum);
            T_bCoeficients = zeros([foam.mesh.cellnum, 1]);


            [T_aCoeficients] = discretization_Laplacian(T_aCoeficients, foam.mesh, foam.fields.lamda.value);
            [T_aCoeficients, T_bCoeficients] = applyBoundaryConditions(foam, T_aCoeficients, T_bCoeficients);

            %foam.fields.T.value = Gauss_Seidel(T_aCoeficients, T_bCoeficients);
            foam.fields.T.value = TDMA(T_aCoeficients, T_bCoeficients);
            
        end

    end

end