classdef Convection < myPatch

    properties

        alpha
        external_temperature

    end

    methods

        function thisPatch = Convection(alpha, external_temperature)

            thisPatch.alpha = alpha;
            thisPatch.external_temperature = external_temperature;

        end

        function [aCoeficients, bCoeficients] = applyBC(obj, thisFace, aCoeficients, bCoeficients)

            aCoeficients(thisFace.owner.id,thisFace.owner.id) = aCoeficients(thisFace.owner.id,thisFace.owner.id) + thisFace.areaMagnitude*thisFace.patch_obj.alpha;
            bCoeficients(thisFace.owner.id)                   = bCoeficients(thisFace.owner.id)                   + thisFace.areaMagnitude*thisFace.patch_obj.alpha*thisFace.patch_obj.external_temperature;

        end

    end

end