classdef InternalSource < myPatch

    properties

        value

    end

    methods

        function thisPatch = InternalSource(value)

            thisPatch.value = value;

        end

        function [aCoeficients, bCoeficients] = applyBC(obj, thisCell, aCoeficients, bCoeficients)

            bCoeficients(thisCell.id) = bCoeficients(thisCell.id) + obj.value * thisCell.volume;
            
        end

    end

end