function aCoeficients = discretization_Laplacian(aCoeficients, thisMesh, diffusivity)
% Builds the [A] coeficient matrix for the Laplacian term in the equation
% to solve the desired field. Diffusivity is the Laplacian coeficient that
% appears in the equation.
%
% Right now it only applies for when the face is orthogonal between the
% cells. Non-orthogonal correction is not implemented yet.

    for f = 1:length(thisMesh.faceList)
    
        thisFace = thisMesh.faceList(f);
        owner = thisFace.owner;
        neighbour = thisFace.neighbour;

        if isempty(thisFace.patch_name)

            faceDiffusivity = interpolation(diffusivity, thisFace);
    
            C_delta = 1/norm(thisFace.neighbour.centre - thisFace.owner.centre);

            aCoeficients(owner.id, neighbour.id) = thisFace.areaMagnitude*faceDiffusivity*C_delta;
            aCoeficients(neighbour.id, owner.id) = aCoeficients(owner.id, neighbour.id);

        end

    end
    
    for i = 1:size(aCoeficients,1)
    
        for j = 1:size(aCoeficients,2)
    
            if i ~= j
                
                % claro, esto de momento es solo para Laplacian terms
                aCoeficients(i,i) = aCoeficients(i,i) - aCoeficients(i,j);
    
            end
    
        end
    
    end

end