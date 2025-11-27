classdef (Abstract) myPatch

    methods (Abstract)

        [aCoeficients, bCoeficients] = applyBC(face);

    end

end