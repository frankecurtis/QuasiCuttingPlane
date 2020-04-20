% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function gamma = computeValue(Q,F,a)

% Check size
if length(size(F)) ~= 2   || ...
   size(F,1)       ~= Q.m || ...
   size(F,2)       ~= 1
  error('QuasiCuttingPlane: Invalid input to computeValue(F).  Input F must be a column vector of length %d for this object.',Q.m);
end

% Feed forward
[~,gamma] = Q.feedForward(F,a);

end