function foam = controlDict()

    run = myRun();
    run.startTime = 0;
    run.timeStep = 0.1;
    run.endTime = 0.1;

    run.solver = simpleStationaryHeatflux;

    run.nonLinearTolerance = 1e-6;
    run.maxNonLinearIterations = 100;
    run.linearTolerance = 1e-8;
    run.maxLinearIterations = 1000;

    foam = myCase();
    foam.run = run;

end