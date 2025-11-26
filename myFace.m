classdef myFace < handle
    %

    properties
        
        id
        points
        owner
        neighbour

        patch_name
        patch_obj

        areaMagnitude
        areaVector
        normalVector
        centre

    end

    methods
        
        function thisFace = myFace(points, varargin)

            p = inputParser;
            addRequired(p, 'points');
            addParameter(p, 'id', []);
            addParameter(p, 'owner', []);
            addParameter(p, 'neighbour', []);
            addParameter(p, 'patch', []);
            parse(p, points, varargin{:});

            thisFace.points = points;
            thisFace.id = p.Results.id;
            thisFace.owner = p.Results.owner;
            thisFace.neighbour = p.Results.neighbour;
            thisFace.patch_name = p.Results.patch;


            % Calcualte face apex-point or the average of the face vertices
            apex = zeros([1, 3]);

            for i = 1:length(points)

                apex = apex + points(i).coordinates;

            end

            apex = apex/i;


            % As stated in Section 3.3, the face is divided in triangles to
            % calculate the geometric properties of a generic polyhedral
            % shape
            triangleAreaVector = zeros([length(points), 3]);
            triangleCentre = zeros([length(points), 3]);

            for i = 1:length(points)
                
                next = mod(i, length(points)) + 1;

                A = points(next).coordinates - points(i).coordinates;
                B = apex - points(i).coordinates;
                triangleAreaVector(i,:) = cross(A,B)/2;

                triangleCentre(i,:) = (points(next).coordinates + points(i).coordinates + apex)/3;

            end

            % The individual triangles are put together to calculate the
            % face properties
            thisFace.areaVector = zeros([1, 3]);
            thisFace.centre = zeros([1, 3]);

            for i = 1:length(triangleAreaVector)

                thisFace.areaVector = thisFace.areaVector + triangleAreaVector(i,:);
                thisFace.centre = thisFace.centre + norm(triangleAreaVector(i,:))*triangleCentre(i,:);

            end

            thisFace.centre = thisFace.centre/norm(thisFace.areaVector); %if I put areMagnitude will it work??
            thisFace.areaMagnitude = norm(thisFace.areaVector);
            thisFace.normalVector = thisFace.areaVector/thisFace.areaMagnitude;

        end
    end

end