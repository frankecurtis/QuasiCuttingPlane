% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function alpha = updateWeights(Q,F,J,a)

% Check size of F
if length(size(F)) ~= 2   || ...
   size(F,1)       ~= Q.m || ...
   size(F,2)       <  1
  error('QuasiCuttingPlane: Invalid input to updateWeights(F,J).  Input F must be a matrix with %d rows for this object.',Q.m);
end

% Check size of J
if length(size(J)) ~= 2   || ...
   size(J,1)       ~= Q.m || ...
   size(J,2)       ~= Q.n
  error('QuasiCuttingPlane: Invalid input to updateWeights(F,J).  Input J must be a matrix of size %d-by-%d for this object.',Q.m,Q.n);
end

% Evaluate loss derivatives
gW = Q.evaluateLossDerivatives(F,J,a);

% Run line search
alpha = Q.runLineSearch(F,J,a,gW);

% Check verbosity
if Q.verbosity >= 2, Q.printData; end

end