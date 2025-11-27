function foam = dependantFields(foam)

    fieldList = struct2cell(foam.fields);

    for i = 1:length(fieldList)

        if fieldList{i}.dependant

            fieldList{i}.value = fieldList{i}.expression(foam);

        end

    end

end