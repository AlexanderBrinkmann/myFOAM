classdef myScalarField < handle & matlab.mixin.Copyable

    properties

        name
        dependant
        expression
        value

    end

    methods 

        function thisScalarField = myScalarField(foam, name, varargin)

            p = inputParser;
            addRequired(p, 'foam');
            addRequired(p, 'name');
            addParameter(p, 'dependant', false);
            addParameter(p, 'expression', []);
            addParameter(p, 'initialValue', []);
            parse(p, foam, name, varargin{:});

            thisScalarField.name = name;
            thisScalarField.dependant = p.Results.dependant;
            thisScalarField.expression = p.Results.expression;

            if ~isempty(p.Results.initialValue)

                thisScalarField.value = p.Results.initialValue;

            end

        end

    end

end