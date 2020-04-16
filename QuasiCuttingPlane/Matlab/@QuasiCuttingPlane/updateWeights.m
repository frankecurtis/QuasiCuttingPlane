% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function updateWeights(Q,F,J)

% Check size
if length(size(F)) ~= 2   || ...
   size(F,1)       ~= Q.m || ...
   size(F,2)       ~= 1
  error('QuasiCuttingPlane: Invalid input to updateWeights(F,J).  Input F must be a column vector of length %d for this object.',Q.m);
end
% Check size
if length(size(J)) ~= 2   || ...
   size(J,1)       ~= Q.m || ...
   size(J,2)       ~= Q.n
  error('QuasiCuttingPlane: Invalid input to updateWeights(F,J).  Input J must be a matrix of size %d-by-%d for this object.',Q.m,Q.n);
end

% Feed forward
[d,gamma] = Q.feedForward(F);

% Evaluate loss derivatives
[ga,gW] = Q.evaluateLossDerivatives(F,J,d,gamma);

% Run line search
Q.runLineSearch(F,J,d,gamma,ga,gW)

% Check verbosity
if Q.verbosity >= 2, Q.printData; end

end