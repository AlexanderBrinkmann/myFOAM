function [aCoeficients, bCoeficients] = applyBoundaryConditions(foam, aCoeficients, bCoeficients)

    %Loop through faces
    for f = 1:length(foam.mesh.faceList)

        if ~(isempty(foam.mesh.faceList(f).patch_obj))

            [aCoeficients, bCoeficients] = foam.mesh.faceList(f).patch_obj.applyBC(foam.mesh.faceList(f), aCoeficients, bCoeficients);

        end

    end


    %Loop through cells
    for c = 1:length(foam.mesh.cellList)

        if ~(isempty(foam.mesh.cellList(c).patch_obj))

            [aCoeficients, bCoeficients] = foam.mesh.cellList(c).patch_obj.applyBC(foam.mesh.cellList(c), aCoeficients, bCoeficients);

        end

    end

end