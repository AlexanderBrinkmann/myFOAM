classdef myPoint < handle
    % myPoint: Because deep down, everything in the universe is just a 
    % slightly confused point trying to figure out where the hell it is.
    %
    % It has coordinates (obviously), a dimension (so it knows whether 
    % it's lost in flatland or having an existential crisis in 7D) [sadly, 
    % it can only exist in a 3D space], and an optional 'id' field for 
    % when it gets a name tag at the cosmic party.
    %
    % If you don't give it an id, it will quietly sulk with an empty one 
    % and judge you in silence. Points have feelings too, you monster.

    properties

        id
        coordinates

    end

    methods

        function thisPoint = myPoint(coordinates, varargin)

            p = inputParser;
            addRequired(p, 'coordinates', @isnumeric);
            addParameter(p, 'id', []);
            parse(p, coordinates, varargin{:});

            thisPoint.coordinates = coordinates(1,:);
            thisPoint.id = p.Results.id;

        end

    end

end