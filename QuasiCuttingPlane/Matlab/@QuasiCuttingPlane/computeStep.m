% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function d = computeStep(Q,f)

% Check size
if length(size(f)) ~= 2   || ...
   size(f,1)       ~= Q.m || ...
   size(f,2)       ~= 1
  error('QuasiCuttingPlane: Invalid input to computeStep(f).  Input f must be a column vector of length %d for this object.',Q.m);
end

% NEED TO FILL IN
d = zeros(Q.n,1);

end