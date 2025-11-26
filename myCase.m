classdef myCase < handle

    properties

        run
        mesh
        fields = struct();
        oldFields

    end

    methods

        function addField(thisCase, newField)

            thisCase.fields.(newField.name) = newField;

        end

        function fieldArray = getFieldList(fields)

            fieldArray = struct2cell(fields);

        end

    end

end