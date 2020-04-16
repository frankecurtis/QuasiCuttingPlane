% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function d = computeStep(Q,F)

% Check size
if length(size(F)) ~= 2   || ...
   size(F,1)       ~= Q.m || ...
   size(F,2)       ~= 1
  error('QuasiCuttingPlane: Invalid input to computeStep(F).  Input F must be a column vector of length %d for this object.',Q.m);
end

% Feed forward
[d,~] = Q.feedForward(F);

end