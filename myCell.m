classdef myCell < handle

    properties

        id
        faces

        patch_cell

        fields

        centre
        volume

    end

    methods

        function thisCell = myCell(faces, varargin)

            p = inputParser;
            addRequired(p, 'faces');
            addParameter(p, 'id', []);
            addParameter(p, 'patch', []);
            addParameter(p, 'fields', []);
            parse(p, faces, varargin{:});

            thisCell.faces = faces;
            thisCell.id = p.Results.id;
            thisCell.patch_cell = p.Results.patch;
            thisCell.fields = p.Results.fields;

%% %%%%%%%%%%%%%

            % --- Step 1: Calculate an initial approximate cell centre (mean of face centers) ---
    approx_centre = zeros([1, 3]);
    for i = 1:length(faces)
        approx_centre = approx_centre + faces(i).centre;
    end
    approx_centre = approx_centre / length(faces);

    
    % --- Step 2: Check and Correct the Face Normal Direction (Must point outward) ---
    for i = 1:length(faces)
        
        % Vector pointing FROM face center TO the approximate cell center (Inward Vector)
        v_inward = approx_centre - faces(i).centre; 
        
        % Check the dot product of the face normal (areaVector) and the Inward Vector.
        % If the dot product is POSITIVE, the areaVector is pointing INWARD (incorrect).
        if dot(faces(i).areaVector, v_inward) > 0
            
            % Correction: Reverse the area vector and the face vertices list 
            % (Assuming face storage includes vertices which need reversal for consistency)
            faces(i).areaVector = -faces(i).areaVector;
            faces(i).normalVector = -faces(i).normalVector;
            % NOTE: If faces(i) is a struct/object, this might need more careful handling
            % (e.g., if it's a handle or needs manual update of properties).
            % Assuming for this example, the assignment works.
            
        end
    end


    %% %%%%%%


            % Again, section 3.3
            thisCell.volume = 0;
            thisCell.centre = zeros([1, 3]);

            for i = 1:length(faces)

                thisCell.volume = thisCell.volume + dot(faces(1,i).areaVector, (faces(1,i).centre));
                thisCell.centre = thisCell.centre + faces(1,i).areaVector*norm(faces(1,i).centre)^2;

            end

            thisCell.volume = thisCell.volume/3;
            thisCell.centre = thisCell.centre/(2*thisCell.volume);

        end

    end

end