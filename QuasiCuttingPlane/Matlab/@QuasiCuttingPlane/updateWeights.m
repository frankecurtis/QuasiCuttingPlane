% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function alpha = updateWeights(Q,F,J,a)

% Evaluate loss derivatives
gW = Q.evaluateLossDerivatives(F,J,a);

% Run line search
alpha = Q.runLineSearch(F,J,a,gW);

% Check verbosity
if Q.verbosity >= 2, Q.printData; end

end