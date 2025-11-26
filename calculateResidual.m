function residual = calculateResidual(foam)

    fieldList = struct2cell(foam.fields);
    oldFieldList = struct2cell(foam.oldFields);

    for i = 1:length(fieldList)

        if ~fieldList{i}.dependant
            delta = max(abs(fieldList{i}.value - oldFieldList{i}.value));
        end

    end

    residual = max(abs(delta));

end