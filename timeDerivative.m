function [aCoeficients, bCoeficients] = timeDerivative(oldField, timeStep, offset_coefficient, oldTerms)
% offset_coefficient [0-1]:
%       1 means it is treated implicitly
%       0 means it is treated explicitly
%       0.5 makes use of the Crank-Nicholson scheme

    aCoeficients = offset_coefficient*eye(size(oldField))/timeStep;
    bCoeficients = offset_coefficient*oldField/timeStep;

    bCoeficients = bCoeficients + (1-offset_coefficient)*oldTerms;
    % remains to be seen what this oldTerms are

end