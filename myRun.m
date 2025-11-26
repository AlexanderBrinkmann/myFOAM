classdef myRun < handle

    properties

        startTime
        timeStep
        endTime

        currentTime
        index

        nonLinearTolerance
        maxNonLinearIterations
        linearTolerance
        maxLinearIterations

        solver

    end

end