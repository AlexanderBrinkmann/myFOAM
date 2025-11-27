function residual = calculateResidual(foam)

    fieldList = struct2cell(foam.fields);
    oldFieldList = struct2cell(foam.oldFields);

    for i = 1:length(fieldList)

        if ~fieldList{i}.dependant
            delta(i) = max(abs(fieldList{i}.value - oldFieldList{i}.value), [], 'all');
        end

    end

    residual = max(delta);

end