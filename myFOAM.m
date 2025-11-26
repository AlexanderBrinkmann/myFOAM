function myFOAM(thisMesh)

    foam = controlDict();
    foam.mesh = thisMesh;
    foam = setUpCase(foam);


    foam.run.currentTime = foam.run.startTime;
    
    while foam.run.currentTime < foam.run.endTime

        foam.run.index = (foam.run.currentTime - foam.run.startTime)/foam.run.timeStep + 1;
        fprintf('Current time: %d, index: %d. \n', foam.run.currentTime, foam.run.index)

        nonLinearConverged = false;
        nonLinearIteration = 0;

        while ~nonLinearConverged && nonLinearIteration < foam.run.maxNonLinearIterations

            nonLinearIteration = nonLinearIteration + 1;
            foam.oldFields = structfun(@copy, foam.fields, 'UniformOutput', false);

            %how should historic values of fields be stored, to later plot
            %them/analyze?
            
            foam = dependantFields(foam);
            foam = foam.run.solver.solve(foam);

            residual = calculateResidual(foam);
  
            if residual < foam.run.nonLinearTolerance
      
                nonLinearConverged = true;
            
            end

        end
        
        fprintf('Exited non-linear loop after %d iterations, with <strong>%s</strong> convergence. Residual: %d.\n \n', nonLinearIteration, mat2str(nonLinearConverged), residual)

        foam.run.currentTime = foam.run.currentTime + foam.run.timeStep;

    end

    disp('Finished!')

end