function foam = setUpCase(foam)

    % Initialize fields (to be written by the user)
    %
    % Example:
    %
    %   T = myScalarField(foam, 'name', 'T', 'dependant', false)
    %   foam.fields.T = T;
    %
    %   lamda_expr = @(foam) foam.fields.T.value .^2;
    %   lamda = myScalarField(foam, 'name', 'lamda', 'dependant', true, ...
    %       ... 'expresion', lamda_expr)
    %   foam.fields.(lamda.name) = lamda;
    %
    %
    % ? Maybe in the future add possibility of initializing already
    %   existing fields from previous case/run


    T = myScalarField(foam, 'T', 'dependant', false, 'initialValue', ones([foam.mesh.cellnum, 1]));
    foam.fields.T = T;
    
    %lamda_expr = @(foam) foam.fields.T.value .*2;
    lamda = myScalarField(foam, 'lamda', 'dependant', false, 'initialValue', 50*ones([foam.mesh.cellnum, 1]));
    foam.fields.(lamda.name) = lamda;


    % attach patch objects to each patch

    for f = 1:length(foam.mesh.faceList)
        if ~isempty(foam.mesh.faceList(f).patch_name)
        switch foam.mesh.faceList(f).patch_name
            case 'adiabatic'
                foam.mesh.faceList(f).patch_obj = FixedGradient(0);
            case 'convectionHot'
                foam.mesh.faceList(f).patch_obj = Convection(250, 20);
            case 'convectionCold'
                foam.mesh.faceList(f).patch_obj = Convection(250, 10);
            case 'fixedT'
                foam.mesh.faceList(f).patch_obj = FixedValue(100);
            case ''  % internal face
                % do nothing
            otherwise
                warning('Unknown patch type: %s', foam.mesh.faceList(f).patch_name);
        end
        end
    end

end